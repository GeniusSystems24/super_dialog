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
    this.codeSnippet,
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

  /// The code snippet to display/copy for this example.
  final String? codeSnippet;

  String get animationLabel => animation.toString().split('.').last;

  /// Generates a code snippet automatically based on the scenario parameters.
  String get generatedCodeSnippet {
    if (codeSnippet != null) return codeSnippet!;

    final buffer = StringBuffer();
    buffer.writeln('SuperDialog.showAnimatedDialog<void>(');
    buffer.writeln('  context,');
    buffer.writeln('  (context) => const MyDialog(),');
    buffer.writeln('  animation: DialogAnimation.$animationLabel,');

    if (constraints != null) {
      buffer.writeln(
        '  constraints: const BoxConstraints(maxWidth: ${constraints!.maxWidth.toInt()}),',
      );
    }

    if (barrierDismissible != null) {
      buffer.writeln('  barrierDismissible: $barrierDismissible,');
    }

    if (barrierBlur != null) {
      buffer.writeln('  barrierBlur: $barrierBlur,');
    }

    buffer.write(');');
    return buffer.toString();
  }
}
