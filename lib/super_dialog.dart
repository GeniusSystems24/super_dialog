/// Super Dialog - A powerful animated dialog toolkit for Flutter.
///
/// This library provides beautiful, customizable animated dialogs with
/// smooth slide, scale, and fade transitions.
///
/// ## Features
///
/// - 21 pre-built animation styles
/// - Customizable timing and curves
/// - Barrier effects (color, blur, dismissible)
/// - Platform-adaptive dialogs
/// - Native `super_core` theme integration and ready-made surface
///
/// ## Usage
///
/// ```dart
/// import 'package:super_dialog/super_dialog.dart';
///
/// SuperDialog.showAnimatedDialog<void>(
///   context,
///   (context) => MyDialog(),
///   animation: DialogAnimation.bottomToTop,
/// );
/// ```
///
/// See the [README](https://github.com/GeniusSystems24/super_dialog) for more examples.
library;

import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:super_core/super_core.dart' as core;

// Parts
part 'src/config/super_dialog_config.dart';
part 'src/theme/super_dialog_theme.dart';
part 'src/enums/dialog_animation.dart';
part 'src/enums/dialog_position.dart';
part 'src/transitions/dialog_transitions.dart';
part 'src/super_dialog.dart';
part 'src/widgets/super_dialog_surface.dart';
