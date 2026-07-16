import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

class BottomQuickAssignSheet extends StatelessWidget {
  const BottomQuickAssignSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: DemoFloatingSurface(
        maxWidth: 720,
        alignment: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outline,
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
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
                  child: const Icon(Icons.assignment_ind_outlined, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Assign Approval Task', style: theme.textTheme.titleLarge),
                      Text(
                        'PO-2026-00428 · Purchase order review',
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            const DemoPanel(
              child: Column(
                children: [
                  _AssigneeRow(initials: 'MO', name: 'Maya Ortiz', role: 'Operations Manager', selected: true),
                  DemoDivider(),
                  _AssigneeRow(initials: 'AK', name: 'Ahmed Khan', role: 'Procurement Lead'),
                  DemoDivider(),
                  _AssigneeRow(initials: 'SL', name: 'Sofia Lee', role: 'Finance Controller'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            DemoDialogActions(
              children: <Widget>[
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.send_rounded, size: 16),
                  label: const Text('Assign task'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AssigneeRow extends StatelessWidget {
  const _AssigneeRow({
    required this.initials,
    required this.name,
    required this.role,
    this.selected = false,
  });

  final String initials;
  final String name;
  final String role;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          DemoAvatar(initials: initials),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                Text(role, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          Radio<bool>(value: true, groupValue: selected, onChanged: (_) {}),
        ],
      ),
    );
  }
}
