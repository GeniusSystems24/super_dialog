part of '../../super_dialog.dart';

/// Configuration class for Super Dialog transitions.
///
/// This class allows independent control over opening and closing timing.
@immutable
class SuperDialogConfig {
  /// Creates a transition configuration.
  ///
  /// The default constructor preserves the package's original 300ms easing.
  const SuperDialogConfig({
    this.openDuration = const Duration(milliseconds: 300),
    this.closeDuration = const Duration(milliseconds: 300),
    this.openCurve = Curves.easeInOut,
    this.closeCurve = Curves.easeInOut,
  });

  /// GeniusLink motion preset used by [SuperDialogThemeData].
  ///
  /// It uses compact 200ms motion, a decelerating entrance curve, and the
  /// standard Material/GeniusLink curve when closing.
  const SuperDialogConfig.geniusLink()
    : openDuration = const Duration(milliseconds: 200),
      closeDuration = const Duration(milliseconds: 150),
      openCurve = const Cubic(0, 0, 0.2, 1),
      closeCurve = const Cubic(0.4, 0, 0.2, 1);

  /// The duration of the opening animation.
  final Duration openDuration;

  /// The curve used for the opening animation.
  final Curve openCurve;

  /// The duration of the closing animation.
  final Duration closeDuration;

  /// The curve used for the closing animation.
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
