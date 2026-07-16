import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

/// Compact ERP notification card used by positioned-transition examples.
class PositionedInfoCard extends StatelessWidget {
  const PositionedInfoCard({
    super.key,
    required this.position,
    this.accentColor,
  });

  final String position;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppColors.primary;
    final theme = Theme.of(context);
    return DemoFloatingSurface(
      maxWidth: 320,
      margin: const EdgeInsets.all(AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.lg),
      accentColor: color,
      fillViewport: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadii.control),
                ),
                child: Icon(Icons.notifications_none_rounded, size: 18, color: color),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text('Workflow notification', style: theme.textTheme.titleMedium),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.close_rounded, size: 16),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'This card is anchored at $position and uses a position-aware transition.',
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.md),
          DemoStatusChip(label: position, color: color, icon: Icons.place_outlined),
        ],
      ),
    );
  }
}
