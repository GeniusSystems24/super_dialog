part of '../../super_dialog.dart';

/// Builds the appropriate transition widget for a given [DialogAnimation].
///
/// This function is used internally by [SuperDialog] to create the
/// transition effect for dialogs.
///
/// Parameters:
/// - [context]: The build context for accessing directionality
/// - [animationType]: The type of animation to build
/// - [animation]: The animation controller driving the transition
/// - [child]: The dialog content to animate
Widget _buildDialogTransition(
  BuildContext context,
  DialogAnimation animationType,
  Animation<double> animation,
  Widget child,
) {
  switch (animationType) {
    // ========================================================================
    // SLIDE ANIMATIONS
    // ========================================================================
    case DialogAnimation.startToEnd:
      final textDirection = Directionality.of(context);
      final begin = textDirection == TextDirection.rtl
          ? const Offset(1, 0)
          : const Offset(-1, 0);
      return _buildSlideFadeTransition(
        animation,
        begin,
        AlignmentDirectional.centerStart,
        child,
      );

    case DialogAnimation.endToStart:
      final textDirection = Directionality.of(context);
      final begin = textDirection == TextDirection.rtl
          ? const Offset(-1, 0)
          : const Offset(1, 0);
      return _buildSlideFadeTransition(
        animation,
        begin,
        AlignmentDirectional.centerEnd,
        child,
      );

    case DialogAnimation.topToBottom:
      return _buildSlideFadeTransition(
        animation,
        const Offset(0, -1),
        Alignment.topCenter,
        child,
      );

    case DialogAnimation.bottomToTop:
      return _buildSlideFadeTransition(
        animation,
        const Offset(0, 1),
        Alignment.bottomCenter,
        child,
      );

    // ========================================================================
    // SCALE & FADE ANIMATIONS
    // ========================================================================
    case DialogAnimation.centerScale:
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation.drive(Tween<double>(begin: 0.92, end: 1.0)),
          child: child,
        ),
      );

    case DialogAnimation.centerFade:
      return FadeTransition(opacity: animation, child: child);

    // ========================================================================
    // ROTATION ANIMATIONS
    // ========================================================================
    case DialogAnimation.rotateIn:
      return FadeTransition(
        opacity: animation,
        child: RotationTransition(
          turns: animation.drive(
            Tween<double>(begin: -0.042, end: 0.0), // -15 degrees to 0
          ),
          child: child,
        ),
      );

    case DialogAnimation.rotateScale:
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation.drive(Tween<double>(begin: 0.7, end: 1.0)),
          child: RotationTransition(
            turns: animation.drive(
              Tween<double>(begin: -0.042, end: 0.0), // -15 degrees to 0
            ),
            child: child,
          ),
        ),
      );

    // ========================================================================
    // BOUNCE ANIMATIONS
    // ========================================================================
    case DialogAnimation.bounceIn:
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
          ),
          child: child,
        ),
      );

    case DialogAnimation.bounceSlidBottom:
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.elasticOut,
      );
      return Align(
        alignment: Alignment.bottomCenter,
        child: SlideTransition(
          position: curvedAnimation.drive(
            Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
          ),
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    // ========================================================================
    // ELASTIC ANIMATIONS
    // ========================================================================
    case DialogAnimation.elasticIn:
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          ).drive(Tween<double>(begin: 0.5, end: 1.0)),
          child: child,
        ),
      );

    case DialogAnimation.elasticSlideBottom:
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
      );
      return Align(
        alignment: Alignment.bottomCenter,
        child: SlideTransition(
          position: curvedAnimation.drive(
            Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
          ),
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    // ========================================================================
    // EXPAND ANIMATIONS
    // ========================================================================
    case DialogAnimation.expandVertical:
      return FadeTransition(
        opacity: animation,
        child: Align(
          alignment: Alignment.center,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.scale(
                scaleY: animation.value,
                scaleX: 1.0,
                child: child,
              );
            },
            child: child,
          ),
        ),
      );

    case DialogAnimation.expandHorizontal:
      return FadeTransition(
        opacity: animation,
        child: Align(
          alignment: Alignment.center,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.scale(
                scaleX: animation.value,
                scaleY: 1.0,
                child: child,
              );
            },
            child: child,
          ),
        ),
      );

    case DialogAnimation.expandCenter:
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation.drive(
            Tween<double>(begin: 0.0, end: 1.0).chain(
              CurveTween(curve: Curves.easeOutCubic),
            ),
          ),
          child: child,
        ),
      );

    // ========================================================================
    // FLIP ANIMATIONS
    // ========================================================================
    case DialogAnimation.flipHorizontal:
      return FadeTransition(
        opacity: animation,
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final angle = animation.value * 3.14159; // 0 to π (180 degrees)
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateX(3.14159 - angle), // Start from back (π) to front (0)
              alignment: Alignment.center,
              child: child,
            );
          },
          child: child,
        ),
      );

    case DialogAnimation.flipVertical:
      return FadeTransition(
        opacity: animation,
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final angle = animation.value * 3.14159; // 0 to π (180 degrees)
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateY(3.14159 - angle), // Start from back (π) to front (0)
              alignment: Alignment.center,
              child: child,
            );
          },
          child: child,
        ),
      );

    // ========================================================================
    // COMBINED ANIMATIONS
    // ========================================================================
    case DialogAnimation.slideRotateBottom:
      return Align(
        alignment: Alignment.bottomCenter,
        child: SlideTransition(
          position: animation.drive(
            Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
          ),
          child: FadeTransition(
            opacity: animation,
            child: RotationTransition(
              turns: animation.drive(
                Tween<double>(begin: -0.028, end: 0.0), // -10 degrees to 0
              ),
              child: child,
            ),
          ),
        ),
      );

    case DialogAnimation.slideRotateTop:
      return Align(
        alignment: Alignment.topCenter,
        child: SlideTransition(
          position: animation.drive(
            Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero),
          ),
          child: FadeTransition(
            opacity: animation,
            child: RotationTransition(
              turns: animation.drive(
                Tween<double>(begin: 0.028, end: 0.0), // 10 degrees to 0
              ),
              child: child,
            ),
          ),
        ),
      );

    case DialogAnimation.slideScaleStart:
      final textDirection = Directionality.of(context);
      final begin = textDirection == TextDirection.rtl
          ? const Offset(1, 0)
          : const Offset(-1, 0);
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: SlideTransition(
          position: animation.drive(
            Tween<Offset>(begin: begin, end: Offset.zero),
          ),
          child: FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation.drive(Tween<double>(begin: 0.8, end: 1.0)),
              child: child,
            ),
          ),
        ),
      );

    case DialogAnimation.slideScaleEnd:
      final textDirection = Directionality.of(context);
      final begin = textDirection == TextDirection.rtl
          ? const Offset(-1, 0)
          : const Offset(1, 0);
      return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: SlideTransition(
          position: animation.drive(
            Tween<Offset>(begin: begin, end: Offset.zero),
          ),
          child: FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation.drive(Tween<double>(begin: 0.8, end: 1.0)),
              child: child,
            ),
          ),
        ),
      );
  }
}

/// Builds a combined slide and fade transition.
///
/// The widget slides from [begin] offset to [Offset.zero] while
/// fading from 0 to 1 opacity.
Widget _buildSlideFadeTransition(
  Animation<double> animation,
  Offset begin,
  AlignmentGeometry alignment,
  Widget child,
) {
  final positionAnimation = animation.drive(
    Tween<Offset>(begin: begin, end: Offset.zero),
  );

  return Align(
    alignment: alignment,
    child: SlideTransition(
      position: positionAnimation,
      child: FadeTransition(opacity: animation, child: child),
    ),
  );
}

/// A custom transition builder that can be used with Flutter's dialog system.
///
/// This class wraps [_buildDialogTransition] in a reusable component.
class DialogTransitionBuilder {
  /// Creates a transition builder for the specified animation type.
  const DialogTransitionBuilder(this.animationType);

  /// The animation type to use for transitions.
  final DialogAnimation animationType;

  /// Builds the transition for use with dialog routes.
  Widget build(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return _buildDialogTransition(context, animationType, animation, child);
  }
}

// ============================================================================
// POSITIONED TRANSITIONS
// ============================================================================

/// Builds a positioned slide transition from [startPosition] to [endPosition].
///
/// This provides more granular control over dialog animations by specifying
/// exact start and end positions on a 3x3 grid.
///
/// Parameters:
/// - [context]: The build context for accessing text direction
/// - [animation]: The animation controller (0.0 to 1.0)
/// - [startPosition]: Where the dialog starts (off-screen or a position)
/// - [endPosition]: Where the dialog ends (final resting position)
/// - [child]: The dialog content
/// - [withFade]: Whether to include fade animation (default: true)
/// - [withScale]: Whether to include scale animation (default: false)
Widget _buildPositionedTransition(
  BuildContext context,
  Animation<double> animation,
  DialogPosition startPosition,
  DialogPosition endPosition,
  Widget child, {
  bool withFade = true,
  bool withScale = false,
}) {
  final textDirection = Directionality.of(context);

  // Get the final alignment for the dialog
  final alignment = endPosition.toAlignmentDirectional();

  // Calculate the START offset relative to the END position
  // The end offset should always be Offset.zero because Align handles positioning
  final Offset startOffset;

  if (startPosition == DialogPosition.offScreen) {
    // Coming from off-screen: use the end position to determine direction
    startOffset = _getOffScreenOffset(endPosition, textDirection);
  } else if (startPosition == endPosition) {
    // Same position: no slide, just appear
    startOffset = Offset.zero;
  } else {
    // Moving from one position to another
    startOffset = _getRelativeSlideOffset(
      startPosition,
      endPosition,
      textDirection,
    );
  }

  // Build the position animation - always ends at zero (final position)
  final positionAnimation = animation.drive(
    Tween<Offset>(begin: startOffset, end: Offset.zero),
  );

  // Build the widget with optional animations
  Widget result = child;

  if (withScale) {
    result = ScaleTransition(
      scale: animation.drive(Tween<double>(begin: 0.85, end: 1.0)),
      child: result,
    );
  }

  if (withFade) {
    result = FadeTransition(opacity: animation, child: result);
  }

  result = SlideTransition(position: positionAnimation, child: result);

  return Align(alignment: alignment, child: result);
}

/// Gets the offset for sliding in from off-screen based on the end position.
Offset _getOffScreenOffset(
  DialogPosition endPosition,
  TextDirection textDirection,
) {
  final isRtl = textDirection == TextDirection.rtl;

  // Determine the direction to come from based on end position
  if (endPosition.isTop) {
    return const Offset(0, -1); // Come from above
  } else if (endPosition.isBottom) {
    return const Offset(0, 1); // Come from below
  } else if (endPosition.isStart) {
    return Offset(isRtl ? 1 : -1, 0); // Come from start side
  } else if (endPosition.isEnd) {
    return Offset(isRtl ? -1 : 1, 0); // Come from end side
  } else {
    // Center - default to coming from bottom
    return const Offset(0, 1);
  }
}

/// Gets the relative offset for sliding from one position to another.
Offset _getRelativeSlideOffset(
  DialogPosition from,
  DialogPosition to,
  TextDirection textDirection,
) {
  final isRtl = textDirection == TextDirection.rtl;

  // Calculate row difference (0=top, 1=center, 2=bottom)
  int getRow(DialogPosition pos) {
    if (pos.isTop) return 0;
    if (pos.isCenterRow) return 1;
    return 2;
  }

  // Calculate column difference (0=start, 1=center, 2=end)
  int getCol(DialogPosition pos) {
    if (pos.isStart) return 0;
    if (pos.isCenterColumn) return 1;
    return 2;
  }

  final fromRow = getRow(from);
  final fromCol = getCol(from);
  final toRow = getRow(to);
  final toCol = getCol(to);

  // Calculate the offset FROM the start position TO the end position
  // Negative means the start is to the left/above, positive means right/below
  double dx = (fromCol - toCol).toDouble();
  double dy = (fromRow - toRow).toDouble();

  // Apply RTL for horizontal movement
  if (isRtl) {
    dx = -dx;
  }

  return Offset(dx, dy);
}

/// Transition type for positioned dialogs.
enum PositionedTransitionType {
  /// Simple slide transition.
  slide,

  /// Slide with fade.
  slideFade,

  /// Slide with scale.
  slideScale,

  /// Slide with both fade and scale.
  slideFadeScale,

  /// Pure fade (no movement).
  fade,

  /// Pure scale (no movement).
  scale,

  /// Scale with fade (no movement).
  scaleFade,

  /// Bounce effect with elastic curve.
  ///
  /// Creates a playful, springy entrance with overshoot.
  /// Best for success messages and celebratory dialogs.
  bounce,

  /// Elastic scale with overshoot.
  ///
  /// Creates a spring-like, organic entrance.
  /// Best for interactive dialogs and modern UIs.
  elastic,

  /// Zoom with overshoot effect.
  ///
  /// Scales from 0.88 to 1.0 with easeOutBack curve.
  /// Creates a smooth, professional entrance with subtle bounce.
  /// Best for standard dialogs and modals.
  zoom,
}

/// Extension for [PositionedTransitionType].
extension PositionedTransitionTypeExtension on PositionedTransitionType {
  /// Whether this transition includes fade.
  bool get hasFade =>
      this == PositionedTransitionType.slideFade ||
      this == PositionedTransitionType.slideFadeScale ||
      this == PositionedTransitionType.fade ||
      this == PositionedTransitionType.scaleFade;

  /// Whether this transition includes scale.
  bool get hasScale =>
      this == PositionedTransitionType.slideScale ||
      this == PositionedTransitionType.slideFadeScale ||
      this == PositionedTransitionType.scale ||
      this == PositionedTransitionType.scaleFade ||
      this == PositionedTransitionType.bounce ||
      this == PositionedTransitionType.elastic ||
      this == PositionedTransitionType.zoom;

  /// Whether this transition includes slide.
  bool get hasSlide =>
      this == PositionedTransitionType.slide ||
      this == PositionedTransitionType.slideFade ||
      this == PositionedTransitionType.slideScale ||
      this == PositionedTransitionType.slideFadeScale;

  /// Whether this transition uses elastic/bounce curves.
  bool get isElastic =>
      this == PositionedTransitionType.bounce ||
      this == PositionedTransitionType.elastic;
}

/// A transition builder for positioned dialogs.
class PositionedDialogTransitionBuilder {
  /// Creates a positioned transition builder.
  const PositionedDialogTransitionBuilder({
    required this.startPosition,
    required this.endPosition,
    this.transitionType = PositionedTransitionType.slideFade,
  });

  /// The starting position of the dialog.
  final DialogPosition startPosition;

  /// The ending position of the dialog.
  final DialogPosition endPosition;

  /// The type of transition to apply.
  final PositionedTransitionType transitionType;

  /// Builds the transition widget.
  Widget build(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Handle special transition types
    if (transitionType == PositionedTransitionType.bounce) {
      return Align(
        alignment: endPosition.toAlignmentDirectional(),
        child: FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.elasticOut,
            ),
            child: child,
          ),
        ),
      );
    }

    if (transitionType == PositionedTransitionType.elastic) {
      return Align(
        alignment: endPosition.toAlignmentDirectional(),
        child: FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ).drive(Tween<double>(begin: 0.5, end: 1.0)),
            child: child,
          ),
        ),
      );
    }

    if (transitionType == PositionedTransitionType.zoom) {
      return Align(
        alignment: endPosition.toAlignmentDirectional(),
        child: FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ).drive(Tween<double>(begin: 0.88, end: 1.0)),
            child: child,
          ),
        ),
      );
    }

    // Handle non-slide transitions
    if (!transitionType.hasSlide) {
      Widget result = child;

      if (transitionType.hasScale) {
        result = ScaleTransition(
          scale: animation.drive(Tween<double>(begin: 0.85, end: 1.0)),
          child: result,
        );
      }

      if (transitionType.hasFade) {
        result = FadeTransition(opacity: animation, child: result);
      }

      return Align(
        alignment: endPosition.toAlignmentDirectional(),
        child: result,
      );
    }

    // Handle slide transitions
    return _buildPositionedTransition(
      context,
      animation,
      startPosition,
      endPosition,
      child,
      withFade: transitionType.hasFade,
      withScale: transitionType.hasScale,
    );
  }
}
