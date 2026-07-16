import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

class GuardedExitDialog extends StatelessWidget {
  const GuardedExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDialogSurface(
      width: 500,
      title: 'Unsaved Changes',
      subtitle: 'Purchase requisition PR-DRAFT-1048',
      icon: Icons.edit_note_rounded,
      iconColor: AppColors.warning,
      content: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DemoNotice(
            message:
                'Three edited line items and one approval note have not been saved. Closing this workflow discards those changes.',
            color: AppColors.warning,
            icon: Icons.warning_amber_rounded,
          ),
          SizedBox(height: AppSpacing.lg),
          DemoPanel(
            child: Column(
              children: [
                DemoLineItem(
                  title: 'Line 10 · Hydraulic seal kit',
                  subtitle: 'Quantity changed from 8 to 12',
                  amount: 'Modified',
                ),
                DemoDivider(),
                DemoLineItem(
                  title: 'Approval note',
                  subtitle: 'New justification added',
                  amount: 'Unsaved',
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Continue editing'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: AppColors.error),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Discard changes'),
        ),
      ],
    );
  }
}
