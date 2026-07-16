import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

class TopAnnouncementBanner extends StatelessWidget {
  const TopAnnouncementBanner({super.key, required this.widthFactor});

  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DemoAdaptivePanel(
      widthFactor: widthFactor,
      maxWidth: 1100,
      alignment: Alignment.topCenter,
      child: DemoFloatingSurface(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(AppSpacing.lg),
        accentColor: AppColors.warning,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 620;
            final icon = Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadii.card),
              ),
              child: const Icon(
                Icons.campaign_outlined,
                color: AppColors.warning,
                size: 20,
              ),
            );
            final message = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Text(
                      'Period-close maintenance window',
                      style: theme.textTheme.titleMedium,
                    ),
                    const DemoStatusChip(
                      label: 'Action required',
                      color: AppColors.warning,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Routine financial postings will pause today from 20:00–21:30 UTC while Period 07 validation runs.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            );
            final actions = Wrap(
              alignment: compact ? WrapAlignment.start : WrapAlignment.end,
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('View schedule'),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      icon,
                      const SizedBox(width: AppSpacing.md),
                      Expanded(child: message),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  actions,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                icon,
                const SizedBox(width: AppSpacing.md),
                Expanded(child: message),
                const SizedBox(width: AppSpacing.md),
                actions,
              ],
            );
          },
        ),
      ),
    );
  }
}
