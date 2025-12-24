part of '../../super_dialog.dart';

/// Defines the position of the dialog on the screen.
///
/// Used with [SuperDialog.showPositionedDialog] to specify where the dialog
/// should start and end its transition.
///
/// ## Grid Layout
///
/// ```
/// ┌─────────────┬─────────────┬─────────────┐
/// │  topStart   │  topCenter  │   topEnd    │
/// ├─────────────┼─────────────┼─────────────┤
/// │ centerStart │   center    │  centerEnd  │
/// ├─────────────┼─────────────┼─────────────┤
/// │ bottomStart │bottomCenter │  bottomEnd  │
/// └─────────────┴─────────────┴─────────────┘
/// ```
enum DialogPosition {
  /// Top-left corner (or top-right in RTL).
  topStart,

  /// Top-center of the screen.
  topCenter,

  /// Top-right corner (or top-left in RTL).
  topEnd,

  /// Center-left (or center-right in RTL).
  centerStart,

  /// Center of the screen.
  center,

  /// Center-right (or center-left in RTL).
  centerEnd,

  /// Bottom-left corner (or bottom-right in RTL).
  bottomStart,

  /// Bottom-center of the screen.
  bottomCenter,

  /// Bottom-right corner (or bottom-left in RTL).
  bottomEnd,

  /// Outside the screen (invisible starting point).
  /// Used as a starting position for slide-in animations.
  offScreen,
}

/// Extension methods for [DialogPosition].
extension DialogPositionExtension on DialogPosition {
  /// Returns the [Alignment] for this position.
  ///
  /// For RTL-aware positions (start/end), use [toAlignmentDirectional].
  Alignment toAlignment() {
    switch (this) {
      case DialogPosition.topStart:
        return Alignment.topLeft;
      case DialogPosition.topCenter:
        return Alignment.topCenter;
      case DialogPosition.topEnd:
        return Alignment.topRight;
      case DialogPosition.centerStart:
        return Alignment.centerLeft;
      case DialogPosition.center:
        return Alignment.center;
      case DialogPosition.centerEnd:
        return Alignment.centerRight;
      case DialogPosition.bottomStart:
        return Alignment.bottomLeft;
      case DialogPosition.bottomCenter:
        return Alignment.bottomCenter;
      case DialogPosition.bottomEnd:
        return Alignment.bottomRight;
      case DialogPosition.offScreen:
        return Alignment.center;
    }
  }

  /// Returns the [AlignmentDirectional] for this position.
  ///
  /// This respects RTL text direction.
  AlignmentDirectional toAlignmentDirectional() {
    switch (this) {
      case DialogPosition.topStart:
        return AlignmentDirectional.topStart;
      case DialogPosition.topCenter:
        return AlignmentDirectional.topCenter;
      case DialogPosition.topEnd:
        return AlignmentDirectional.topEnd;
      case DialogPosition.centerStart:
        return AlignmentDirectional.centerStart;
      case DialogPosition.center:
        return AlignmentDirectional.center;
      case DialogPosition.centerEnd:
        return AlignmentDirectional.centerEnd;
      case DialogPosition.bottomStart:
        return AlignmentDirectional.bottomStart;
      case DialogPosition.bottomCenter:
        return AlignmentDirectional.bottomCenter;
      case DialogPosition.bottomEnd:
        return AlignmentDirectional.bottomEnd;
      case DialogPosition.offScreen:
        return AlignmentDirectional.center;
    }
  }

  /// Returns the [Offset] for slide transition based on this position.
  ///
  /// The offset represents where the dialog comes FROM when animating in.
  /// For example, [topCenter] returns `Offset(0, -1)` meaning it slides down from above.
  Offset toSlideOffset(TextDirection textDirection) {
    final isRtl = textDirection == TextDirection.rtl;

    switch (this) {
      case DialogPosition.topStart:
        return Offset(isRtl ? 1 : -1, -1);
      case DialogPosition.topCenter:
        return const Offset(0, -1);
      case DialogPosition.topEnd:
        return Offset(isRtl ? -1 : 1, -1);
      case DialogPosition.centerStart:
        return Offset(isRtl ? 1 : -1, 0);
      case DialogPosition.center:
        return Offset.zero;
      case DialogPosition.centerEnd:
        return Offset(isRtl ? -1 : 1, 0);
      case DialogPosition.bottomStart:
        return Offset(isRtl ? 1 : -1, 1);
      case DialogPosition.bottomCenter:
        return const Offset(0, 1);
      case DialogPosition.bottomEnd:
        return Offset(isRtl ? -1 : 1, 1);
      case DialogPosition.offScreen:
        return const Offset(0, 2); // Far below screen
    }
  }

  /// Returns a human-readable name for this position.
  String get displayName {
    switch (this) {
      case DialogPosition.topStart:
        return 'Top Start';
      case DialogPosition.topCenter:
        return 'Top Center';
      case DialogPosition.topEnd:
        return 'Top End';
      case DialogPosition.centerStart:
        return 'Center Start';
      case DialogPosition.center:
        return 'Center';
      case DialogPosition.centerEnd:
        return 'Center End';
      case DialogPosition.bottomStart:
        return 'Bottom Start';
      case DialogPosition.bottomCenter:
        return 'Bottom Center';
      case DialogPosition.bottomEnd:
        return 'Bottom End';
      case DialogPosition.offScreen:
        return 'Off Screen';
    }
  }

  /// Returns `true` if this is a top position.
  bool get isTop =>
      this == DialogPosition.topStart ||
      this == DialogPosition.topCenter ||
      this == DialogPosition.topEnd;

  /// Returns `true` if this is a center (middle row) position.
  bool get isCenterRow =>
      this == DialogPosition.centerStart ||
      this == DialogPosition.center ||
      this == DialogPosition.centerEnd;

  /// Returns `true` if this is a bottom position.
  bool get isBottom =>
      this == DialogPosition.bottomStart ||
      this == DialogPosition.bottomCenter ||
      this == DialogPosition.bottomEnd;

  /// Returns `true` if this is a start (left in LTR) position.
  bool get isStart =>
      this == DialogPosition.topStart ||
      this == DialogPosition.centerStart ||
      this == DialogPosition.bottomStart;

  /// Returns `true` if this is a center column position.
  bool get isCenterColumn =>
      this == DialogPosition.topCenter ||
      this == DialogPosition.center ||
      this == DialogPosition.bottomCenter;

  /// Returns `true` if this is an end (right in LTR) position.
  bool get isEnd =>
      this == DialogPosition.topEnd ||
      this == DialogPosition.centerEnd ||
      this == DialogPosition.bottomEnd;
}
