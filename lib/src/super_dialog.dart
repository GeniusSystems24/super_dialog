part of '../../super_dialog.dart';

/// A powerful, flexible dialog system with beautiful animations.
///
/// This abstract class provides static methods for showing animated dialogs
/// with various transition effects.
///
/// ## Quick Start
///
/// ```dart
/// import 'package:super_dialog/super_dialog.dart';
///
/// // Show a simple animated dialog
/// SuperDialog.showAnimatedDialog<void>(
///   context,
///   (context) => MyDialog(),
///   animation: DialogAnimation.bottomToTop,
/// );
/// ```
///
/// ## Available Methods
///
/// - [showAnimatedDialog]: Shows a dialog with animation (barrier dismissible by default)
/// - [showAnimatedGeneralDialog]: Shows a dialog with full control over all options
/// - [showAnimatedAdaptiveDialog]: Shows a platform-adaptive dialog
///
/// ## Root Navigator
///
/// Set [rootKey] to use a custom root navigator for nested navigation:
///
/// ```dart
/// SuperDialog.rootKey = myNavigatorKey;
/// ```
abstract class SuperDialog {
  /// A global key for the root navigator.
  ///
  /// Set this to enable proper dialog display in nested navigation scenarios.
  /// When set, dialogs will use this navigator instead of the default one.
  static GlobalKey<NavigatorState>? rootKey;

  /// The default configuration used when no config is provided.
  ///
  /// Preserves the original package defaults when no theme is available.
  /// Registered [SuperDialogThemeData] values take precedence.
  static const SuperDialogConfig defaultConfig = SuperDialogConfig();

  /// Shows an animated dialog with sensible defaults.
  ///
  /// This is the primary method for showing dialogs. By default, the barrier
  /// is dismissible, meaning users can tap outside the dialog to close it.
  ///
  /// ## Parameters
  ///
  /// - [context]: The build context
  /// - [builder]: A function that builds the dialog content
  /// - [config]: Optional animation configuration
  /// - [animation]: The animation style (default: [DialogAnimation.startToEnd])
  /// - [constraints]: Optional size constraints for the dialog
  /// - [useRootNavigator]: Whether to use the root navigator (default: true)
  /// - [useSafeArea]: Whether to wrap in SafeArea (default: true)
  /// - [barrierDismissible]: Whether tapping barrier closes dialog (default: true)
  /// - [barrierColor]: The barrier color (defaults to [SuperDialogThemeData])
  /// - [barrierBlur]: Optional Gaussian blur for the barrier
  /// - [onDismissed]: Callback when the dialog is dismissed
  ///
  /// ## Example
  ///
  /// ```dart
  /// final result = await SuperDialog.showAnimatedDialog<bool>(
  ///   context,
  ///   (context) => ConfirmDialog(
  ///     onConfirm: () => Navigator.of(context).pop(true),
  ///     onCancel: () => Navigator.of(context).pop(false),
  ///   ),
  ///   animation: DialogAnimation.centerScale,
  ///   barrierColor: Colors.black54,
  /// );
  /// ```
  static Future<T?> showAnimatedDialog<T extends Object?>(
    BuildContext context,
    WidgetBuilder builder, {
    SuperDialogConfig? config,
    DialogAnimation animation = DialogAnimation.startToEnd,
    BoxConstraints? constraints,
    bool? useRootNavigator,
    bool useSafeArea = true,
    bool? barrierDismissible,
    Color? barrierColor,
    double? barrierBlur,
    VoidCallback? onDismissed,
  }) {
    return showAnimatedGeneralDialog<T>(
      context,
      builder,
      config: config,
      animation: animation,
      constraints: constraints,
      useRootNavigator: useRootNavigator,
      useSafeArea: useSafeArea,
      barrierDismissible: barrierDismissible ?? true,
      barrierColor: barrierColor,
      barrierBlur: barrierBlur,
      onDismissed: onDismissed,
    );
  }

  /// Shows an animated dialog with full control over all options.
  ///
  /// Unlike [showAnimatedDialog], this method defaults to a non-dismissible
  /// barrier, giving you complete control over the dialog behavior.
  ///
  /// ## Parameters
  ///
  /// Same as [showAnimatedDialog], but [barrierDismissible] defaults to `false`.
  ///
  /// ## Example
  ///
  /// ```dart
  /// SuperDialog.showAnimatedGeneralDialog<void>(
  ///   context,
  ///   (context) => LoadingDialog(),
  ///   animation: DialogAnimation.centerFade,
  ///   barrierDismissible: false, // User cannot dismiss
  /// );
  /// ```
  static Future<T?> showAnimatedGeneralDialog<T extends Object?>(
    BuildContext context,
    WidgetBuilder builder, {
    SuperDialogConfig? config,
    DialogAnimation animation = DialogAnimation.startToEnd,
    BoxConstraints? constraints,
    bool? useRootNavigator,
    bool useSafeArea = true,
    bool? barrierDismissible,
    Color? barrierColor,
    double? barrierBlur,
    VoidCallback? onDismissed,
  }) {
    final dialogTheme = SuperDialogThemeData.of(context);
    final bool resolvedUseRootNavigator = useRootNavigator ?? true;
    final BuildContext navigatorContext = _resolveNavigatorContext(
      context,
      resolvedUseRootNavigator,
    );
    final navigator = Navigator.of(
      navigatorContext,
      rootNavigator: resolvedUseRootNavigator,
    );
    final SuperDialogConfig effectiveConfig = config ?? dialogTheme.config;
    final double effectiveBarrierBlur = barrierBlur ?? dialogTheme.barrierBlur;
    final String barrierLabel = MaterialLocalizations.of(
      navigatorContext,
    ).modalBarrierDismissLabel;

    final route = _SuperDialogRoute<T>(
      pageBuilder: (context, animationController, secondaryAnimation) {
        return _buildDialogPage(
          context: context,
          builder: builder,
          constraints: constraints,
          useSafeArea: useSafeArea,
          barrierBlur: effectiveBarrierBlur,
        );
      },
      transitionBuilder:
          (context, animationController, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animationController,
              curve: effectiveConfig.openCurve,
              reverseCurve: effectiveConfig.closeCurve,
            );
            return _buildDialogTransition(
              context,
              animation,
              curvedAnimation,
              child,
            );
          },
      transitionDuration: effectiveConfig.openDuration,
      reverseTransitionDuration: effectiveConfig.closeDuration,
      barrierDismissible: barrierDismissible ?? false,
      barrierLabel: barrierLabel,
      barrierColor: barrierColor ?? dialogTheme.barrierColor,
      settings: const RouteSettings(name: 'super_dialog'),
    );

    final future = navigator.push<T>(route);
    if (onDismissed != null) {
      future.whenComplete(onDismissed);
    }
    return future;
  }

  /// Shows a platform-adaptive animated dialog.
  ///
  /// This method automatically adjusts the animation style and barrier
  /// behavior based on the current platform:
  ///
  /// - **iOS/macOS**: Uses [DialogAnimation.bottomToTop] with blur,
  ///   barrier is not dismissible by default
  /// - **Other platforms**: Uses the specified animation (default: startToEnd),
  ///   barrier is dismissible by default
  ///
  /// ## Example
  ///
  /// ```dart
  /// SuperDialog.showAnimatedAdaptiveDialog<void>(
  ///   context,
  ///   (context) => SettingsDialog(),
  /// );
  /// // On iOS: slides from bottom with blur
  /// // On Android: slides from start with no blur
  /// ```
  static Future<T?> showAnimatedAdaptiveDialog<T extends Object?>(
    BuildContext context,
    WidgetBuilder builder, {
    SuperDialogConfig? config,
    DialogAnimation animation = DialogAnimation.startToEnd,
    BoxConstraints? constraints,
    bool? useRootNavigator,
    bool useSafeArea = true,
    bool? barrierDismissible,
    Color? barrierColor,
    double? barrierBlur,
    VoidCallback? onDismissed,
  }) {
    final platform = Theme.of(context).platform;
    final bool cupertinoStyle =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    // Adapt animation for Cupertino platforms
    final DialogAnimation platformAnimation =
        animation == DialogAnimation.startToEnd && cupertinoStyle
        ? DialogAnimation.bottomToTop
        : animation;

    return showAnimatedGeneralDialog<T>(
      context,
      builder,
      config: config,
      animation: platformAnimation,
      constraints: constraints,
      useRootNavigator: useRootNavigator,
      useSafeArea: useSafeArea,
      barrierDismissible: barrierDismissible ?? !cupertinoStyle,
      barrierColor: barrierColor,
      barrierBlur: barrierBlur ?? (cupertinoStyle ? 12.0 : null),
      onDismissed: onDismissed,
    );
  }

  /// Shows a dialog with custom start and end positions.
  ///
  /// This method provides fine-grained control over where the dialog
  /// appears from and where it ends up. The positions are based on a 3x3 grid:
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
  ///
  /// ## Parameters
  ///
  /// - [startPosition]: Where the dialog starts (use [DialogPosition.offScreen]
  ///   for slide-in from outside the screen)
  /// - [endPosition]: Where the dialog ends (final resting position)
  /// - [transitionType]: The type of transition effect (default: slideFade)
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Slide from top-right corner to center
  /// SuperDialog.showPositionedDialog<void>(
  ///   context,
  ///   (context) => MyDialog(),
  ///   startPosition: DialogPosition.topEnd,
  ///   endPosition: DialogPosition.center,
  /// );
  ///
  /// // Slide from off-screen to bottom-center
  /// SuperDialog.showPositionedDialog<void>(
  ///   context,
  ///   (context) => BottomSheet(),
  ///   startPosition: DialogPosition.offScreen,
  ///   endPosition: DialogPosition.bottomCenter,
  /// );
  /// ```
  static Future<T?> showPositionedDialog<T extends Object?>(
    BuildContext context,
    WidgetBuilder builder, {
    required DialogPosition startPosition,
    required DialogPosition endPosition,
    PositionedTransitionType transitionType =
        PositionedTransitionType.slideFade,
    SuperDialogConfig? config,
    BoxConstraints? constraints,
    bool? useRootNavigator,
    bool useSafeArea = true,
    bool? barrierDismissible,
    Color? barrierColor,
    double? barrierBlur,
    VoidCallback? onDismissed,
  }) {
    final dialogTheme = SuperDialogThemeData.of(context);
    final bool resolvedUseRootNavigator = useRootNavigator ?? true;
    final BuildContext navigatorContext = _resolveNavigatorContext(
      context,
      resolvedUseRootNavigator,
    );
    final navigator = Navigator.of(
      navigatorContext,
      rootNavigator: resolvedUseRootNavigator,
    );
    final SuperDialogConfig effectiveConfig = config ?? dialogTheme.config;
    final double effectiveBarrierBlur = barrierBlur ?? dialogTheme.barrierBlur;
    final String barrierLabel = MaterialLocalizations.of(
      navigatorContext,
    ).modalBarrierDismissLabel;

    final transitionBuilder = PositionedDialogTransitionBuilder(
      startPosition: startPosition,
      endPosition: endPosition,
      transitionType: transitionType,
    );

    final route = _SuperDialogRoute<T>(
      pageBuilder: (context, animationController, secondaryAnimation) {
        return _buildDialogPage(
          context: context,
          builder: builder,
          constraints: constraints,
          useSafeArea: useSafeArea,
          barrierBlur: effectiveBarrierBlur,
        );
      },
      transitionBuilder:
          (context, animationController, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animationController,
              curve: effectiveConfig.openCurve,
              reverseCurve: effectiveConfig.closeCurve,
            );
            return transitionBuilder.build(
              context,
              curvedAnimation,
              secondaryAnimation,
              child,
            );
          },
      transitionDuration: effectiveConfig.openDuration,
      reverseTransitionDuration: effectiveConfig.closeDuration,
      barrierDismissible: barrierDismissible ?? true,
      barrierLabel: barrierLabel,
      barrierColor: barrierColor ?? dialogTheme.barrierColor,
      settings: const RouteSettings(name: 'super_dialog_positioned'),
    );

    final future = navigator.push<T>(route);
    if (onDismissed != null) {
      future.whenComplete(onDismissed);
    }
    return future;
  }
}

Widget _buildDialogPage({
  required BuildContext context,
  required WidgetBuilder builder,
  required BoxConstraints? constraints,
  required bool useSafeArea,
  required double barrierBlur,
}) {
  Widget dialog = builder(context);
  if (constraints != null) {
    dialog = ConstrainedBox(constraints: constraints, child: dialog);
  }
  if (useSafeArea) {
    dialog = SafeArea(child: dialog);
  }
  if (barrierBlur <= 0) {
    return dialog;
  }

  return Stack(
    fit: StackFit.expand,
    children: [
      Positioned.fill(
        child: IgnorePointer(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: barrierBlur, sigmaY: barrierBlur),
            child: const ColoredBox(color: Colors.transparent),
          ),
        ),
      ),
      dialog,
    ],
  );
}

class _SuperDialogRoute<T> extends RawDialogRoute<T> {
  _SuperDialogRoute({
    required super.pageBuilder,
    required super.barrierDismissible,
    required super.barrierColor,
    required super.barrierLabel,
    required super.transitionDuration,
    required this.reverseTransitionDuration,
    super.transitionBuilder,
    super.settings,
  });

  @override
  final Duration reverseTransitionDuration;
}

/// Resolves the appropriate navigator context based on settings.
BuildContext _resolveNavigatorContext(
  BuildContext context,
  bool useRootNavigator,
) {
  if (!useRootNavigator) {
    return context;
  }
  final rootContext = SuperDialog.rootKey?.currentContext;
  if (rootContext != null && rootContext.mounted) {
    return rootContext;
  }
  return context;
}
