import 'package:flutter/material.dart';

import 'app_theme.dart';

enum AppWindowClass { compact, medium, expanded }

abstract final class AppLayout {
  static const double compactBreakpoint = 600;
  static const double mediumBreakpoint = 1024;
  static const double wideBreakpoint = 1440;

  static AppWindowClass windowClassFor(double width) {
    if (width < compactBreakpoint) return AppWindowClass.compact;
    if (width < mediumBreakpoint) return AppWindowClass.medium;
    return AppWindowClass.expanded;
  }

  static AppWindowClass windowClassOf(BuildContext context) =>
      windowClassFor(MediaQuery.sizeOf(context).width);

  static bool isCompact(BuildContext context) =>
      windowClassOf(context) == AppWindowClass.compact;

  static EdgeInsets pagePaddingFor(double width) {
    return switch (windowClassFor(width)) {
      AppWindowClass.compact => const EdgeInsets.all(AppSpacing.md),
      AppWindowClass.medium => const EdgeInsets.all(AppSpacing.lg),
      AppWindowClass.expanded => const EdgeInsets.all(AppSpacing.xl),
    };
  }

  static EdgeInsets pagePadding(BuildContext context) =>
      pagePaddingFor(MediaQuery.sizeOf(context).width);

  static double maxContentWidthFor(double width) {
    if (width >= wideBreakpoint) return 1320;
    if (width >= mediumBreakpoint) return 1180;
    return width;
  }

  static int gridColumnsFor(
    double width, {
    double minTileWidth = 320,
    int maxColumns = 3,
  }) {
    final usable = width.clamp(minTileWidth, double.infinity);
    final columns = (usable / minTileWidth).floor();
    return columns.clamp(1, maxColumns).toInt();
  }

  static double dialogInsetFor(double width) {
    if (width < 420) return AppSpacing.sm;
    if (width < compactBreakpoint) return AppSpacing.md;
    return AppSpacing.xl;
  }

  static double dialogPaddingFor(double width) {
    if (width < 420) return AppSpacing.md;
    if (width < compactBreakpoint) return AppSpacing.lg;
    return AppSpacing.xl;
  }
}

class ResponsiveContent extends StatelessWidget {
  const ResponsiveContent({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
    this.alignment = AlignmentDirectional.topCenter,
  });

  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final resolvedPadding =
            padding ?? AppLayout.pagePaddingFor(constraints.maxWidth);
        final resolvedMaxWidth =
            maxWidth ?? AppLayout.maxContentWidthFor(constraints.maxWidth);
        return Align(
          alignment: alignment,
          child: Padding(
            padding: resolvedPadding,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: resolvedMaxWidth),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
