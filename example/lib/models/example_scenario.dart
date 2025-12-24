import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

class ExampleScenario {
  const ExampleScenario({
    required this.title,
    required this.description,
    required this.animation,
    required this.category,
    required this.icon,
    required this.accentColor,
    required this.builder,
    this.config,
    this.constraints,
    this.barrierDismissible,
    this.barrierColor,
    this.barrierBlur,
    this.onDismissed,
  });

  final String title;
  final String description;
  final DialogAnimation animation;
  final String category;
  final IconData icon;
  final Color accentColor;
  final WidgetBuilder builder;
  final SuperDialogConfig? config;
  final BoxConstraints? constraints;
  final bool? barrierDismissible;
  final Color? barrierColor;
  final double? barrierBlur;
  final void Function(BuildContext context)? onDismissed;

  String get animationLabel => animation.toString().split('.').last;
}
