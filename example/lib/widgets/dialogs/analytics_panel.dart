import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

class AnalyticsPanel extends StatelessWidget {
  const AnalyticsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: DemoFloatingSurface(
        maxWidth: 520,
        alignment: AlignmentDirectional.centerEnd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadii.card),
                  ),
                  child: const Icon(Icons.insights_outlined, color: AppColors.success, size: 20),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Operations Snapshot', style: theme.textTheme.titleLarge),
                      Text(
                        'Today · all company codes',
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.close_rounded, size: 16),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            const DemoResponsiveGrid(
              children: <Widget>[
                DemoMetric(
                  label: 'Pending approvals',
                  value: '24',
                  icon: Icons.approval_outlined,
                  color: AppColors.warning,
                  caption: '6 overdue',
                ),
                DemoMetric(
                  label: 'Posted today',
                  value: '1,284',
                  icon: Icons.task_alt_rounded,
                  color: AppColors.success,
                  caption: '+8.4% vs average',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            const DemoPanel(
              child: Column(
                children: [
                  DemoDataRow(label: 'Blocked sales orders', value: '8', valueColor: AppColors.error),
                  DemoDivider(),
                  DemoDataRow(label: 'Inventory exceptions', value: '17', valueColor: AppColors.warning),
                  DemoDivider(),
                  DemoDataRow(label: 'Bank statements matched', value: '96.8%', valueColor: AppColors.success),
                  DemoDivider(),
                  DemoDataRow(label: 'Close tasks completed', value: '90%'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.dashboard_outlined, size: 16),
              label: const Text('Open operations dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
