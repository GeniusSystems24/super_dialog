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
