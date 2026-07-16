import 'package:flutter/material.dart';

import 'router/app_router.dart';
import 'state/app_theme_controller.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SuperDialogExampleApp());
}

class SuperDialogExampleApp extends StatelessWidget {
  const SuperDialogExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeMode,
      builder: (context, themeMode, child) {
        return MaterialApp.router(
          title: 'Super Dialog ERP Examples',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          routerConfig: appRouter,
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final responsiveTheme = AppTheme.forWidth(
                  Theme.of(context).brightness,
                  constraints.maxWidth,
                );
                return AnimatedTheme(
                  data: responsiveTheme,
                  duration: const Duration(milliseconds: 150),
                  child: child ?? const SizedBox.shrink(),
                );
              },
            );
          },
        );
      },
    );
  }
}
