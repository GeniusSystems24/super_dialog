import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

class TimeOffDetailsDialog extends StatelessWidget {
  const TimeOffDetailsDialog({
    super.key,
    this.alignment = Alignment.center,
    this.widthFactor,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
  });

  final AlignmentGeometry alignment;
  final double? widthFactor;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final content = Align(
      alignment: alignment,
      child: DemoFloatingSurface(
        maxWidth: 620,
        alignment: alignment,
        margin: margin,
        child: const _TimeOffContent(),
      ),
    );
    if (widthFactor == null) return content;
    return DemoAdaptivePanel(
      widthFactor: widthFactor!,
      alignment: alignment,
      maxWidth: 760,
      child: content,
    );
  }
}

class _TimeOffContent extends StatelessWidget {
  const _TimeOffContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 440;
            final identity = Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const DemoAvatar(
                  initials: 'LC',
                  color: AppColors.primary,
                  size: 42,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Annual Leave Request',
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        'Lina Chen · Customer Success · REQ-1842',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
            final controls = Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: <Widget>[
                const DemoStatusChip(
                  label: 'Pending',
                  color: AppColors.warning,
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  tooltip: 'Close',
                  icon: const Icon(Icons.close_rounded, size: 16),
                ),
              ],
            );
            if (compact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  identity,
                  const SizedBox(height: AppSpacing.sm),
                  controls,
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: identity),
                const SizedBox(width: AppSpacing.md),
                controls,
              ],
            );
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        const DemoResponsiveGrid(
          children: <Widget>[
            DemoMetric(
              label: 'Duration',
              value: '3 days',
              icon: Icons.date_range_outlined,
              color: AppColors.primary,
            ),
            DemoMetric(
              label: 'Remaining balance',
              value: '11.5 days',
              icon: Icons.beach_access_outlined,
              color: AppColors.success,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        const DemoPanel(
          child: Column(
            children: <Widget>[
              DemoDataRow(label: 'Dates', value: '22–24 Jul 2026'),
              DemoDivider(),
              DemoDataRow(label: 'Leave type', value: 'Annual leave'),
              DemoDivider(),
              DemoDataRow(label: 'Coverage owner', value: 'Noah Williams'),
              DemoDivider(),
              DemoDataRow(label: 'Submitted', value: '15 Jul 2026 · 14:22'),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const DemoNotice(
          message:
              'The employee confirmed customer coverage and no conflicting leave exists in the team calendar.',
          color: AppColors.primary,
          icon: Icons.comment_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        DemoDialogActions(
          children: <Widget>[
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Decline'),
            ),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              icon: const Icon(Icons.check_rounded, size: 16),
              label: const Text('Approve request'),
            ),
          ],
        ),
      ],
    );
  }
}
