import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';

/// The app router configuration using go_router.
///
/// This provides type-safe navigation throughout the example app.
final class AppRouter {
  AppRouter._();

  /// The router instance.
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: HomeRoute.path,
    routes: [
      GoRoute(
        path: HomeRoute.path,
        name: HomeRoute.name,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return HomeScreen(
            onThemeToggle: extra?['onThemeToggle'] as VoidCallback,
            isDarkMode: extra?['isDarkMode'] as bool? ?? false,
          );
        },
      ),
    ],
  );
}

/// Route definitions for type-safe navigation.
abstract final class HomeRoute {
  static const String path = '/';
  static const String name = 'home';
}
