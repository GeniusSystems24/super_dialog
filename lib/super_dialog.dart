/// Super Dialog - A powerful animated dialog toolkit for Flutter.
///
/// This library provides beautiful, customizable animated dialogs with
/// smooth slide, scale, and fade transitions.
///
/// ## Features
///
/// - 6 Pre-built animation styles
/// - Customizable timing and curves
/// - Barrier effects (color, blur, dismissible)
/// - Platform-adaptive dialogs
/// - Easy integration
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

import 'package:flutter/material.dart';

// Parts
part 'src/config/super_dialog_config.dart';
part 'src/enums/dialog_animation.dart';
part 'src/transitions/dialog_transitions.dart';
part 'src/super_dialog.dart';
