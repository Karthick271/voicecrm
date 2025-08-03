import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'RequestGo',
      routerConfig: appRouter, // Your GoRouter instance!
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system, // Or store/load from preferences
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        // All your localizations...
      ],
    );
  }
}
