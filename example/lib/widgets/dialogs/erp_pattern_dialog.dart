import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

enum ErpDialogPattern {
  approvalSummary('Approval summary'),
  exceptionReview('Exception review'),
  guidedForm('Guided form'),
  splitComparison('Split comparison'),
  lineItemReview('Line-item review'),
  postingConfirmation('Posting confirmation'),
  activityTimeline('Activity timeline'),
  controlMatrix('Control matrix'),
  allocationWorkbench('Allocation workbench'),
  closeChecklist('Close checklist'),
  riskDecision('Risk decision'),
  bulkAction('Bulk action'),
  documentPreview('Document preview'),
  varianceAnalysis('Variance analysis'),
  statusOverview('Status overview'),
  masterDataReview('Master-data review');

  const ErpDialogPattern(this.label);
  final String label;
}

class ErpDialogSpec {
  const ErpDialogSpec({
    required this.title,
    required this.subtitle,
    required this.module,
    required this.reference,
    required this.status,
    required this.statusColor,
    required this.icon,
    required this.accentColor,
    required this.pattern,
    required this.primaryAction,
    required this.notice,
    required this.tags,
    required this.seed,
  });

  final String title;
  final String subtitle;
  final String module;
  final String reference;
  final String status;
  final Color statusColor;
  final IconData icon;
  final Color accentColor;
  final ErpDialogPattern pattern;
  final String primaryAction;
  final String notice;
  final List<String> tags;
  final int seed;
}

class ErpPatternDialog extends StatelessWidget {
  const ErpPatternDialog({super.key, required this.spec});

  final ErpDialogSpec spec;

  @override
  Widget build(BuildContext context) {
    final destructive = spec.statusColor == AppColors.error &&
        (spec.pattern == ErpDialogPattern.riskDecision ||
            spec.pattern == ErpDialogPattern.postingConfirmation);

    return SuperDialogSurface(
      width: _dialogWidth(spec.pattern),
      title: spec.title,
      subtitle: '${spec.reference} · ${spec.module}',
      icon: spec.icon,
      iconColor: spec.accentColor,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _PatternIdentity(spec: spec),
          const SizedBox(height: AppSpacing.lg),
          _PatternBody(spec: spec),
          const SizedBox(height: AppSpacing.lg),
          DemoNotice(
            message: spec.notice,
            color: spec.statusColor,
            icon: _noticeIcon(spec.pattern),
          ),
        ],
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          style: destructive
              ? FilledButton.styleFrom(backgroundColor: AppColors.error)
              : null,
          onPressed: () => Navigator.of(context).pop(true),
          icon: Icon(_primaryIcon(spec.pattern), size: 16),
          label: Text(spec.primaryAction),
        ),
      ],
    );
  }

  static double _dialogWidth(ErpDialogPattern pattern) => switch (pattern) {
        ErpDialogPattern.splitComparison ||
        ErpDialogPattern.controlMatrix ||
        ErpDialogPattern.allocationWorkbench ||
        ErpDialogPattern.documentPreview => 760,
        ErpDialogPattern.lineItemReview ||
        ErpDialogPattern.bulkAction ||
        ErpDialogPattern.varianceAnalysis => 700,
        ErpDialogPattern.guidedForm ||
        ErpDialogPattern.masterDataReview => 680,
        _ => 620,
      };

  static IconData _noticeIcon(ErpDialogPattern pattern) => switch (pattern) {
        ErpDialogPattern.exceptionReview ||
        ErpDialogPattern.riskDecision ||
        ErpDialogPattern.varianceAnalysis => Icons.warning_amber_rounded,
        ErpDialogPattern.postingConfirmation => Icons.gavel_rounded,
        ErpDialogPattern.closeChecklist => Icons.fact_check_outlined,
        ErpDialogPattern.activityTimeline => Icons.history_rounded,
        _ => Icons.info_outline_rounded,
      };

  static IconData _primaryIcon(ErpDialogPattern pattern) => switch (pattern) {
        ErpDialogPattern.postingConfirmation => Icons.publish_rounded,
        ErpDialogPattern.approvalSummary ||
        ErpDialogPattern.riskDecision => Icons.verified_rounded,
        ErpDialogPattern.guidedForm ||
        ErpDialogPattern.masterDataReview => Icons.save_rounded,
        ErpDialogPattern.bulkAction => Icons.done_all_rounded,
        ErpDialogPattern.documentPreview => Icons.description_outlined,
        _ => Icons.arrow_forward_rounded,
      };
}

class _PatternIdentity extends StatelessWidget {
  const _PatternIdentity({required this.spec});

  final ErpDialogSpec spec;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 440;
        final identity = <Widget>[
          DemoStatusChip(
            label: spec.pattern.label,
            color: spec.accentColor,
            icon: Icons.dashboard_customize_outlined,
          ),
          DemoStatusChip(
            label: spec.status,
            color: spec.statusColor,
            icon: Icons.circle,
          ),
        ];
        return compact
            ? Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: identity,
              )
            : Row(
                children: <Widget>[
                  ...identity.expand(
                    (widget) => <Widget>[
                      widget,
                      const SizedBox(width: AppSpacing.sm),
                    ],
                  ),
                  const Spacer(),
                  Flexible(
                    child: Text(
                      spec.subtitle,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}

class _PatternBody extends StatelessWidget {
  const _PatternBody({required this.spec});

  final ErpDialogSpec spec;

  @override
  Widget build(BuildContext context) {
    return switch (spec.pattern) {
      ErpDialogPattern.approvalSummary => _approvalSummary(),
      ErpDialogPattern.exceptionReview => _exceptionReview(),
      ErpDialogPattern.guidedForm => _guidedForm(),
      ErpDialogPattern.splitComparison => _splitComparison(),
      ErpDialogPattern.lineItemReview => _lineItemReview(),
      ErpDialogPattern.postingConfirmation => _postingConfirmation(),
      ErpDialogPattern.activityTimeline => _activityTimeline(),
      ErpDialogPattern.controlMatrix => _controlMatrix(),
      ErpDialogPattern.allocationWorkbench => _allocationWorkbench(),
      ErpDialogPattern.closeChecklist => _closeChecklist(),
      ErpDialogPattern.riskDecision => _riskDecision(),
      ErpDialogPattern.bulkAction => _bulkAction(),
      ErpDialogPattern.documentPreview => _documentPreview(),
      ErpDialogPattern.varianceAnalysis => _varianceAnalysis(),
      ErpDialogPattern.statusOverview => _statusOverview(),
      ErpDialogPattern.masterDataReview => _masterDataReview(),
    };
  }

  String get _amount => '\$${(spec.seed * 1375 + 18400).toStringAsFixed(2)}';
  String get _count => '${spec.seed % 9 + 3}';
  String get _percent => '${spec.seed % 18 + 4}.${spec.seed % 9}%';

  Widget _approvalSummary() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DemoResponsiveGrid(
            children: <Widget>[
              DemoMetric(
                label: 'Document value',
                value: _amount,
                icon: Icons.payments_outlined,
                color: spec.accentColor,
                caption: 'Within delegated authority',
              ),
              DemoMetric(
                label: 'Control checks',
                value: '$_count / $_count',
                icon: Icons.verified_user_outlined,
                color: AppColors.success,
                caption: 'All validations passed',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          DemoPanel(
            child: Column(
              children: <Widget>[
                DemoDataRow(label: 'Owner', value: 'Operations Controller'),
                const DemoDivider(),
                DemoDataRow(label: 'Business unit', value: spec.module),
                const DemoDivider(),
                DemoDataRow(label: 'Requested date', value: '16 Jul 2026'),
                const DemoDivider(),
                DemoDataRow(label: 'Workflow status', value: spec.status),
              ],
            ),
          ),
        ],
      );

  Widget _exceptionReview() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DemoMetric(
            label: 'Exceptions detected',
            value: _count,
            icon: Icons.rule_folder_outlined,
            color: spec.statusColor,
            caption: 'Manual review is required',
          ),
          const SizedBox(height: AppSpacing.lg),
          DemoPanel(
            child: Column(
              children: <Widget>[
                _issue('Tolerance exceeded', 'Value differs by $_percent'),
                const DemoDivider(),
                _issue('Reference missing', 'Supporting document not attached'),
                const DemoDivider(),
                _issue('Policy warning', 'Approval level must be confirmed'),
              ],
            ),
          ),
        ],
      );

  Widget _guidedForm() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const DemoResponsiveGrid(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Effective date',
                  prefixIcon: Icon(Icons.event_outlined),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Reason code',
                  prefixIcon: Icon(Icons.sell_outlined),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const TextField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Business justification',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          DemoPanel(
            child: Column(
              children: <Widget>[
                DemoDataRow(label: 'Reference', value: spec.reference),
                const DemoDivider(),
                DemoDataRow(label: 'Module', value: spec.module),
                const DemoDivider(),
                const DemoDataRow(label: 'Required fields', value: '4 of 4'),
              ],
            ),
          ),
        ],
      );

  Widget _splitComparison() => DemoResponsiveGrid(
        minItemWidth: 280,
        children: <Widget>[
          DemoSection(
            title: 'Current values',
            subtitle: 'Before the proposed change',
            child: DemoPanel(
              child: Column(
                children: <Widget>[
                  DemoDataRow(label: 'Amount', value: _amount),
                  const DemoDivider(),
                  const DemoDataRow(label: 'Payment terms', value: 'Net 30'),
                  const DemoDivider(),
                  const DemoDataRow(label: 'Approval level', value: 'Manager'),
                ],
              ),
            ),
          ),
          DemoSection(
            title: 'Proposed values',
            subtitle: 'Values that will become active',
            child: DemoPanel(
              tint: spec.accentColor.withValues(alpha: 0.06),
              child: Column(
                children: <Widget>[
                  DemoDataRow(
                    label: 'Amount',
                    value: '\$${(spec.seed * 1490 + 22100).toStringAsFixed(2)}',
                    valueColor: spec.accentColor,
                  ),
                  const DemoDivider(),
                  const DemoDataRow(label: 'Payment terms', value: 'Net 45'),
                  const DemoDivider(),
                  const DemoDataRow(label: 'Approval level', value: 'Director'),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _lineItemReview() => DemoSection(
        title: 'Document lines',
        subtitle: 'Review quantities, values, and line controls',
        trailing: DemoStatusChip(
          label: '$_count lines',
          color: spec.accentColor,
        ),
        child: DemoPanel(
          child: Column(
            children: <Widget>[
              _line('Primary item', 'Plant 01 · Cost center 410', '3 EA'),
              const DemoDivider(),
              _line('Freight and handling', 'Logistics · Standard service', _amount),
              const DemoDivider(),
              _line('Tax and adjustments', 'Automatically calculated', _percent),
            ],
          ),
        ),
      );

  Widget _postingConfirmation() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DemoResponsiveGrid(
            children: <Widget>[
              DemoMetric(
                label: 'Debit total',
                value: _amount,
                icon: Icons.south_west_rounded,
                color: spec.accentColor,
              ),
              DemoMetric(
                label: 'Credit total',
                value: _amount,
                icon: Icons.north_east_rounded,
                color: AppColors.success,
                caption: 'Balanced',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          DemoPanel(
            child: Column(
              children: <Widget>[
                _line('6105 · Operating expense', 'Business unit · ${spec.module}', 'DR $_amount'),
                const DemoDivider(),
                _line('2210 · Accrued liabilities', 'Corporate · Shared services', 'CR $_amount'),
              ],
            ),
          ),
        ],
      );

  Widget _activityTimeline() => DemoPanel(
        child: Column(
          children: <Widget>[
            _timeline('Request created', '08:42', AppColors.primary),
            const DemoDivider(),
            _timeline('Automated controls completed', '08:43', AppColors.success),
            const DemoDivider(),
            _timeline('Assigned to approver', '09:05', AppColors.warning),
            const DemoDivider(),
            _timeline('Current decision', 'Now', spec.statusColor),
          ],
        ),
      );

  Widget _controlMatrix() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DemoResponsiveGrid(
            minItemWidth: 210,
            maxColumns: 3,
            children: <Widget>[
              _control('Policy', 'Passed', AppColors.success),
              _control('Budget', spec.seed.isEven ? 'Passed' : 'Warning', spec.seed.isEven ? AppColors.success : AppColors.warning),
              _control('Compliance', 'Passed', AppColors.success),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          DemoPanel(
            child: Column(
              children: <Widget>[
                const DemoDataRow(label: 'Control owner', value: 'Internal Controls'),
                const DemoDivider(),
                DemoDataRow(label: 'Rules evaluated', value: '${spec.seed % 20 + 18}'),
                const DemoDivider(),
                const DemoDataRow(label: 'Evidence retained', value: 'Yes · 7 years'),
              ],
            ),
          ),
        ],
      );

  Widget _allocationWorkbench() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DemoMetric(
            label: 'Amount to allocate',
            value: _amount,
            icon: Icons.account_tree_outlined,
            color: spec.accentColor,
            caption: '100% must be distributed',
          ),
          const SizedBox(height: AppSpacing.lg),
          DemoPanel(
            child: Column(
              children: <Widget>[
                _allocation('Cost center 410', '45%', spec.accentColor),
                const DemoDivider(),
                _allocation('Cost center 620', '35%', AppColors.success),
                const DemoDivider(),
                _allocation('Project ERP-26', '20%', AppColors.purple),
              ],
            ),
          ),
        ],
      );

  Widget _closeChecklist() => DemoPanel(
        child: Column(
          children: <Widget>[
            _check('Source transactions posted', true),
            const DemoDivider(),
            _check('Subledger reconciliation', true),
            const DemoDivider(),
            _check('Management adjustments', spec.seed.isEven),
            const DemoDivider(),
            _check('Controller sign-off', false),
          ],
        ),
      );

  Widget _riskDecision() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DemoResponsiveGrid(
            children: <Widget>[
              DemoMetric(
                label: 'Exposure',
                value: _amount,
                icon: Icons.trending_up_rounded,
                color: AppColors.error,
                caption: 'Above configured threshold',
              ),
              DemoMetric(
                label: 'Risk score',
                value: '${spec.seed % 40 + 55}/100',
                icon: Icons.shield_outlined,
                color: spec.statusColor,
                caption: spec.status,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          DemoPanel(
            child: Column(
              children: <Widget>[
                const DemoDataRow(label: 'Policy result', value: 'Escalation required'),
                const DemoDivider(),
                DemoDataRow(label: 'Open exceptions', value: _count),
                const DemoDivider(),
                const DemoDataRow(label: 'Override duration', value: 'One transaction'),
              ],
            ),
          ),
        ],
      );

  Widget _bulkAction() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DemoMetric(
            label: 'Selected records',
            value: '${spec.seed % 50 + 24}',
            icon: Icons.library_add_check_outlined,
            color: spec.accentColor,
            caption: 'Across ${spec.seed % 5 + 2} business units',
          ),
          const SizedBox(height: AppSpacing.lg),
          DemoPanel(
            child: Column(
              children: <Widget>[
                _check('Validate every record before processing', true),
                const DemoDivider(),
                _check('Create one audit batch', true),
                const DemoDivider(),
                _check('Notify record owners', spec.seed.isOdd),
              ],
            ),
          ),
        ],
      );

  Widget _documentPreview() => DemoResponsiveGrid(
        minItemWidth: 280,
        children: <Widget>[
          DemoPanel(
            tint: spec.accentColor.withValues(alpha: 0.05),
            child: AspectRatio(
              aspectRatio: 0.82,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.description_outlined, size: 52, color: spec.accentColor),
                  const SizedBox(height: AppSpacing.md),
                  Text(spec.reference, style: const TextStyle(fontFamily: 'JetBrainsMono')),
                  const SizedBox(height: AppSpacing.xs),
                  Text('Document preview', style: TextStyle(color: spec.accentColor)),
                ],
              ),
            ),
          ),
          DemoPanel(
            child: Column(
              children: <Widget>[
                DemoDataRow(label: 'Document type', value: spec.module),
                const DemoDivider(),
                const DemoDataRow(label: 'Pages', value: '3'),
                const DemoDivider(),
                const DemoDataRow(label: 'Attachments', value: '2'),
                const DemoDivider(),
                DemoDataRow(label: 'Document value', value: _amount),
              ],
            ),
          ),
        ],
      );

  Widget _varianceAnalysis() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DemoResponsiveGrid(
            maxColumns: 3,
            minItemWidth: 180,
            children: <Widget>[
              DemoMetric(label: 'Plan', value: _amount, icon: Icons.flag_outlined, color: AppColors.primary),
              DemoMetric(label: 'Actual', value: '\$${(spec.seed * 1540 + 23500).toStringAsFixed(2)}', icon: Icons.show_chart_rounded, color: spec.statusColor),
              DemoMetric(label: 'Variance', value: _percent, icon: Icons.compare_arrows_rounded, color: spec.statusColor),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          DemoPanel(
            child: Column(
              children: <Widget>[
                _allocation('Volume impact', '48%', AppColors.primary),
                const DemoDivider(),
                _allocation('Rate impact', '32%', AppColors.warning),
                const DemoDivider(),
                _allocation('Mix impact', '20%', AppColors.purple),
              ],
            ),
          ),
        ],
      );

  Widget _statusOverview() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DemoResponsiveGrid(
            maxColumns: 3,
            minItemWidth: 180,
            children: <Widget>[
              DemoMetric(label: 'Completed', value: '${spec.seed % 12 + 8}', icon: Icons.check_circle_outline, color: AppColors.success),
              DemoMetric(label: 'Pending', value: _count, icon: Icons.pending_actions_outlined, color: AppColors.warning),
              DemoMetric(label: 'Blocked', value: '${spec.seed % 3}', icon: Icons.block_outlined, color: AppColors.error),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          DemoPanel(
            child: Column(
              children: <Widget>[
                DemoDataRow(label: 'Process owner', value: spec.module),
                const DemoDivider(),
                const DemoDataRow(label: 'Last refresh', value: 'A few seconds ago'),
                const DemoDivider(),
                DemoDataRow(label: 'Current stage', value: spec.status),
              ],
            ),
          ),
        ],
      );

  Widget _masterDataReview() => DemoResponsiveGrid(
        minItemWidth: 280,
        children: <Widget>[
          DemoSection(
            title: 'Identity',
            child: DemoPanel(
              child: Column(
                children: <Widget>[
                  DemoDataRow(label: 'Record ID', value: spec.reference, monospace: true),
                  const DemoDivider(),
                  DemoDataRow(label: 'Record type', value: spec.module),
                  const DemoDivider(),
                  const DemoDataRow(label: 'Lifecycle', value: 'Active'),
                ],
              ),
            ),
          ),
          DemoSection(
            title: 'Governance',
            child: DemoPanel(
              child: Column(
                children: <Widget>[
                  const DemoDataRow(label: 'Requested by', value: 'Master Data Team'),
                  const DemoDivider(),
                  const DemoDataRow(label: 'Effective date', value: '18 Jul 2026'),
                  const DemoDivider(),
                  DemoDataRow(label: 'Approval status', value: spec.status),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _issue(String title, String subtitle) => DemoLineItem(
        title: title,
        subtitle: subtitle,
        amount: 'Review',
        leading: DemoAvatar(initials: '!', color: spec.statusColor),
        status: DemoStatusChip(label: 'Exception', color: spec.statusColor),
      );

  Widget _line(String title, String subtitle, String amount) => DemoLineItem(
        title: title,
        subtitle: subtitle,
        amount: amount,
        leading: DemoAvatar(initials: '${spec.seed % 9 + 1}', color: spec.accentColor),
      );

  Widget _timeline(String title, String time, Color color) => DemoLineItem(
        title: title,
        subtitle: 'Workflow event recorded in the audit trail',
        amount: time,
        leading: DemoAvatar(initials: '•', color: color),
      );

  Widget _control(String label, String result, Color color) => DemoMetric(
        label: label,
        value: result,
        icon: result == 'Passed' ? Icons.check_rounded : Icons.priority_high_rounded,
        color: color,
      );

  Widget _allocation(String label, String value, Color color) => DemoLineItem(
        title: label,
        subtitle: 'Allocation rule and ownership dimension',
        amount: value,
        leading: DemoAvatar(initials: value.replaceAll('%', ''), color: color),
        status: DemoStatusChip(label: 'Allocated', color: color),
      );

  Widget _check(String label, bool completed) => DemoLineItem(
        title: label,
        subtitle: completed ? 'Control completed and evidenced' : 'Action is still required',
        amount: completed ? 'Done' : 'Pending',
        leading: DemoAvatar(
          initials: completed ? '✓' : '…',
          color: completed ? AppColors.success : AppColors.warning,
        ),
        status: DemoStatusChip(
          label: completed ? 'Complete' : 'Open',
          color: completed ? AppColors.success : AppColors.warning,
        ),
      );
}
