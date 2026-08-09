# super_dialog — ChatGPT / Codex agent instructions (v0.4.0)

Use these instructions whenever you add, modify, review, or test Flutter dialogs
built with `super_dialog`, especially in applications using the GeniusLink
`super_core` design system or ERP workflows.

---

## Package

```text
name:       super_dialog
version:    0.4.0
import:     package:super_dialog/super_dialog.dart
sdk:        dart >=3.9.0
flutter:    >=3.32.0
dependency: super_core ^3.3.0
```

Consumer applications that directly use `SuperMaterialThemeData`,
`SuperTokens`, or other `super_core` symbols should declare `super_core` as a
direct dependency.

```yaml
dependencies:
  flutter:
    sdk: flutter
  super_dialog: ^0.6.0
  super_core: ^3.3.0
```

## Import rule

`super_core` also exports a widget named `SuperDialog`. Alias `super_core` when
both packages are imported so the animated-dialog API remains unambiguous.

```dart
import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart' as core;
import 'package:super_dialog/super_dialog.dart';
```

Do not import files below `package:super_dialog/src/`.

---

## When to use this skill

Apply this skill when the user asks to:

- add animated modal dialogs, confirmations, alerts, panels, or action sheets;
- replace `showDialog` / `showGeneralDialog` with `super_dialog`;
- build ERP approval, posting, settlement, transfer, or period-close dialogs;
- add typed dialog results;
- configure barrier color, blur, dismissal, safe area, or navigator scope;
- position a dialog at a corner, edge, or 3×3 alignment point;
- integrate dialogs with `super_core` light/dark palettes;
- test dialog transitions and returned values.

---

## Public API map

### Presentation methods

```dart
SuperDialog.showAnimatedDialog<T>(...)          // primary API; dismissible by default
SuperDialog.showAnimatedGeneralDialog<T>(...)   // full control; non-dismissible by default
SuperDialog.showAnimatedAdaptiveDialog<T>(...)  // Cupertino-aware defaults
SuperDialog.showPositionedDialog<T>(...)        // start/end position + transition type
```

Shared options:

```dart
SuperDialogConfig? config
DialogAnimation animation
BoxConstraints? constraints
bool? useRootNavigator
bool useSafeArea
bool? barrierDismissible
Color? barrierColor
double? barrierBlur
VoidCallback? onDismissed
```

`showPositionedDialog` additionally accepts:

```dart
required DialogPosition startPosition
required DialogPosition endPosition
PositionedTransitionType transitionType
```

### Ready-made surface

Return `SuperDialogSurface` directly from the builder for a dialog that follows
`super_core` colors, typography, spacing, radii, borders, and shadows.

```dart
SuperDialogSurface(
  title: 'Approve Purchase Order',
  subtitle: 'PO-2026-01482 · Northwind Industrial Supply',
  icon: Icons.approval_outlined,
  iconColor: core.SuperThemeData.of(context).tokens.success,
  content: const Text('Review the commercial and budget impact.'),
  actions: const <Widget>[],
  width: 560,
  showClose: true,
)
```

`SuperDialogSurface` already builds a `Dialog`. Do not wrap it in another
`Dialog`, `AlertDialog`, or `SimpleDialog`.

### Configuration

```dart
const SuperDialogConfig(
  openDuration: Duration(milliseconds: 300),
  closeDuration: Duration(milliseconds: 300),
  openCurve: Curves.easeInOut,
  closeCurve: Curves.easeInOut,
)

const SuperDialogConfig.geniusLink()
```

The GeniusLink preset uses `super_core` motion tokens and is the default when
`SuperDialogThemeData` is resolved.

### Theme extension

`SuperDialogThemeData.of(context)` resolves in this order:

1. an explicitly registered `SuperDialogThemeData` extension;
2. the active `core.SuperThemeData` installed by `SuperMaterialThemeData`;
3. a Material-theme fallback.

The application normally needs no explicit dialog extension. Register one only
for dialog-specific overrides such as barrier blur, width, or animation timing.

---

## Theme setup

Use `super_core` on the app root. The dialog package automatically derives its
surface tokens from it.

`super_core` 3.3.0 requires both `textTheme` and `primaryTextTheme` on
`SuperMaterialThemeData.light` / `.dark`, and both must be `SuperTextTheme`.
Do not read typography from `core.SuperThemeData.of(context).textTheme`; that
getter no longer exists. Read the active typography from
`core.SuperMaterialThemeData.maybeOf(context)?.textTheme` (with a Material
`Theme.of(context).textTheme` fallback when the Super theme is optional). Also
do not infer token font metadata from `SuperTextTheme`; pass `fontFamily` to
`SuperMaterialThemeData` explicitly only when that token-level override is
intended.

```dart
final typography = core.SuperTextTheme();

MaterialApp(
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
  home: const ErpDashboard(),
)
```

For responsive applications, resolve the device mode once and pass it to both
the light and dark themes.

```dart
final mode = core.SuperDeviceMode.forWidth(constraints.maxWidth);
```

Never duplicate `super_core` palette, spacing, radius, or motion values inside a
dialog. Prefer `core.SuperThemeData.of(context).tokens`, `core.SuperText`, and the ambient theme.

---

## Selecting an animation

Use restrained motion for business-critical ERP workflows.

| Workflow | Preferred animation | Reason |
|---|---|---|
| Confirm approval/posting | `centerScale` | Focused, clear, professional |
| Status/progress/result | `centerFade` | Low-distraction feedback |
| Detail/filter side panel | `endToStart` | Matches drill-in navigation |
| Mobile form/action sheet | `bottomToTop` | Platform-familiar entry |
| Announcement/banner | `topToBottom` | Direction matches placement |
| Success acknowledgement | `expandCenter` or subtle `bounceIn` | Use sparingly |
| Corner notification | `showPositionedDialog` + `slideFadeScale` | Maintains page context |

Avoid `rotateIn`, flip, elastic, or strong bounce effects for destructive,
financial-posting, payroll, compliance, or period-close decisions. Those effects
are appropriate only when the product intentionally uses playful motion.

---

## ERP interaction rules

1. Return a typed value with `Navigator.of(dialogContext).pop(result)`.
2. Use the builder's `dialogContext`, not a stale outer context, for closing.
3. Set `barrierDismissible: false` for irreversible or audit-sensitive actions.
4. Always provide an explicit cancel/back action when outside dismissal is off.
5. Explain the business impact before the primary action.
6. Use semantic colors consistently:
   - primary/accent: normal approval or navigation;
   - `core.SuperThemeData.of(context).tokens.success`: completed/valid;
   - `core.SuperThemeData.of(context).tokens.warning`: review required;
   - `core.SuperThemeData.of(context).tokens.danger`: destructive, blocked, or high risk.
7. After awaiting a dialog, check `context.mounted` before updating UI.
8. Keep values such as amount, document number, legal entity, period, and audit
   impact visible in the dialog body.
9. Prefer one primary action and one secondary action. Add a third only when the
   workflow has a real third state such as “Save draft”.
10. Do not use a non-dismissible loading dialog unless the underlying operation
    truly cannot be cancelled.

---

## Typed-result pattern

```dart
enum JournalDecision { saveDraft, post }

Future<JournalDecision?> requestJournalDecision(BuildContext context) {
  return SuperDialog.showAnimatedDialog<JournalDecision>(
    context,
    (dialogContext) => SuperDialogSurface(
      title: 'Post Journal Entry',
      subtitle: 'JV-2026-0042 · FY26 Period 07',
      icon: Icons.menu_book_outlined,
      content: const Text(
        'Debit and credit totals are balanced. Posting creates an immutable '
        'audit event and updates the general ledger immediately.',
      ),
      actions: [
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
}
```

---

## Nested navigators

The default is `useRootNavigator: true`. Set `useRootNavigator: false` when the
dialog must remain inside a nested shell/tab navigator.

For an application-wide custom root navigator:

```dart
final rootNavigatorKey = GlobalKey<NavigatorState>();
SuperDialog.rootKey = rootNavigatorKey;
```

Do not set a global root key unless the application already owns and consistently
uses that navigator key.

---

## RTL and accessibility

- Prefer `startToEnd`, `endToStart`, `DialogPosition.topStart`, and
  `DialogPosition.topEnd`; these respond to `Directionality`.
- Use `EdgeInsetsDirectional` inside custom content.
- Keep `useSafeArea: true` unless an intentional full-bleed experience requires
  otherwise.
- Provide meaningful titles, button labels, and icon tooltips.
- Do not encode meaning by color alone; pair colors with labels and icons.
- Keep critical actions keyboard reachable and preserve Material focus order.

---

## Testing expectations

Test behavior, not animation internals:

- the dialog appears;
- barrier dismissal matches the requirement;
- primary and secondary actions return the expected typed value;
- dark/light themes render without exceptions;
- nested navigator behavior uses the intended navigator;
- RTL start/end behavior remains valid;
- long content scrolls without overflow.

Use `pumpAndSettle()` or pump past the configured open/close durations before
asserting route removal.

---

## Agent workflow

1. Read `pubspec.yaml` and use the installed package version.
2. Search existing dialog call sites before introducing a new pattern.
3. Import package barrels only; alias `super_core` as `core` when both packages
   are present.
4. Choose the least distracting animation that communicates spatial intent.
5. Prefer `SuperDialogSurface` over hand-built dialog chrome.
6. Return typed results for business decisions.
7. Reuse `super_core` tokens and ambient Material components.
8. Add or update widget tests.
9. Run:

```bash
flutter pub get
dart format .
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

---

## Common mistakes

- Ambiguous `SuperDialog` imports from `super_core` and `super_dialog`.
- Wrapping `SuperDialogSurface` in another dialog widget.
- Calling `Navigator.pop` with the outer page context.
- Using a playful transition for a high-risk accounting action.
- Leaving an irreversible action barrier-dismissible.
- Hardcoding design-system colors, spacing, radii, or typography.
- Ignoring the nullable result when a route can be dismissed.
- Updating state after `await` without checking `context.mounted`.
- Using `showAnimatedGeneralDialog` and assuming the barrier dismisses by default.
- Using a transparent full-screen modal as a replacement for a true non-modal
  notification without considering pointer blocking.

---

## Reference

- Copy-paste patterns: `EXAMPLES.md` in this folder.
- Public barrel: `lib/super_dialog.dart`.
- Core APIs: `lib/src/super_dialog.dart`.
- Theme: `lib/src/theme/super_dialog_theme.dart`.
- Surface: `lib/src/widgets/super_dialog_surface.dart`.
