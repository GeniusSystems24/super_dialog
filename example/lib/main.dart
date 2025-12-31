import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SuperDialogExampleApp());
}

class SuperDialogExampleApp extends StatefulWidget {
  const SuperDialogExampleApp({super.key});

  @override
  State<SuperDialogExampleApp> createState() => _SuperDialogExampleAppState();
}

class _SuperDialogExampleAppState extends State<SuperDialogExampleApp> {
  ThemeMode _themeMode = ThemeMode.light;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      debugLogDiagnostics: false,
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => HomeScreen(
            onThemeToggle: _toggleTheme,
            isDarkMode: _themeMode == ThemeMode.dark,
          ),
        ),
      ],
    );
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
      // Refresh the router to update the theme
      _router.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Super Dialog Examples',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: _router,
    );
  }
}
