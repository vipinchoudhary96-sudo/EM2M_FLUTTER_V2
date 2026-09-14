import 'esp32_api.dart';

class WebServerService {
  final Esp32Api api;
  WebServerService(this.api);
  Future<bool> test() async {
    try { await api.status(); return true; } catch (_) { return false; }
  }
}
