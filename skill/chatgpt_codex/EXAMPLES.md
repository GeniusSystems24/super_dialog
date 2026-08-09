# super_dialog · Usage examples (v0.4.0)

Runnable patterns for Flutter applications. These examples follow the
`super_core` 3.3.0 typography contract: create a `core.SuperTextTheme` before
building `SuperMaterialThemeData`, pass it as both required text-theme fields,
and never read `SuperThemeData.textTheme`. Because `super_core` also exports a
class named `SuperDialog`, the examples alias that package as `core`.

```dart
import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart' as core;
import 'package:super_dialog/super_dialog.dart';
```

---

## 1 · Install and configure the app theme

```yaml
dependencies:
  flutter:
    sdk: flutter
  super_dialog: ^0.6.0
  super_core: ^3.3.0
```

```dart
void main() => runApp(const ErpApp());

class ErpApp extends StatelessWidget {
  const ErpApp({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = core.SuperTextTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: core.SuperMaterialThemeData.light(
        palette: core.SuperPalette.bluePalette,
        textTheme: typography,
        primaryTextTheme: typography,
      ),
      darkTheme: core.SuperMaterialThemeData.dark(
        palette: core.SuperPalette.bluePalette,
        textTheme: typography,
        primaryTextTheme: typography,
      ),
      themeMode: ThemeMode.system,
      home: const Scaffold(body: SizedBox.shrink()),
    );
  }
}
```

No explicit `SuperDialogThemeData` registration is required. It automatically
adapts to the active `super_core` theme.

---

## 2 · Simple informational dialog

```dart
Future<void> showEntryPosted(BuildContext context) {
  return SuperDialog.showAnimatedDialog<void>(
    context,
    (dialogContext) => SuperDialogSurface(
      title: 'Entry Posted',
      subtitle: 'JV-2026-0042',
      icon: Icons.check_circle_outline,
      iconColor: core.SuperThemeData.of(context).tokens.success,
      content: const Text(
        'The journal entry was posted to FY26 Period 07 and is now visible '
        'in the general ledger.',
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Done'),
        ),
      ],
    ),
    animation: DialogAnimation.centerFade,
  );
}
```

---

## 3 · Purchase-order approval returning `bool`

```dart
Future<bool> approvePurchaseOrder(BuildContext context) async {
  final approved = await SuperDialog.showAnimatedDialog<bool>(
    context,
    (dialogContext) => SuperDialogSurface(
      width: 600,
      title: 'Approve Purchase Order',
      subtitle: 'PO-2026-01482 · Northwind Industrial Supply',
      icon: Icons.approval_outlined,
      content: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Order total: USD 128,450.00'),
          SizedBox(height: core.SuperThemeData.of(context).tokens.space2),
          Text('Budget remaining after approval: USD 371,550.00'),
          SizedBox(height: core.SuperThemeData.of(context).tokens.space4),
          Text(
            'Approval moves the document to procurement release and records '
            'your user ID in the audit trail.',
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Reject'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          icon: const Icon(Icons.check, size: 18),
          label: const Text('Approve'),
        ),
      ],
    ),
    animation: DialogAnimation.centerScale,
    barrierDismissible: false,
  );

  return approved ?? false;
}
```

---

## 4 · Journal posting with a three-state typed result

```dart
enum JournalDecision { cancel, saveDraft, post }

Future<JournalDecision> showJournalPostingDialog(BuildContext context) async {
  final result = await SuperDialog.showAnimatedGeneralDialog<JournalDecision>(
    context,
    (dialogContext) => SuperDialogSurface(
      width: 640,
      title: 'Post Journal Entry',
      subtitle: 'JV-2026-0042 · Manual adjustment',
      icon: Icons.menu_book_outlined,
      content: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Debit: USD 42,750.00'),
          Text('Credit: USD 42,750.00'),
          SizedBox(height: core.SuperThemeData.of(context).tokens.space4),
          Text(
            'The entry is balanced. Posting creates an immutable audit event '
            'and updates account balances immediately.',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(
            JournalDecision.cancel,
          ),
          child: const Text('Cancel'),
        ),
        OutlinedButton(
          onPressed: () => Navigator.of(dialogContext).pop(
            JournalDecision.saveDraft,
          ),
          child: const Text('Save draft'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(
            JournalDecision.post,
          ),
          child: const Text('Post entry'),
        ),
      ],
    ),
    animation: DialogAnimation.centerScale,
    barrierDismissible: false,
  );

  return result ?? JournalDecision.cancel;
}
```

---

## 5 · Credit-hold release with danger styling

```dart
Future<bool> requestCreditHoldRelease(BuildContext context) async {
  final released = await SuperDialog.showAnimatedDialog<bool>(
    context,
    (dialogContext) => SuperDialogSurface(
      title: 'Release Credit Hold',
      subtitle: 'C-100284 · Apex Retail Group',
      icon: Icons.credit_card_off_outlined,
      iconColor: core.SuperThemeData.of(context).tokens.danger,
      content: const Text(
        'Current exposure is 114.6% of the approved credit limit. Releasing '
        'the hold permits SO-30291 to continue as a one-time exception.',
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Keep hold'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: core.SuperThemeData.of(context).tokens.danger,
          ),
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text('Release once'),
        ),
      ],
    ),
    animation: DialogAnimation.centerScale,
    barrierDismissible: false,
  );

  return released ?? false;
}
```

---

## 6 · Mobile-adaptive inventory transfer

```dart
Future<bool> createInventoryTransfer(BuildContext context) async {
  final created = await SuperDialog.showAnimatedAdaptiveDialog<bool>(
    context,
    (dialogContext) => SuperDialogSurface(
      width: 680,
      title: 'Create Inventory Transfer',
      subtitle: 'WH-01 → WH-04 · 44 units',
      icon: Icons.swap_horiz,
      content: const Text(
        'Receiving staff must confirm quantities before stock is released '
        'from in-transit inventory.',
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          icon: const Icon(Icons.local_shipping_outlined, size: 18),
          label: const Text('Create transfer'),
        ),
      ],
    ),
    barrierDismissible: false,
  );

  return created ?? false;
}
```

On iOS/macOS the default transition becomes `bottomToTop` with blur. Other
platforms use the requested/default Material-style motion.

---

## 7 · Period-close confirmation with custom motion

```dart
Future<bool> closeAccountingPeriod(BuildContext context) async {
  const motion = SuperDialogConfig(
    openDuration: Duration(milliseconds: 220),
    closeDuration: Duration(milliseconds: 160),
    openCurve: Curves.easeOutCubic,
    closeCurve: Curves.easeInCubic,
  );

  final confirmed = await SuperDialog.showAnimatedGeneralDialog<bool>(
    context,
    (dialogContext) => SuperDialogSurface(
      width: 600,
      title: 'Close Accounting Period',
      subtitle: 'FY26 · Period 07',
      icon: Icons.lock_outline,
      iconColor: core.SuperThemeData.of(context).tokens.danger,
      content: const Text(
        'Closing blocks normal postings for this period. Reopening requires '
        'controller authorization and creates a separate audit event.',
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: core.SuperThemeData.of(context).tokens.danger,
          ),
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text('Close period'),
        ),
      ],
    ),
    animation: DialogAnimation.centerScale,
    config: motion,
    barrierDismissible: false,
    barrierBlur: 6,
  );

  return confirmed ?? false;
}
```

---

## 8 · Positioned approval notification

```dart
Future<void> showApprovalQueued(BuildContext context) {
  return SuperDialog.showPositionedDialog<void>(
    context,
    (dialogContext) => SuperDialogSurface(
      width: 380,
      title: 'Approval Queued',
      subtitle: 'PO-2026-01482',
      icon: Icons.schedule_send_outlined,
      iconColor: core.SuperThemeData.of(context).tokens.success,
      content: const Text(
        'The purchase order was sent to the procurement controller.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Dismiss'),
        ),
      ],
    ),
    startPosition: DialogPosition.offScreen,
    endPosition: DialogPosition.topEnd,
    transitionType: PositionedTransitionType.slideFadeScale,
    barrierColor: Colors.transparent,
    barrierDismissible: true,
  );
}
```

This is still a modal route even with a transparent barrier. Use a snackbar or
an overlay entry instead when the notification must not block page interaction.

---

## 9 · Side-panel filter dialog

```dart
Future<Map<String, Object?>?> showLedgerFilters(BuildContext context) {
  return SuperDialog.showAnimatedDialog<Map<String, Object?>>(
    context,
    (dialogContext) => SuperDialogSurface(
      width: 420,
      title: 'Ledger Filters',
      subtitle: 'Narrow the transaction list',
      icon: Icons.filter_alt_outlined,
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(decoration: InputDecoration(labelText: 'Account')),
          SizedBox(height: core.SuperThemeData.of(context).tokens.space3),
          TextField(decoration: InputDecoration(labelText: 'Document number')),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(
            <String, Object?>{'account': '6105'},
          ),
          child: const Text('Apply filters'),
        ),
      ],
    ),
    animation: DialogAnimation.endToStart,
  );
}
```

---

## 10 · Dialog-specific theme overrides

```dart
core.SuperMaterialThemeData buildTheme(Brightness brightness) {
  final typography = core.SuperTextTheme();
  final base = brightness == Brightness.dark
      ? core.SuperMaterialThemeData.dark(
          palette: core.SuperPalette.bluePalette,
          textTheme: typography,
          primaryTextTheme: typography,
        )
      : core.SuperMaterialThemeData.light(
          palette: core.SuperPalette.bluePalette,
          textTheme: typography,
          primaryTextTheme: typography,
        );

  final dialogTheme = SuperDialogThemeData.fromSuperTheme(
    base,
    base.superTheme,
  ).copyWith(
    barrierBlur: 8,
    dialogWidth: 520,
    config: const SuperDialogConfig.geniusLink(),
  );

  return base.copyWith(extensions: [dialogTheme]);
}

MaterialApp(
  theme: buildTheme(Brightness.light),
  darkTheme: buildTheme(Brightness.dark),
  home: const Scaffold(body: SizedBox.shrink()),
)
```

Do not replace palette-derived colors unless the application has an explicit
brand requirement.

---

## 11 · Nested navigator scope

```dart
Future<void> showInsideCurrentTab(BuildContext context) {
  return SuperDialog.showAnimatedDialog<void>(
    context,
    (dialogContext) => SuperDialogSurface(
      title: 'Tab-scoped Dialog',
      content: const Text('This route stays inside the current tab navigator.'),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Close'),
        ),
      ],
    ),
    useRootNavigator: false,
    animation: DialogAnimation.centerFade,
  );
}
```

---

## 12 · Awaiting a result safely in a stateful widget

```dart
Future<void> onApprovePressed(BuildContext context) async {
  final approved = await approvePurchaseOrder(context);
  if (!context.mounted || !approved) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Purchase order approved.')),
  );
}
```

---

## 13 · Widget test for a typed result

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_core/super_core.dart' as core;
import 'package:super_dialog/super_dialog.dart';

void main() {
  testWidgets('approval dialog returns true', (tester) async {
    bool? result;

    final typography = core.SuperTextTheme();

    await tester.pumpWidget(
      MaterialApp(
        theme: core.SuperMaterialThemeData.light(
          textTheme: typography,
          primaryTextTheme: typography,
        ),
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                result = await SuperDialog.showAnimatedDialog<bool>(
                  context,
                  (dialogContext) => SuperDialogSurface(
                    title: 'Approve Purchase Order',
                    actions: [
                      FilledButton(
                        onPressed: () => Navigator.of(dialogContext).pop(true),
                        child: const Text('Approve'),
                      ),
                    ],
                  ),
                  animation: DialogAnimation.centerScale,
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Approve Purchase Order'), findsOneWidget);

    await tester.tap(find.text('Approve'));
    await tester.pumpAndSettle();
    expect(result, isTrue);
  });
}
```
