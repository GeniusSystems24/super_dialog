part of '../../super_dialog.dart';

/// Defines the animation style for showing and hiding dialogs.
///
/// Each animation type provides a different visual effect for how the
/// dialog enters and exits the screen.
///
/// ## Animation Sequences
///
/// **Opening sequence:**
/// 1. Show barrier with motion
/// 2. Animate in dialog with motion
///
/// **Closing sequence:**
/// 1. Animate out dialog with motion
/// 2. Hide barrier with motion
///
/// ## Example
///
/// ```dart
/// SuperDialog.showAnimatedDialog(
///   context,
///   (context) => MyDialog(),
///   animation: DialogAnimation.bottomToTop,
/// );
/// ```
enum DialogAnimation {
  /// Slides in from the start to the end.
  ///
  /// The direction depends on [Directionality]:
  /// - LTR: slides from left to right
  /// - RTL: slides from right to left
  ///
  /// Best for side drawers and navigation panels.
  startToEnd,

  /// Slides in from the end to the start.
  ///
  /// The direction depends on [Directionality]:
  /// - LTR: slides from right to left
  /// - RTL: slides from left to right
  ///
  /// Best for settings panels and details views.
  endToStart,

  /// Slides in from the top to the bottom.
  ///
  /// Best for notifications, banners, and alerts.
  topToBottom,

  /// Slides in from the bottom to the top.
  ///
  /// Best for bottom sheets and action menus.
  /// This is the default style on iOS/macOS platforms.
  bottomToTop,

  /// Scales in from the center with a subtle zoom effect.
  ///
  /// The dialog scales from 92% to 100% while fading in.
  /// Best for confirmation dialogs and important alerts.
  centerScale,

  /// Fades in from the center without any motion.
  ///
  /// A subtle, minimal animation that works well for
  /// toasts, status messages, and quick notifications.
  centerFade,
}

/// Extension methods for [DialogAnimation].
extension DialogAnimationExtension on DialogAnimation {
  /// Returns a human-readable name for this animation.
  String get displayName {
    switch (this) {
      case DialogAnimation.startToEnd:
        return 'Start to End';
      case DialogAnimation.endToStart:
        return 'End to Start';
      case DialogAnimation.topToBottom:
        return 'Top to Bottom';
      case DialogAnimation.bottomToTop:
        return 'Bottom to Top';
      case DialogAnimation.centerScale:
        return 'Center Scale';
      case DialogAnimation.centerFade:
        return 'Center Fade';
    }
  }

  /// Returns `true` if this animation involves sliding motion.
  bool get isSlide {
    return this == DialogAnimation.startToEnd ||
        this == DialogAnimation.endToStart ||
        this == DialogAnimation.topToBottom ||
        this == DialogAnimation.bottomToTop;
  }

  /// Returns `true` if this animation involves scaling.
  bool get isScale => this == DialogAnimation.centerScale;

  /// Returns `true` if this animation is fade-only.
  bool get isFadeOnly => this == DialogAnimation.centerFade;

  /// Returns `true` if this animation is horizontal.
  bool get isHorizontal {
    return this == DialogAnimation.startToEnd ||
        this == DialogAnimation.endToStart;
  }

  /// Returns `true` if this animation is vertical.
  bool get isVertical {
    return this == DialogAnimation.topToBottom ||
        this == DialogAnimation.bottomToTop;
  }
}
