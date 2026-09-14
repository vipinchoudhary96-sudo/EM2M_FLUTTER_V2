import 'dart:async';
import 'esp32_api.dart';
import '../models/meter_data.dart';

class ConnectionManager {
  final Esp32Api api;
  Timer? timer;
  bool online = false;
  MeterData? latest;

  ConnectionManager(this.api);

  void start(void Function(MeterData?) onUpdate) {
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      try {
        latest = await api.status();
        online = true;
        onUpdate(latest);
      } catch (_) {
        online = false;
        onUpdate(latest);
      }
    });
  }

  void dispose() => timer?.cancel();
}
