import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/app_layout.dart';
import '../../theme/app_theme.dart';

class DemoStatusChip extends StatelessWidget {
  const DemoStatusChip({
    super.key,
    required this.label,
    required this.color,
    this.icon,
  });

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: color.withValues(alpha: 0.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: AppSpacing.xs),
          ],
          Flexible(
            child: Text(
              label.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.55,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class DemoSection extends StatelessWidget {
  const DemoSection({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.trailing,
    this.icon,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 420;
        final heading = Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (icon != null) ...<Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(icon, size: 16, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (subtitle != null) ...<Widget>[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (trailing == null)
              heading
            else if (compact)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  heading,
                  const SizedBox(height: AppSpacing.sm),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: trailing!,
                  ),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: heading),
                  const SizedBox(width: AppSpacing.md),
                  trailing!,
                ],
              ),
            const SizedBox(height: AppSpacing.md),
            child,
          ],
        );
      },
    );
  }
}

class DemoPanel extends StatelessWidget {
  const DemoPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.tint,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: tint ?? theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: child,
    );
  }
}

class DemoDataRow extends StatelessWidget {
  const DemoDataRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.monospace = false,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool monospace;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelWidget = Text(
      label,
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
    final valueWidget = Text(
      value,
      textAlign: TextAlign.end,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: valueColor ?? theme.colorScheme.onSurface,
        fontWeight: FontWeight.w600,
        fontFamily: monospace ? 'JetBrainsMono' : null,
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked = constraints.maxWidth < 330;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: stacked
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    labelWidget,
                    const SizedBox(height: AppSpacing.xs),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: valueWidget,
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 4, child: labelWidget),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(flex: 6, child: valueWidget),
                  ],
                ),
        );
      },
    );
  }
}

class DemoMetric extends StatelessWidget {
  const DemoMetric({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.caption,
  });

  final String label;
  final String value;
  final String? caption;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked = constraints.maxWidth < 180;
        final iconWidget = Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(AppRadii.control),
          ),
          child: Icon(icon, size: 18, color: color),
        );
        final content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (caption != null) ...<Widget>[
              const SizedBox(height: 2),
              Text(
                caption!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(color: color),
              ),
            ],
          ],
        );

        return Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(color: color.withValues(alpha: 0.18)),
          ),
          child: stacked
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    iconWidget,
                    const SizedBox(height: AppSpacing.sm),
                    content,
                  ],
                )
              : Row(
                  children: <Widget>[
                    iconWidget,
                    const SizedBox(width: AppSpacing.md),
                    Expanded(child: content),
                  ],
                ),
        );
      },
    );
  }
}

class DemoLineItem extends StatelessWidget {
  const DemoLineItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.leading,
    this.status,
  });

  final String title;
  final String subtitle;
  final String amount;
  final Widget? leading;
  final Widget? status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedLeading = leading ??
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(AppRadii.control),
          ),
          child: Icon(
            Icons.inventory_2_outlined,
            size: 16,
            color: theme.colorScheme.primary,
          ),
        );
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
    final amountWidget = Text(
      amount,
      style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w700,
        fontFamily: 'JetBrainsMono',
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 420;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: compact
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        resolvedLeading,
                        const SizedBox(width: AppSpacing.md),
                        Expanded(child: text),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: AppSpacing.md,
                      runSpacing: AppSpacing.sm,
                      children: <Widget>[
                        if (status != null) status!,
                        amountWidget,
                      ],
                    ),
                  ],
                )
              : Row(
                  children: <Widget>[
                    resolvedLeading,
                    const SizedBox(width: AppSpacing.md),
                    Expanded(child: text),
                    if (status != null) ...<Widget>[
                      status!,
                      const SizedBox(width: AppSpacing.md),
                    ],
                    amountWidget,
                  ],
                ),
        );
      },
    );
  }
}

class DemoNotice extends StatelessWidget {
  const DemoNotice({
    super.key,
    required this.message,
    required this.color,
    required this.icon,
  });

  final String message;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: color.withValues(alpha: 0.20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 18, color: color),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DemoResponsiveGrid extends StatelessWidget {
  const DemoResponsiveGrid({
    super.key,
    required this.children,
    this.minItemWidth = 220,
    this.maxColumns = 2,
    this.spacing = AppSpacing.md,
  });

  final List<Widget> children;
  final double minItemWidth;
  final int maxColumns;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = AppLayout.gridColumnsFor(
          constraints.maxWidth,
          minTileWidth: minItemWidth,
          maxColumns: math.min(maxColumns, children.length).toInt(),
        );
        final itemWidth = columns == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: <Widget>[
            for (final child in children)
              SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}

class DemoDialogActions extends StatelessWidget {
  const DemoDialogActions({
    super.key,
    required this.children,
    this.primaryLast = true,
  });

  final List<Widget> children;
  final bool primaryLast;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked = constraints.maxWidth < 420;
        if (!stacked) {
          return Wrap(
            alignment: WrapAlignment.end,
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.sm,
            children: children,
          );
        }
        final ordered = primaryLast ? children.reversed.toList() : children;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (var index = 0; index < ordered.length; index++) ...<Widget>[
              SizedBox(width: double.infinity, child: ordered[index]),
              if (index != ordered.length - 1)
                const SizedBox(height: AppSpacing.sm),
            ],
          ],
        );
      },
    );
  }
}

class DemoAdaptivePanel extends StatelessWidget {
  const DemoAdaptivePanel({
    super.key,
    required this.child,
    required this.widthFactor,
    this.alignment = Alignment.center,
    this.maxWidth,
  });

  final Widget child;
  final double widthFactor;
  final AlignmentGeometry alignment;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!constraints.hasBoundedWidth) {
          return Align(
            alignment: alignment,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth ?? 760),
              child: child,
            ),
          );
        }
        final compact = constraints.maxWidth < AppLayout.compactBreakpoint;
        final requestedWidth = compact
            ? constraints.maxWidth
            : constraints.maxWidth * widthFactor;
        final resolvedWidth = math
            .min(requestedWidth, maxWidth ?? requestedWidth)
            .toDouble();
        return Align(
          alignment: alignment,
          child: SizedBox(width: resolvedWidth, child: child),
        );
      },
    );
  }
}

class DemoFloatingSurface extends StatelessWidget {
  const DemoFloatingSurface({
    super.key,
    required this.child,
    this.maxWidth,
    this.margin,
    this.padding,
    this.accentColor,
    this.alignment = Alignment.center,
    this.scrollable = true,
    this.fillViewport = true,
  });

  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? accentColor;
  final AlignmentGeometry alignment;
  final bool scrollable;

  /// When true, the surface owns the viewport alignment and safe-area insets.
  /// Positioned-dialog routes should set this to false so the route transition
  /// can place the shrink-wrapped surface itself.
  final bool fillViewport;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final direction = Directionality.of(context);
    final horizontalInset = AppLayout.dialogInsetFor(media.size.width);
    final defaultMargin = EdgeInsets.all(horizontalInset);
    final resolvedMargin = (margin ?? defaultMargin).resolve(direction);
    final resolvedPadding = (padding ??
            EdgeInsets.all(AppLayout.dialogPaddingFor(media.size.width)))
        .resolve(direction);
    final availableWidth = math.max(
      0.0,
      media.size.width - resolvedMargin.horizontal,
    ).toDouble();
    final availableHeight = math.max(
      220.0,
      media.size.height -
          resolvedMargin.vertical -
          media.viewInsets.vertical -
          media.padding.vertical,
    ).toDouble();
    final resolvedMaxWidth =
        math.min(maxWidth ?? 720, availableWidth).toDouble();

    Widget content = Padding(padding: resolvedPadding, child: child);
    if (scrollable) {
      content = SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.zero,
        child: content,
      );
    }

    final radius = BorderRadius.circular(AppRadii.card);
    final surface = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: resolvedMaxWidth,
        maxHeight: availableHeight,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(
                alpha: theme.brightness == Brightness.dark ? 0.34 : 0.12,
              ),
              blurRadius: 28,
              spreadRadius: -10,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Material(
          color: theme.colorScheme.surface,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: BorderSide(
              color: accentColor?.withValues(alpha: 0.30) ??
                  theme.colorScheme.outline,
            ),
          ),
          elevation: 0,
          child: content,
        ),
      ),
    );

    if (!fillViewport) {
      return Padding(padding: resolvedMargin, child: surface);
    }

    return SafeArea(
      minimum: resolvedMargin,
      child: Align(alignment: alignment, child: surface),
    );
  }
}

class DemoDivider extends StatelessWidget {
  const DemoDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, color: Theme.of(context).colorScheme.outline);
  }
}

class DemoAvatar extends StatelessWidget {
  const DemoAvatar({
    super.key,
    required this.initials,
    this.color = AppColors.primary,
    this.size = 36,
  });

  final String initials;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadii.control),
      ),
      child: Text(
        initials,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
