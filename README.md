<div align="center">

# ↔️ Super Dialog

### Beautiful Animated Dialogs for Flutter

[![pub package](https://img.shields.io/pub/v/super_dialog.svg?style=for-the-badge&logo=dart&logoColor=white&labelColor=0175C2&color=02569B)](https://pub.dev/packages/super_dialog)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web%20%7C%20Desktop-blueviolet?style=for-the-badge)](https://flutter.dev)

*A powerful, flexible, and beautifully animated dialog toolkit for Flutter.*  
*Create stunning dialogs with smooth slide, scale, and fade animations.*

---

[📖 Documentation](#-api-reference) • [🚀 Quick Start](#-quick-start) • [📚 Examples](#-examples) • [🧪 Demo](#-demo-app)

</div>

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🎬 Rich Animations
- **6 Pre-built animation styles**
- Slide from any direction
- Scale & fade effects
- RTL-aware transitions

</td>
<td width="50%">

### ⚙️ Highly Configurable
- Custom duration & curves
- Barrier color & blur
- Size constraints
- Safe area handling

</td>
</tr>
<tr>
<td width="50%">

### 📱 Platform Adaptive
- Auto-adapts to iOS/Android
- Material & Cupertino styles
- Native-feeling interactions

</td>
<td width="50%">

### 🔧 Developer Friendly
- Simple, intuitive API
- Full TypeScript-like generics
- Lifecycle callbacks
- Zero dependencies

</td>
</tr>
</table>

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  super_dialog: ^0.1.0
```

```bash
flutter pub get
```

---

## 🚀 Quick Start

### Basic Dialog

```dart
import 'package:super_dialog/super_dialog.dart';

SuperDialog.showAnimatedDialog<void>(
  context,
  (context) => const MyCustomDialog(),
  animation: DialogAnimation.bottomToTop,
);
```

### With Full Customization

```dart
SuperDialog.showAnimatedDialog<void>(
  context,
  (context) => const TimeOffDetailsDialog(),
  animation: DialogAnimation.centerScale,
  config: const SuperDialogConfig(
    openDuration: Duration(milliseconds: 400),
    openCurve: Curves.easeOutCubic,
  ),
  constraints: const BoxConstraints(maxWidth: 460),
  barrierColor: Colors.black54,
  barrierBlur: 8.0,
  barrierDismissible: true,
  onDismissed: () => print('Dialog closed'),
);
```

---

## 🎬 Animation Types

<table>
<tr>
<th>Animation</th>
<th>Description</th>
<th>Best For</th>
</tr>
<tr>
<td><code>startToEnd</code></td>
<td>Slides from leading edge (RTL-aware)</td>
<td>Side drawers, navigation panels</td>
</tr>
<tr>
<td><code>endToStart</code></td>
<td>Slides from trailing edge (RTL-aware)</td>
<td>Settings panels, details views</td>
</tr>
<tr>
<td><code>topToBottom</code></td>
<td>Drops from top</td>
<td>Notifications, banners, alerts</td>
</tr>
<tr>
<td><code>bottomToTop</code></td>
<td>Rises from bottom</td>
<td>Action sheets, bottom menus</td>
</tr>
<tr>
<td><code>centerScale</code></td>
<td>Scales from 92% with fade</td>
<td>Confirmations, important alerts</td>
</tr>
<tr>
<td><code>centerFade</code></td>
<td>Simple fade in/out</td>
<td>Toasts, status messages</td>
</tr>
</table>

---

## 📖 API Reference

### SuperDialog

The main class providing static methods for showing dialogs.

```dart
// Standard dialog (barrier dismissible by default)
SuperDialog.showAnimatedDialog<T>(...);

// Full control dialog (barrier NOT dismissible by default)
SuperDialog.showAnimatedGeneralDialog<T>(...);

// Platform-adaptive dialog (iOS: bottom sheet style)
SuperDialog.showAnimatedAdaptiveDialog<T>(...);
```

### SuperDialogConfig

Fine-tune animation timing:

```dart
const SuperDialogConfig({
  Duration openDuration = const Duration(milliseconds: 300),
  Duration closeDuration = const Duration(milliseconds: 300),
  Curve openCurve = Curves.easeInOut,
  Curve closeCurve = Curves.easeInOut,
});
```

### Parameters

| Parameter | Type | Default | Description |
|:----------|:-----|:--------|:------------|
| `context` | `BuildContext` | *required* | Build context |
| `builder` | `WidgetBuilder` | *required* | Dialog content builder |
| `animation` | `DialogAnimation` | `startToEnd` | Animation style |
| `config` | `SuperDialogConfig?` | `null` | Timing configuration |
| `constraints` | `BoxConstraints?` | `null` | Size constraints |
| `barrierDismissible` | `bool?` | `true`* | Tap outside to dismiss |
| `barrierColor` | `Color?` | `#B3000000` | Barrier overlay color |
| `barrierBlur` | `double?` | `null` | Gaussian blur amount |
| `useSafeArea` | `bool` | `true` | Respect safe area |
| `useRootNavigator` | `bool?` | `true` | Use root navigator |
| `onDismissed` | `VoidCallback?` | `null` | Dismissal callback |

<sub>*Default varies by method and platform</sub>

---

## 📚 Examples

<details>
<summary><b>🗂️ Slide-In Drawer</b></summary>

```dart
SuperDialog.showAnimatedDialog(
  context,
  (context) => FractionallySizedBox(
    widthFactor: 0.7,
    alignment: AlignmentDirectional.centerStart,
    child: const NavigationDrawer(),
  ),
  animation: DialogAnimation.startToEnd,
  barrierColor: Colors.black26,
);
```
</details>

<details>
<summary><b>📋 Bottom Action Sheet</b></summary>

```dart
SuperDialog.showAnimatedDialog(
  context,
  (context) => const ActionSheet(),
  animation: DialogAnimation.bottomToTop,
  barrierDismissible: true,
);
```
</details>

<details>
<summary><b>✅ Confirmation Modal</b></summary>

```dart
final confirmed = await SuperDialog.showAnimatedDialog<bool>(
  context,
  (context) => ConfirmDialog(
    onConfirm: () => Navigator.pop(context, true),
    onCancel: () => Navigator.pop(context, false),
  ),
  animation: DialogAnimation.centerScale,
  constraints: const BoxConstraints(maxWidth: 400),
);
```
</details>

<details>
<summary><b>⚙️ Custom Animation Timing</b></summary>

```dart
SuperDialog.showAnimatedDialog(
  context,
  (context) => const SettingsPanel(),
  config: const SuperDialogConfig(
    openDuration: Duration(milliseconds: 400),
    closeDuration: Duration(milliseconds: 200),
    openCurve: Curves.easeOutBack,
    closeCurve: Curves.easeIn,
  ),
);
```
</details>

<details>
<summary><b>🔔 Dismissal Callback</b></summary>

```dart
SuperDialog.showAnimatedDialog(
  context,
  (context) => const GuardedDialog(),
  animation: DialogAnimation.centerFade,
  onDismissed: () {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dialog was dismissed')),
    );
  },
);
```
</details>

<details>
<summary><b>📱 Platform Adaptive</b></summary>

```dart
// Automatically uses bottomToTop + blur on iOS/macOS
// Uses startToEnd on Android/Windows/Linux/Web
SuperDialog.showAnimatedAdaptiveDialog(
  context,
  (context) => const CrossPlatformDialog(),
);
```
</details>

---

## 🧪 Demo App

The package includes a comprehensive example app with **18 interactive scenarios**.

```bash
cd example
flutter run
```

| Category | Animations | Scenarios |
|:---------|:-----------|:----------|
| **Slide** | `startToEnd`, `endToStart` | Drawers, panels, filters |
| **Reveal** | `topToBottom`, `bottomToTop` | Banners, sheets, toasts |
| **Transform** | `centerScale`, `centerFade` | Modals, confirmations |

---

## 📋 Requirements

| Requirement | Version |
|:------------|:--------|
| Dart SDK | `≥3.10.3` |
| Flutter | `≥1.17.0` |
| Platforms | iOS, Android, Web, macOS, Windows, Linux |

---

## 📄 License

```
MIT License

Copyright (c) 2025 Genius Systems

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

---

<sub>Built with ❤️ by <b>Genius Systems 24</b></sub>

</div>
