import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/meter_data.dart';
import '../models/app_settings.dart';
import '../services/command_service.dart';
import '../services/connection_manager.dart';
import '../services/esp32_api.dart';
import '../services/storage_service.dart';

class AppState extends ChangeNotifier {
  final Esp32Api api;
  final StorageService storage;
  late final ConnectionManager connection;
  late final CommandService commands;

  MeterData? meter;
  AppSettings? settings;
  bool online = false;
  bool commandBusy = false;
  String message = '';

  AppState(this.api, this.storage) {
    connection = ConnectionManager(api);
    commands = CommandService(api);
  }

  void start() {
    connection.start((m) {
      meter = m;
      online = connection.online;
      notifyListeners();
    });
    loadSettings();
  }

  Future<void> loadSettings() async {
    try { settings = await api.settings(); notifyListeners(); } catch (_) {}
  }

  Future<bool> inverter(String command) async {
    commandBusy = true; message = 'Sending $command...'; notifyListeners();
    try {
      final ok = await commands.sendAndConfirm(command);
      message = ok ? '$command confirmed by feedback' : '$command feedback timeout';
      return ok;
    } catch (e) {
      message = 'Command failed: $e';
      return false;
    } finally {
      commandBusy = false; notifyListeners();
    }
  }

  @override void dispose() {
    connection.dispose();
    super.dispose();
  }
}
