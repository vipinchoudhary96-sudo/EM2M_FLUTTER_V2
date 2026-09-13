import 'dart:async';
import 'esp32_api.dart';

class CommandService {
  final Esp32Api api;
  CommandService(this.api);

  Future<bool> sendAndConfirm(String command) async {
    await api.inverter(command);
    final deadline = DateTime.now().add(const Duration(seconds: 5));
    while (DateTime.now().isBefore(deadline)) {
      final s = await api.status();
      final wanted = command.toUpperCase();
      if (s.inverterActual.toUpperCase() == wanted && s.feedbackConfirmed) return true;
      await Future.delayed(const Duration(milliseconds: 250));
    }
    return false;
  }
}
