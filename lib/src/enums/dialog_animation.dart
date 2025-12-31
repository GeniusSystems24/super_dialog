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
  // ============================================================================
  // SLIDE ANIMATIONS
  // ============================================================================

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

  // ============================================================================
  // SCALE & FADE ANIMATIONS
  // ============================================================================

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

  // ============================================================================
  // ROTATION ANIMATIONS
  // ============================================================================

  /// Rotates in with a fade effect.
  ///
  /// The dialog rotates from -15 degrees to 0 while fading in.
  /// Creates a playful, dynamic entrance.
  /// Best for fun notifications and casual dialogs.
  rotateIn,

  /// Rotates and scales in simultaneously.
  ///
  /// Combines rotation (-15° to 0°) with scale (0.7 to 1.0) and fade.
  /// Creates a dynamic, attention-grabbing entrance.
  /// Best for important announcements and special dialogs.
  rotateScale,

  // ============================================================================
  // BOUNCE ANIMATIONS
  // ============================================================================

  /// Bounces in with an elastic effect.
  ///
  /// The dialog scales from 0 to 1.0 with a bounce curve.
  /// Creates a playful, energetic entrance.
  /// Best for success messages and celebratory dialogs.
  bounceIn,

  /// Slides from bottom with a bounce effect.
  ///
  /// Combines upward slide with elastic bounce curve.
  /// Creates a lively, springy entrance.
  /// Best for action sheets and bottom menus with personality.
  bounceSlidBottom,

  // ============================================================================
  // ELASTIC ANIMATIONS
  // ============================================================================

  /// Elastic scale animation.
  ///
  /// The dialog scales with an elastic overshoot effect.
  /// Creates a spring-like, organic entrance.
  /// Best for interactive dialogs and game-like UIs.
  elasticIn,

  /// Elastic slide from bottom.
  ///
  /// Slides up with elastic overshoot at the end.
  /// Creates a smooth but springy entrance.
  /// Best for modern bottom sheets and action menus.
  elasticSlideBottom,

  // ============================================================================
  // EXPAND ANIMATIONS
  // ============================================================================

  /// Expands vertically from the center.
  ///
  /// The dialog scales from 0% to 100% height while fading in.
  /// Creates an unfolding effect.
  /// Best for dropdown menus and expandable panels.
  expandVertical,

  /// Expands horizontally from the center.
  ///
  /// The dialog scales from 0% to 100% width while fading in.
  /// Creates a stretching effect.
  /// Best for side panels and horizontal menus.
  expandHorizontal,

  /// Expands from the center in all directions.
  ///
  /// The dialog scales uniformly with a subtle zoom.
  /// Creates a smooth expansion effect.
  /// Best for centered modals and overlays.
  expandCenter,

  // ============================================================================
  // FLIP ANIMATIONS
  // ============================================================================

  /// Flips in around the horizontal axis.
  ///
  /// The dialog rotates around the X-axis (top-bottom flip).
  /// Creates a card-flip effect.
  /// Best for revealing information and flip cards.
  flipHorizontal,

  /// Flips in around the vertical axis.
  ///
  /// The dialog rotates around the Y-axis (left-right flip).
  /// Creates a page-turn effect.
  /// Best for card reveals and page transitions.
  flipVertical,

  // ============================================================================
  // COMBINED ANIMATIONS
  // ============================================================================

  /// Slides from bottom with rotation.
  ///
  /// Combines upward slide with rotation (-10° to 0°).
  /// Creates a dynamic, modern entrance.
  /// Best for modern mobile UIs and action sheets.
  slideRotateBottom,

  /// Slides from top with rotation.
  ///
  /// Combines downward slide with rotation (10° to 0°).
  /// Creates a dynamic notification effect.
  /// Best for notifications and top banners.
  slideRotateTop,

  /// Slides from start with scale.
  ///
  /// Combines horizontal slide with scale (0.8 to 1.0).
  /// Creates a smooth, professional entrance.
  /// Best for navigation panels and side menus.
  slideScaleStart,

  /// Slides from end with scale.
  ///
  /// Combines horizontal slide with scale (0.8 to 1.0).
  /// Creates a smooth, professional entrance.
  /// Best for settings panels and detail views.
  slideScaleEnd,
}

/// Extension methods for [DialogAnimation].
extension DialogAnimationExtension on DialogAnimation {
  /// Returns a human-readable name for this animation.
  String get displayName {
    switch (this) {
      // Slide animations
      case DialogAnimation.startToEnd:
        return 'Start to End';
      case DialogAnimation.endToStart:
        return 'End to Start';
      case DialogAnimation.topToBottom:
        return 'Top to Bottom';
      case DialogAnimation.bottomToTop:
        return 'Bottom to Top';
      // Scale & fade animations
      case DialogAnimation.centerScale:
        return 'Center Scale';
      case DialogAnimation.centerFade:
        return 'Center Fade';
      // Rotation animations
      case DialogAnimation.rotateIn:
        return 'Rotate In';
      case DialogAnimation.rotateScale:
        return 'Rotate Scale';
      // Bounce animations
      case DialogAnimation.bounceIn:
        return 'Bounce In';
      case DialogAnimation.bounceSlidBottom:
        return 'Bounce Slide Bottom';
      // Elastic animations
      case DialogAnimation.elasticIn:
        return 'Elastic In';
      case DialogAnimation.elasticSlideBottom:
        return 'Elastic Slide Bottom';
      // Expand animations
      case DialogAnimation.expandVertical:
        return 'Expand Vertical';
      case DialogAnimation.expandHorizontal:
        return 'Expand Horizontal';
      case DialogAnimation.expandCenter:
        return 'Expand Center';
      // Flip animations
      case DialogAnimation.flipHorizontal:
        return 'Flip Horizontal';
      case DialogAnimation.flipVertical:
        return 'Flip Vertical';
      // Combined animations
      case DialogAnimation.slideRotateBottom:
        return 'Slide Rotate Bottom';
      case DialogAnimation.slideRotateTop:
        return 'Slide Rotate Top';
      case DialogAnimation.slideScaleStart:
        return 'Slide Scale Start';
      case DialogAnimation.slideScaleEnd:
        return 'Slide Scale End';
    }
  }

  /// Returns `true` if this animation involves sliding motion.
  bool get isSlide {
    return this == DialogAnimation.startToEnd ||
        this == DialogAnimation.endToStart ||
        this == DialogAnimation.topToBottom ||
        this == DialogAnimation.bottomToTop ||
        this == DialogAnimation.bounceSlidBottom ||
        this == DialogAnimation.elasticSlideBottom ||
        this == DialogAnimation.slideRotateBottom ||
        this == DialogAnimation.slideRotateTop ||
        this == DialogAnimation.slideScaleStart ||
        this == DialogAnimation.slideScaleEnd;
  }

  /// Returns `true` if this animation involves scaling.
  bool get isScale {
    return this == DialogAnimation.centerScale ||
        this == DialogAnimation.rotateScale ||
        this == DialogAnimation.bounceIn ||
        this == DialogAnimation.elasticIn ||
        this == DialogAnimation.expandVertical ||
        this == DialogAnimation.expandHorizontal ||
        this == DialogAnimation.expandCenter ||
        this == DialogAnimation.slideScaleStart ||
        this == DialogAnimation.slideScaleEnd;
  }

  /// Returns `true` if this animation involves rotation.
  bool get isRotation {
    return this == DialogAnimation.rotateIn ||
        this == DialogAnimation.rotateScale ||
        this == DialogAnimation.flipHorizontal ||
        this == DialogAnimation.flipVertical ||
        this == DialogAnimation.slideRotateBottom ||
        this == DialogAnimation.slideRotateTop;
  }

  /// Returns `true` if this animation uses elastic/bounce curves.
  bool get isElastic {
    return this == DialogAnimation.bounceIn ||
        this == DialogAnimation.bounceSlidBottom ||
        this == DialogAnimation.elasticIn ||
        this == DialogAnimation.elasticSlideBottom;
  }

  /// Returns `true` if this animation is fade-only.
  bool get isFadeOnly => this == DialogAnimation.centerFade;

  /// Returns `true` if this animation is horizontal.
  bool get isHorizontal {
    return this == DialogAnimation.startToEnd ||
        this == DialogAnimation.endToStart ||
        this == DialogAnimation.expandHorizontal ||
        this == DialogAnimation.flipVertical ||
        this == DialogAnimation.slideScaleStart ||
        this == DialogAnimation.slideScaleEnd;
  }

  /// Returns `true` if this animation is vertical.
  bool get isVertical {
    return this == DialogAnimation.topToBottom ||
        this == DialogAnimation.bottomToTop ||
        this == DialogAnimation.bounceSlidBottom ||
        this == DialogAnimation.elasticSlideBottom ||
        this == DialogAnimation.expandVertical ||
        this == DialogAnimation.flipHorizontal ||
        this == DialogAnimation.slideRotateBottom ||
        this == DialogAnimation.slideRotateTop;
  }
}
