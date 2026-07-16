import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

class CenterReminderCard extends StatelessWidget {
  const CenterReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDialogSurface(
      width: 470,
      title: 'Approval Reminder',
      subtitle: 'Quarterly access certification',
      icon: Icons.notifications_active_outlined,
      iconColor: AppColors.warning,
      content: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DemoMetric(
            label: 'Reviews remaining',
            value: '14 users',
            icon: Icons.manage_accounts_outlined,
            color: AppColors.warning,
            caption: 'Due tomorrow at 17:00',
          ),
          SizedBox(height: AppSpacing.lg),
          DemoNotice(
            message:
                'Complete the review to maintain segregation-of-duties compliance for the Finance role group.',
            color: AppColors.primary,
            icon: Icons.policy_outlined,
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Remind me later'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Open review'),
        ),
      ],
    );
  }
}
