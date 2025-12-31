import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';
import '../theme/app_theme.dart';

/// Constants for positioned dialogs.
class PositionedConstants {
  PositionedConstants._();

  /// All 9 dialog positions.
  static const List<DialogPosition> allPositions = [
    DialogPosition.topStart,
    DialogPosition.topCenter,
    DialogPosition.topEnd,
    DialogPosition.centerStart,
    DialogPosition.center,
    DialogPosition.centerEnd,
    DialogPosition.bottomStart,
    DialogPosition.bottomCenter,
    DialogPosition.bottomEnd,
  ];

  /// All 7 transition types.
  static const List<PositionedTransitionType> allTransitionTypes = [
    PositionedTransitionType.slide,
    PositionedTransitionType.slideFade,
    PositionedTransitionType.slideScale,
    PositionedTransitionType.slideFadeScale,
    PositionedTransitionType.fade,
    PositionedTransitionType.scale,
    PositionedTransitionType.scaleFade,
  ];

  /// Gets the color for a given position.
  static Color getPositionColor(DialogPosition position) {
    switch (position) {
      case DialogPosition.topStart:
        return AppColors.error;
      case DialogPosition.topCenter:
        return AppColors.warning;
      case DialogPosition.topEnd:
        return AppColors.success;
      case DialogPosition.centerStart:
        return AppColors.info;
      case DialogPosition.center:
        return AppColors.primary;
      case DialogPosition.centerEnd:
        return AppColors.accent;
      case DialogPosition.bottomStart:
        return const Color(0xFF8B5CF6);
      case DialogPosition.bottomCenter:
        return const Color(0xFFEC4899);
      case DialogPosition.bottomEnd:
        return const Color(0xFF14B8A6);
      case DialogPosition.offScreen:
        return AppColors.lightTextSecondary;
    }
  }

  /// Gets the icon for a given transition type.
  static IconData getTransitionIcon(PositionedTransitionType type) {
    switch (type) {
      case PositionedTransitionType.slide:
        return Icons.arrow_forward_rounded;
      case PositionedTransitionType.slideFade:
        return Icons.blur_linear_rounded;
      case PositionedTransitionType.slideScale:
        return Icons.zoom_in_rounded;
      case PositionedTransitionType.slideFadeScale:
        return Icons.auto_awesome_rounded;
      case PositionedTransitionType.fade:
        return Icons.gradient_rounded;
      case PositionedTransitionType.scale:
        return Icons.zoom_out_map_rounded;
      case PositionedTransitionType.scaleFade:
        return Icons.filter_vintage_rounded;
    }
  }

  /// Gets the label for a given transition type.
  static String getTransitionLabel(PositionedTransitionType type) {
    switch (type) {
      case PositionedTransitionType.slide:
        return 'Slide';
      case PositionedTransitionType.slideFade:
        return 'Slide + Fade';
      case PositionedTransitionType.slideScale:
        return 'Slide + Scale';
      case PositionedTransitionType.slideFadeScale:
        return 'Slide + Fade + Scale';
      case PositionedTransitionType.fade:
        return 'Fade Only';
      case PositionedTransitionType.scale:
        return 'Scale Only';
      case PositionedTransitionType.scaleFade:
        return 'Scale + Fade';
    }
  }

  /// Generates code snippet for positioned dialog.
  static String generatePositionedCode({
    required DialogPosition startPosition,
    required DialogPosition endPosition,
    PositionedTransitionType transitionType =
        PositionedTransitionType.slideFade,
  }) {
    final startPosName = startPosition.toString().split('.').last;
    final endPosName = endPosition.toString().split('.').last;
    final transTypeName = transitionType.toString().split('.').last;

    return '''SuperDialog.showPositionedDialog<void>(
  context,
  (context) => const MyDialog(),
  startPosition: DialogPosition.$startPosName,
  endPosition: DialogPosition.$endPosName,
  transitionType: PositionedTransitionType.$transTypeName,
  barrierDismissible: true,
);''';
  }
}
