import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

class StatusNotificationDialog extends StatelessWidget {
  const StatusNotificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDialogSurface(
      width: 430,
      title: 'Posting Completed',
      subtitle: 'Document FI-260716-00984',
      icon: Icons.check_circle_outline_rounded,
      iconColor: AppColors.success,
      content: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DemoNotice(
            message:
                'The document was posted successfully to company code 1000 and is available in the audit trail.',
            color: AppColors.success,
            icon: Icons.done_all_rounded,
          ),
          SizedBox(height: AppSpacing.lg),
          DemoPanel(
            child: Column(
              children: [
                DemoDataRow(label: 'Posting date', value: '16 Jul 2026'),
                DemoDivider(),
                DemoDataRow(label: 'Created by', value: 'ERP Administrator'),
                DemoDivider(),
                DemoDataRow(label: 'Reference', value: 'FI-260716-00984', monospace: true),
              ],
            ),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('View document'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Done'),
        ),
      ],
    );
  }
}
