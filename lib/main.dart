import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_state.dart';
import 'services/esp32_api.dart';
import 'services/storage_service.dart';
import 'theme/app_theme.dart';
import 'screens/dashboard_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(Esp32Api(), StorageService())..start(),
      child: const Em2mApp(),
    ),
  );
}

class Em2mApp extends StatelessWidget {
  const Em2mApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'EM2M Controller V2',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    themeMode: ThemeMode.system,
    home: const DashboardScreen(),
  );
}
