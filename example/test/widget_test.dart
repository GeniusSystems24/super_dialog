import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_dialog_example/main.dart';
import 'package:super_navigation_sidebar/super_navigation_sidebar.dart';

void main() {
  testWidgets('desktop renders 64 ERP examples without an app bar', (
    tester,
  ) async {
    tester.view
      ..physicalSize = const Size(1440, 900)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SuperDialogExampleApp());
    await tester.pumpAndSettle();

    expect(find.byType(NavigationShell), findsOneWidget);
    expect(find.byType(NavigationSidebar), findsOneWidget);
    expect(find.byType(NavigationSidebarAppBar), findsNothing);
    expect(find.text('64 ERP dialog designs · 16 layout families'), findsOneWidget);
    expect(find.text('64 examples'), findsOneWidget);
    expect(find.text('ERP DIALOG DESIGN LIBRARY'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('compact layout exposes drawer controls without an app bar', (
    tester,
  ) async {
    tester.view
      ..physicalSize = const Size(390, 844)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SuperDialogExampleApp());
    await tester.pumpAndSettle();

    expect(find.byType(NavigationShell), findsOneWidget);
    expect(find.byType(NavigationSidebarAppBar), findsNothing);
    expect(find.byIcon(Icons.menu_rounded), findsOneWidget);
    expect(find.text('64 ERP dialog designs · 16 layout families'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
