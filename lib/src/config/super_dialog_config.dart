part of '../../super_dialog.dart';

/// Configuration class for super dialog transitions.
///
/// This class allows you to customize the timing and curves for
/// both opening and closing animations.
///
/// ## Example
///
/// ```dart
/// const config = SuperDialogConfig(
///   openDuration: Duration(milliseconds: 400),
///   closeDuration: Duration(milliseconds: 250),
///   openCurve: Curves.easeOutCubic,
///   closeCurve: Curves.easeInCubic,
/// );
/// ```
@immutable
class SuperDialogConfig {
  /// Creates a configuration for super dialog transitions.
  ///
  /// All parameters have sensible defaults:
  /// - [openDuration]: 300ms
  /// - [closeDuration]: 300ms
  /// - [openCurve]: [Curves.easeInOut]
  /// - [closeCurve]: [Curves.easeInOut]
  const SuperDialogConfig({
    this.openDuration = const Duration(milliseconds: 300),
    this.closeDuration = const Duration(milliseconds: 300),
    this.openCurve = Curves.easeInOut,
    this.closeCurve = Curves.easeInOut,
  });

  /// The duration of the opening animation.
  ///
  /// Defaults to 300 milliseconds.
  final Duration openDuration;

  /// The curve used for the opening animation.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve openCurve;

  /// The duration of the closing animation.
  ///
  /// Defaults to 300 milliseconds.
  final Duration closeDuration;

  /// The curve used for the closing animation.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve closeCurve;

  /// Creates a copy of this config with the given fields replaced.
  SuperDialogConfig copyWith({
    Duration? openDuration,
    Duration? closeDuration,
    Curve? openCurve,
    Curve? closeCurve,
  }) {
    return SuperDialogConfig(
      openDuration: openDuration ?? this.openDuration,
      closeDuration: closeDuration ?? this.closeDuration,
      openCurve: openCurve ?? this.openCurve,
      closeCurve: closeCurve ?? this.closeCurve,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SuperDialogConfig &&
        other.openDuration == openDuration &&
        other.closeDuration == closeDuration &&
        other.openCurve == openCurve &&
        other.closeCurve == closeCurve;
  }

  @override
  int get hashCode {
    return Object.hash(openDuration, closeDuration, openCurve, closeCurve);
  }

  @override
  String toString() {
    return 'SuperDialogConfig('
        'openDuration: $openDuration, '
        'closeDuration: $closeDuration, '
        'openCurve: $openCurve, '
        'closeCurve: $closeCurve)';
  }
}
