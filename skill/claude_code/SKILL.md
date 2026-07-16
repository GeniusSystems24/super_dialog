---
name: super-dialog
description: >
  Use, maintain, and extend the super_dialog Flutter package (v0.4.0), including
  animated and positioned dialogs, typed results, SuperDialogSurface,
  SuperDialogThemeData integration with super_core, ERP workflow patterns,
  nested navigators, RTL, accessibility, and widget testing. Use this skill
  whenever a task adds or changes dialogs built with package:super_dialog.
---

# super_dialog · v0.4.0

`super_dialog` is an animated modal-dialog toolkit for Flutter. It provides 21
pre-built animation styles, custom opening/closing timing, barrier color and
blur, platform-adaptive behavior, 3×3 positioned dialogs, typed route results,
and a ready-made `SuperDialogSurface` derived from the `super_core` design
system.

## Package contract

```text
import:     package:super_dialog/super_dialog.dart
sdk:        dart >=3.9.0
flutter:    >=3.32.0
dependency: super_core ^1.2.0
```

Applications that directly import `super_core` must declare it directly:

```yaml
dependencies:
  super_dialog: ^0.4.0
  super_core: ^1.2.0
```

## Import collision — read first

`super_core` exports its own `SuperDialog`. When both packages are used, alias
`super_core`:

```dart
import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart' as core;
import 'package:super_dialog/super_dialog.dart';
```

Never import `package:super_dialog/src/...` from consumer code.

---

## Architecture

```text
super_dialog/
├── lib/
│   ├── super_dialog.dart                     # public barrel; import this
│   └── src/
│       ├── super_dialog.dart                 # static presentation methods
│       ├── config/super_dialog_config.dart   # open/close durations + curves
│       ├── enums/dialog_animation.dart       # 21 animation styles
│       ├── enums/dialog_position.dart        # 3×3 positions + RTL helpers
│       ├── transitions/dialog_transitions.dart
│       ├── theme/super_dialog_theme.dart     # ThemeExtension + core adaptation
│       └── widgets/super_dialog_surface.dart # ready-made dialog chrome
├── example/                                  # motion + ERP showcase
└── test/
```

Public symbols are exported from `lib/super_dialog.dart` via parts. Preserve the
single public barrel and do not expose implementation paths.

---

## Primary APIs

```dart
SuperDialog.showAnimatedDialog<T>(...)
SuperDialog.showAnimatedGeneralDialog<T>(...)
SuperDialog.showAnimatedAdaptiveDialog<T>(...)
SuperDialog.showPositionedDialog<T>(...)
```

### Defaults that matter

- `showAnimatedDialog`: outside barrier dismissal defaults to `true`.
- `showAnimatedGeneralDialog`: outside barrier dismissal defaults to `false`.
- `showAnimatedAdaptiveDialog`: iOS/macOS use bottom-to-top motion and default
  blur; other platforms use Material-style defaults.
- `useRootNavigator` defaults to `true`.
- `useSafeArea` defaults to `true`.
- the route returns `Future<T?>` because dismissal may produce no value.

Shared named arguments:

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

Positioned dialogs add:

```dart
required DialogPosition startPosition
required DialogPosition endPosition
PositionedTransitionType transitionType
```

---

## `SuperDialogSurface`

Use this surface for normal package examples and ERP product work. It already
builds a transparent Material `Dialog`, constrained surface, themed border,
shadow, header, scrollable body, close affordance, and wrapped action row.

```dart
SuperDialogSurface(
  title: 'Approve Purchase Order',
  subtitle: 'PO-2026-01482',
  icon: Icons.approval_outlined,
  iconColor: core.SuperTokens.success,
  markerColor: null,
  content: const Text('Review the order before approval.'),
  actions: const <Widget>[],
  width: 600,
  showClose: true,
  onClose: null,
)
```

Return it directly from the presentation builder. Do not nest it inside
`Dialog`, `AlertDialog`, or `SimpleDialog`.

---

## Theme integration

Install `core.SuperMaterialThemeData` at the application root:

```dart
MaterialApp(
  theme: core.SuperMaterialThemeData.light(
    palette: core.SuperPalette.bluePalette,
  ),
  darkTheme: core.SuperMaterialThemeData.dark(
    palette: core.SuperPalette.bluePalette,
  ),
  themeMode: ThemeMode.system,
)
```

`SuperDialogThemeData.of(context)` resolves an explicit dialog extension first,
then the active `core.SuperThemeData`, then a Material fallback. Therefore,
normal applications do not need to register `SuperDialogThemeData` manually.

Register an explicit extension only for dialog-specific behavior:

```dart
final base = core.SuperMaterialThemeData.light();
final dialog = SuperDialogThemeData.fromSuperTheme(
  base,
  base.superTheme,
).copyWith(barrierBlur: 8, dialogWidth: 520);
final theme = base.copyWith(extensions: [dialog]);
```

Do not duplicate `super_core` colors, spacing, radii, shadows, typography, or
motion. Use `core.SuperTokens`, `core.SuperText`, the active `ColorScheme`, and
Material component themes.

---

## Animation catalogue

### Directional slide

`startToEnd` · `endToStart` · `topToBottom` · `bottomToTop`

### Scale and fade

`centerScale` · `centerFade`

### Rotation

`rotateIn` · `rotateScale`

### Bounce and elastic

`bounceIn` · `bounceSlidBottom` · `elasticIn` · `elasticSlideBottom`

### Expand

`expandVertical` · `expandHorizontal` · `expandCenter`

### Flip

`flipHorizontal` · `flipVertical`

### Combined transforms

`slideRotateBottom` · `slideRotateTop` · `slideScaleStart` · `slideScaleEnd`

Positioned transition types:

`slide` · `slideFade` · `slideScale` · `slideFadeScale` · `fade` · `scale` ·
`scaleFade` · `bounce` · `elastic` · `zoom`

---

## ERP motion policy

Use motion to communicate hierarchy and spatial origin, not to decorate a
financial decision.

- Approval, posting, release, or confirmation: `centerScale`.
- Status, progress, completion, or read-only notice: `centerFade`.
- Side detail, filters, audit trail: `endToStart`.
- Mobile action/form: adaptive API or `bottomToTop`.
- Top announcement: `topToBottom`.
- Corner status: positioned `slideFadeScale`.
- Success acknowledgement: restrained `expandCenter`; bounce only when the
  product explicitly supports celebratory motion.

Avoid rotate, flip, elastic, and strong bounce effects for period close,
payroll release, journal posting, destructive actions, compliance decisions,
or credit-risk overrides.

---

## Business-dialog rules

1. Return a typed result rather than mutating hidden global state.
2. Close using the builder's `dialogContext`.
3. Make audit-sensitive and irreversible actions non-dismissible.
4. Provide an explicit safe exit when the barrier cannot dismiss.
5. Display document ID, entity, amount, period, status, and business impact.
6. Use one primary and one secondary action in the normal case.
7. Use semantic tones from `core.SuperTokens`.
8. Check `context.mounted` after awaiting a result.
9. Preserve safe areas and scrolling for long content.
10. Keep a transparent-barrier positioned dialog in mind as still modal.

### Typed result template

```dart
enum ApprovalDecision { reject, approve }

Future<ApprovalDecision?> requestApproval(BuildContext context) {
  return SuperDialog.showAnimatedDialog<ApprovalDecision>(
    context,
    (dialogContext) => SuperDialogSurface(
      title: 'Approve Purchase Order',
      content: const Text('Approval creates an audit event.'),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(dialogContext).pop(
            ApprovalDecision.reject,
          ),
          child: const Text('Reject'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(
            ApprovalDecision.approve,
          ),
          child: const Text('Approve'),
        ),
      ],
    ),
    animation: DialogAnimation.centerScale,
    barrierDismissible: false,
  );
}
```

---

## Navigator behavior

The default is the root navigator. Use `useRootNavigator: false` for a dialog
that should remain inside a nested shell, tab, or feature navigator.

A global root navigator can be assigned when the host application already owns
that key:

```dart
SuperDialog.rootKey = rootNavigatorKey;
```

Do not introduce a global navigator key only to work around an incorrect
`BuildContext`; first fix the context or navigator scope.

---

## RTL, accessibility, and layout

- Prefer directional start/end APIs over left/right assumptions.
- Use `EdgeInsetsDirectional` in custom dialog content.
- Retain `useSafeArea: true` by default.
- Use meaningful labels; do not rely on icons or color alone.
- Ensure long content is scrollable and action labels wrap cleanly.
- Preserve keyboard focus and Material semantic behavior.
- Treat `offScreen` as an entrance position, not a final content position.

---

## Maintenance conventions

- Keep public types documented with `///` comments.
- Keep theme data immutable and implement `copyWith` + `lerp` for added fields.
- Use `Color.withValues(alpha: ...)`, not deprecated opacity APIs.
- Keep open and reverse durations independent.
- Preserve `Directionality` behavior in directional transitions.
- Add new public files to the public part/barrel structure.
- Maintain backward compatibility through additive changes first.
- Update tests for new enum values, defaults, and transition branches.

---

## Claude Code workflow

1. Inspect `pubspec.yaml`, the public barrel, and existing call sites.
2. Determine whether the task is usage, theme work, a new transition, or an API
   compatibility change.
3. Prefer the existing public API and `SuperDialogSurface` before adding new
   abstractions.
4. Alias `super_core` as `core` in files importing both packages.
5. Implement typed results and correct navigator scope.
6. Add focused tests for route behavior and results.
7. Run:

```bash
flutter pub get
dart format .
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

8. Report changed files, behavioral impact, and any unverified platform-specific
behavior.

---

## Common failure modes

- Ambiguous `SuperDialog` symbol from two unaliased imports.
- Double dialog surfaces from wrapping `SuperDialogSurface`.
- Popping with the outer context.
- Assuming general-dialog barriers dismiss by default.
- Ignoring the nullable result.
- Updating state after disposal.
- Hardcoding GeniusLink visual tokens.
- Selecting playful motion for a serious ERP decision.
- Blocking the full screen with a transparent modal when a non-modal overlay was
intended.
- Forgetting RTL or nested navigator behavior.

## Reference

See `EXAMPLES.md` in this folder for copy-pasteable ERP and general patterns.
