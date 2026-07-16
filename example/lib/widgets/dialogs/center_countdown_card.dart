import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

class CenterCountdownCard extends StatelessWidget {
  const CenterCountdownCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SuperDialogSurface(
      width: 520,
      title: 'Payment Batch Window',
      subtitle: 'Bank transmission cutoff · 16 Jul 2026',
      icon: Icons.timer_outlined,
      iconColor: AppColors.warning,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DemoNotice(
            message:
                'Approve before the cutoff to include 86 supplier payments in today’s bank file.',
            color: AppColors.warning,
            icon: Icons.schedule_rounded,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: const [
              Expanded(child: _TimeUnit(value: '01', label: 'HOURS')),
              SizedBox(width: AppSpacing.sm),
              Expanded(child: _TimeUnit(value: '24', label: 'MINUTES')),
              SizedBox(width: AppSpacing.sm),
              Expanded(child: _TimeUnit(value: '38', label: 'SECONDS')),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            r'Batch value: $684,220.18 · 86 payments · 4 currencies',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Review batch'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Approve now'),
        ),
      ],
    );
  }
}

class _TimeUnit extends StatelessWidget {
  const _TimeUnit({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
              fontFamily: 'JetBrainsMono',
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(label, style: theme.textTheme.labelSmall),
        ],
      ),
    );
  }
}
