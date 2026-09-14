import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/app_settings.dart';
import '../models/event_record.dart';
import '../models/meter_data.dart';
import '../protocol/api_paths.dart';

class Esp32Api {
  String baseUrl;
  Esp32Api({this.baseUrl = 'http://192.168.4.1'});

  Future<Map<String, dynamic>> _get(String path, {Map<String,String>? query}) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: query);
    final r = await http.get(uri).timeout(const Duration(seconds: 3));
    if (r.statusCode != 200) throw Exception('HTTP ${r.statusCode}');
    return jsonDecode(r.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> _post(String path, Map<String,String> q) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: q);
    final r = await http.post(uri).timeout(const Duration(seconds: 3));
    if (r.statusCode >= 300) throw Exception(r.body);
    return jsonDecode(r.body) as Map<String, dynamic>;
  }

  Future<MeterData> status() async => MeterData.fromJson(await _get(ApiPaths.status));
  Future<AppSettings> settings() async => AppSettings.fromJson(await _get(ApiPaths.settings));

  Future<Map<String,dynamic>> inverter(String command) =>
      _post(ApiPaths.inverter, {'command': command});

  Future<AppSettings> saveSettings(AppSettings s) async =>
      AppSettings.fromJson(await _post(ApiPaths.settings, {
        'on_voltage': s.onVoltage.toStringAsFixed(3),
        'hysteresis': s.hysteresis.toStringAsFixed(1),
        'on_delay_ms': '${s.onDelayMs}',
        'off_delay_ms': '${s.offDelayMs}',
        'auto_mode': s.autoMode ? '1' : '0',
        'feedback_timeout_ms': '${s.feedbackTimeoutMs}',
        'require_feedback': s.requireFeedback ? '1' : '0',
        'allow_remote_control': s.allowRemoteControl ? '1' : '0',
      }));

  Future<List<EventRecord>> events() async {
    final j = await _get(ApiPaths.events);
    final a = (j['events'] as List?) ?? const [];
    return a.map((e) => EventRecord.fromJson(e)).toList();
  }

  Future<List<Map<String,dynamic>>> history(DateTime from, DateTime to) async {
    final j = await _get(ApiPaths.history, query: {
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
    });
    final a = (j['records'] as List?) ?? const [];
    return a.map((e) => Map<String,dynamic>.from(e as Map)).toList();
  }
}
