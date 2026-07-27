import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_core/super_core.dart' as core;
import 'package:super_dialog/super_dialog.dart';

void main() {
  test('GeniusLink theme preset exposes the expected design tokens', () {
    expect(SuperDialogThemeData.light.accentColor, const Color(0xFF4A7CFF));
    expect(SuperDialogThemeData.light.cardRadius, 8);
    expect(SuperDialogThemeData.light.controlRadius, 4);
    expect(
      SuperDialogThemeData.light.config.openDuration,
      const Duration(milliseconds: 200),
    );
    expect(
      SuperDialogThemeData.light.config.closeDuration,
      const Duration(milliseconds: 150),
    );
  });

  testWidgets('theme fallback inherits the active Material accent', (
    tester,
  ) async {
    const accent = Color(0xFF1DB88A);
    late SuperDialogThemeData resolved;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          colorScheme: const ColorScheme.light(primary: accent),
        ),
        home: Builder(
          builder: (context) {
            resolved = SuperDialogThemeData.of(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(resolved.accentColor, accent);
  });

  testWidgets('theme adapter reads SuperThemeData from super_core', (
    tester,
  ) async {
    late SuperDialogThemeData resolved;
    final theme = core.SuperMaterialThemeData.light(
      palette: core.SuperPalette.greenPalette,
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Builder(
          builder: (context) {
            resolved = SuperDialogThemeData.of(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(resolved.accentColor, core.SuperPalette.greenPalette.primary);
    expect(resolved.surfaceColor, core.SuperThemeData.light.surface);
    expect(resolved.cardRadius, core.SuperSpacing.mobile.radiusCard);
  });

  testWidgets('SuperDialogSurface reads its registered theme extension', (
    tester,
  ) async {
    const custom = SuperDialogThemeData(
      backgroundColor: Color(0xFF010101),
      surfaceColor: Color(0xFF020202),
      inputColor: Color(0xFF030303),
      hoverColor: Color(0xFF040404),
      borderColor: Color(0xFF050505),
      strongBorderColor: Color(0xFF060606),
      foregroundColor: Color(0xFFFAFAFA),
      secondaryForegroundColor: Color(0xFFEAEAEA),
      tertiaryForegroundColor: Color(0xFFDADADA),
      disabledForegroundColor: Color(0xFFCACACA),
      accentColor: Color(0xFF123456),
      barrierColor: Color(0x88000000),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(extensions: const <ThemeExtension<dynamic>>[custom]),
        home: const Scaffold(
          body: SuperDialogSurface(
            title: 'Theme test',
            content: Text('Body'),
          ),
        ),
      ),
    );

    expect(find.text('Theme test'), findsOneWidget);
    expect(find.text('Body'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is DecoratedBox &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color == custom.surfaceColor,
      ),
      findsOneWidget,
    );
  });

  testWidgets('the route honors themed open and close durations', (
    tester,
  ) async {
    Duration? openDuration;
    Duration? closeDuration;

    const themedConfig = SuperDialogConfig(
      openDuration: Duration(milliseconds: 240),
      closeDuration: Duration(milliseconds: 110),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: <ThemeExtension<dynamic>>[
            SuperDialogThemeData.light.copyWith(config: themedConfig),
          ],
        ),
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () {
              SuperDialog.showAnimatedDialog<void>(
                context,
                (dialogContext) {
                  final route = ModalRoute.of(dialogContext)!;
                  openDuration = route.transitionDuration;
                  closeDuration = route.reverseTransitionDuration;
                  return const SuperDialogSurface(title: 'Route test');
                },
                animation: DialogAnimation.centerFade,
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pump();

    expect(openDuration, themedConfig.openDuration);
    expect(closeDuration, themedConfig.closeDuration);
  });
}
