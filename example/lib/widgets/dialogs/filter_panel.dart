import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

class FilterPanel extends StatelessWidget {
  const FilterPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DemoFloatingSurface(
      maxWidth: 430,
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
                child: const Icon(Icons.filter_alt_outlined, size: 20, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Document Filters', style: theme.textTheme.titleLarge),
                    Text(
                      'Narrow the operational worklist',
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
          const DemoSection(
            title: 'Document status',
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _FilterPill(label: 'Pending', selected: true),
                _FilterPill(label: 'Blocked'),
                _FilterPill(label: 'Approved'),
                _FilterPill(label: 'Posted'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoSection(
            title: 'Company and period',
            child: DemoPanel(
              child: Column(
                children: [
                  DemoDataRow(label: 'Company code', value: '1000 · GeniusLink Demo'),
                  DemoDivider(),
                  DemoDataRow(label: 'Fiscal period', value: 'FY26 · Period 07'),
                  DemoDivider(),
                  DemoDataRow(label: 'Owner', value: 'My work queue'),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          DemoDialogActions(
            children: <Widget>[
              OutlinedButton(
                onPressed: () {},
                child: const Text('Reset'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Apply filters'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({required this.label, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FilterChip(
      selected: selected,
      label: Text(label),
      onSelected: (_) {},
      selectedColor: theme.colorScheme.primary.withValues(alpha: 0.12),
    );
  }
}
