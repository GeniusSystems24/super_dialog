import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

class AddTimeOffDialog extends StatelessWidget {
  const AddTimeOffDialog({super.key, required this.alignment});

  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: alignment,
      child: DemoFloatingSurface(
        maxWidth: 680,
        alignment: alignment,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadii.card),
                  ),
                  child: const Icon(Icons.event_available_outlined, color: AppColors.primary, size: 21),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Create Time-off Request', style: theme.textTheme.titleLarge),
                      const SizedBox(height: 2),
                      Text(
                        'Employee self-service · Annual leave',
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
                  label: 'Available balance',
                  value: '14.5 days',
                  icon: Icons.beach_access_outlined,
                  color: AppColors.success,
                  caption: 'After request: 11.5 days',
                ),
                DemoMetric(
                  label: 'Requested duration',
                  value: '3 days',
                  icon: Icons.date_range_outlined,
                  color: AppColors.primary,
                  caption: '22–24 Jul 2026',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            DemoSection(
              title: 'Request details',
              child: DemoPanel(
                child: Column(
                  children: [
                    const DemoDataRow(label: 'Leave type', value: 'Annual leave'),
                    const DemoDivider(),
                    const DemoDataRow(label: 'Start date', value: '22 Jul 2026'),
                    const DemoDivider(),
                    const DemoDataRow(label: 'End date', value: '24 Jul 2026'),
                    const DemoDivider(),
                    DemoDataRow(
                      label: 'Approver',
                      value: 'Maya Ortiz · Operations Manager',
                      valueColor: theme.colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const DemoNotice(
              message:
                  'No team coverage conflict was detected. The request follows the standard manager approval workflow.',
              color: AppColors.success,
              icon: Icons.verified_outlined,
            ),
            const SizedBox(height: AppSpacing.lg),
            DemoDialogActions(
              children: <Widget>[
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Save draft'),
                ),
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.send_rounded, size: 16),
                  label: const Text('Submit request'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
