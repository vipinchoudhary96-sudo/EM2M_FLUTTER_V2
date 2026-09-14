import 'esp32_api.dart';

class WifiService {
  final Esp32Api api;
  WifiService(this.api);
  Future<bool> test() async {
    try { await api.status(); return true; } catch (_) { return false; }
  }
}
