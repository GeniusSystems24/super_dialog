import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

/// A dialog demonstrating positioned transitions from a corner to the center.
class PositionedCornerDialog extends StatelessWidget {
  const PositionedCornerDialog({super.key, required this.fromCorner});

  final String fromCorner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: DemoFloatingSurface(
        maxWidth: 440,
        alignment: Alignment.center,
        accentColor: AppColors.primary,
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
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadii.card),
                  ),
                  child: const Icon(Icons.open_in_full_rounded, size: 20, color: AppColors.primary),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Position Transition', style: theme.textTheme.titleLarge),
                      Text(
                        'From $fromCorner to center',
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
            const DemoPanel(
              child: Column(
                children: [
                  DemoDataRow(label: 'Start position', value: 'Off-screen corner'),
                  DemoDivider(),
                  DemoDataRow(label: 'End position', value: 'Viewport center'),
                  DemoDivider(),
                  DemoDataRow(label: 'Use case', value: 'Contextual ERP notification'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close preview'),
            ),
          ],
        ),
      ),
    );
  }
}
