import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

class QuickApprovalDialog extends StatelessWidget {
  const QuickApprovalDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDialogSurface(
      width: 540,
      title: 'Approve Expense Report',
      subtitle: 'EXP-2026-1842 · Submitted by Lina Chen',
      icon: Icons.verified_user_outlined,
      iconColor: AppColors.primary,
      content: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              DemoStatusChip(label: 'Manager review', color: AppColors.warning),
              DemoStatusChip(label: 'Policy compliant', color: AppColors.success),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          DemoPanel(
            child: Column(
              children: [
                DemoDataRow(label: 'Business purpose', value: 'Customer implementation workshop'),
                DemoDivider(),
                DemoDataRow(label: 'Expense period', value: '08–12 Jul 2026'),
                DemoDivider(),
                DemoDataRow(label: 'Cost center', value: 'CC-210 · Customer Success'),
                DemoDivider(),
                DemoDataRow(label: 'Total', value: r'$2,846.40', valueColor: AppColors.primary),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.lg),
          DemoNotice(
            message:
                'All receipts are attached. One hotel line is \$18 above policy but includes an approved exception note.',
            color: AppColors.warning,
            icon: Icons.receipt_long_outlined,
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Send back'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.check_rounded, size: 16),
          label: const Text('Approve'),
        ),
      ],
    );
  }
}
