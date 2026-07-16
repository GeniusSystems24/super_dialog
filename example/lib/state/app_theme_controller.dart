import 'package:flutter/material.dart';

/// Shared theme controller used by the generated route tree and app shell.
final ValueNotifier<ThemeMode> appThemeMode = ValueNotifier<ThemeMode>(
  ThemeMode.light,
);

void toggleAppTheme() {
  appThemeMode.value = appThemeMode.value == ThemeMode.light
      ? ThemeMode.dark
      : ThemeMode.light;
}
