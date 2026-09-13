import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<void> setPassword(String value) async =>
      (await SharedPreferences.getInstance()).setString('app_password', value);

  Future<String?> password() async =>
      (await SharedPreferences.getInstance()).getString('app_password');

  Future<void> setEndpoint(String value) async =>
      (await SharedPreferences.getInstance()).setString('endpoint', value);

  Future<String> endpoint() async =>
      (await SharedPreferences.getInstance()).getString('endpoint') ?? 'http://192.168.4.1';
}
