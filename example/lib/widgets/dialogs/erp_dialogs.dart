import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

class PurchaseOrderApprovalDialog extends StatelessWidget {
  const PurchaseOrderApprovalDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDialogSurface(
      width: 660,
      title: 'Approve Purchase Order',
      subtitle: 'PO-2026-00428 · Northstar Industrial Supplies',
      icon: Icons.shopping_cart_checkout_rounded,
      iconColor: AppColors.primary,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              DemoStatusChip(
                label: 'Pending approval',
                color: AppColors.warning,
                icon: Icons.schedule_rounded,
              ),
              DemoStatusChip(
                label: 'Within budget',
                color: AppColors.success,
                icon: Icons.account_balance_wallet_outlined,
              ),
              DemoStatusChip(
                label: '3-way match',
                color: AppColors.primary,
                icon: Icons.rule_rounded,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoPanel(
            child: Column(
              children: [
                DemoDataRow(
                  label: 'Requester',
                  value: 'Maya Ortiz · Operations',
                ),
                DemoDivider(),
                DemoDataRow(
                  label: 'Cost center',
                  value: 'CC-410 · Plant Maintenance',
                ),
                DemoDivider(),
                DemoDataRow(label: 'Required by', value: '24 Jul 2026'),
                DemoDivider(),
                DemoDataRow(label: 'Payment terms', value: 'Net 30'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          DemoSection(
            title: 'Order lines',
            subtitle: '3 items · quantities and negotiated pricing',
            trailing: Text(
              r'$18,460.00',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontFamily: 'JetBrainsMono',
              ),
            ),
            child: const DemoPanel(
              child: Column(
                children: [
                  DemoLineItem(
                    title: 'Hydraulic pump assembly',
                    subtitle: 'SKU HP-440 · Qty 2 × \$6,250',
                    amount: r'$12,500.00',
                  ),
                  DemoDivider(),
                  DemoLineItem(
                    title: 'Pressure regulator kit',
                    subtitle: 'SKU PR-18 · Qty 4 × \$890',
                    amount: r'$3,560.00',
                  ),
                  DemoDivider(),
                  DemoLineItem(
                    title: 'Preventive service package',
                    subtitle: 'Labor · Fixed fee',
                    amount: r'$2,400.00',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoNotice(
            message:
                'Approval posts the commitment to the maintenance budget and notifies the vendor. The PO remains editable until goods receipt.',
            color: AppColors.primary,
            icon: Icons.info_outline_rounded,
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
          label: const Text('Approve PO'),
        ),
      ],
    );
  }
}

class JournalEntryDialog extends StatelessWidget {
  const JournalEntryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDialogSurface(
      width: 720,
      title: 'Post Journal Entry',
      subtitle: 'JE-2026-0716-094 · Accrued freight adjustment',
      icon: Icons.account_balance_rounded,
      iconColor: AppColors.success,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DemoResponsiveGrid(
            children: <Widget>[
              DemoMetric(
                label: 'Total debit',
                value: r'$42,750.00',
                icon: Icons.south_east_rounded,
                color: AppColors.primary,
              ),
              DemoMetric(
                label: 'Total credit',
                value: r'$42,750.00',
                icon: Icons.north_east_rounded,
                color: AppColors.success,
                caption: 'Balanced',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoPanel(
            child: Column(
              children: [
                DemoLineItem(
                  title: '6105 · Freight expense',
                  subtitle: 'Plant 01 · Operations',
                  amount: r'DR 42,750.00',
                  leading: DemoAvatar(initials: 'DR'),
                ),
                DemoDivider(),
                DemoLineItem(
                  title: '2210 · Accrued liabilities',
                  subtitle: 'Corporate · Shared services',
                  amount: r'CR 42,750.00',
                  leading: DemoAvatar(initials: 'CR', color: AppColors.success),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoPanel(
            child: Column(
              children: [
                DemoDataRow(label: 'Posting date', value: '16 Jul 2026'),
                DemoDivider(),
                DemoDataRow(label: 'Fiscal period', value: 'FY26 · Period 07'),
                DemoDivider(),
                DemoDataRow(label: 'Source', value: 'Manual adjustment'),
                DemoDivider(),
                DemoDataRow(label: 'Prepared by', value: 'Amir Hassan'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoNotice(
            message:
                'This entry affects the current open period. Posting creates an immutable audit event and updates the general ledger immediately.',
            color: AppColors.warning,
            icon: Icons.gavel_rounded,
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Save draft'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.publish_rounded, size: 16),
          label: const Text('Post entry'),
        ),
      ],
    );
  }
}

class InventoryTransferDialog extends StatelessWidget {
  const InventoryTransferDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDialogSurface(
      width: 680,
      title: 'Create Inventory Transfer',
      subtitle: 'Move available stock between warehouse locations',
      icon: Icons.swap_horiz_rounded,
      iconColor: AppColors.primary,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _TransferLocations(),
          const SizedBox(height: AppSpacing.lg),
          const DemoSection(
            title: 'Transfer items',
            subtitle: 'Availability is calculated in real time',
            child: DemoPanel(
              child: Column(
                children: [
                  DemoLineItem(
                    title: 'Bearing assembly 6205-ZZ',
                    subtitle: 'On hand 184 · Transfer 24',
                    amount: '24 EA',
                    status: DemoStatusChip(
                      label: 'Available',
                      color: AppColors.success,
                    ),
                  ),
                  DemoDivider(),
                  DemoLineItem(
                    title: 'Industrial lubricant 20L',
                    subtitle: 'On hand 38 · Transfer 12',
                    amount: '12 EA',
                    status: DemoStatusChip(
                      label: 'Low after',
                      color: AppColors.warning,
                    ),
                  ),
                  DemoDivider(),
                  DemoLineItem(
                    title: 'Safety relay module',
                    subtitle: 'On hand 55 · Transfer 8',
                    amount: '8 EA',
                    status: DemoStatusChip(
                      label: 'Available',
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoNotice(
            message:
                'The transfer creates an in-transit document. Receiving staff at WH-04 must confirm quantities before stock is released.',
            color: AppColors.primary,
            icon: Icons.local_shipping_outlined,
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.send_rounded, size: 16),
          label: const Text('Create transfer'),
        ),
      ],
    );
  }
}

class CustomerCreditHoldDialog extends StatelessWidget {
  const CustomerCreditHoldDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDialogSurface(
      width: 620,
      title: 'Review Credit Hold',
      subtitle: 'C-100284 · Apex Retail Group',
      icon: Icons.credit_card_off_rounded,
      iconColor: AppColors.error,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DemoResponsiveGrid(
            children: <Widget>[
              DemoMetric(
                label: 'Credit limit',
                value: r'$250,000',
                icon: Icons.account_balance_wallet_outlined,
                color: AppColors.primary,
              ),
              DemoMetric(
                label: 'Exposure',
                value: r'$286,420',
                icon: Icons.trending_up_rounded,
                color: AppColors.error,
                caption: '114.6% utilized',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoPanel(
            child: Column(
              children: [
                DemoDataRow(
                  label: 'Past due balance',
                  value: r'$48,900',
                  valueColor: AppColors.error,
                ),
                DemoDivider(),
                DemoDataRow(label: 'Oldest overdue invoice', value: '46 days'),
                DemoDivider(),
                DemoDataRow(label: 'Open sales orders', value: r'$72,300'),
                DemoDivider(),
                DemoDataRow(label: 'Risk score', value: 'B- · Moderate risk'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoNotice(
            message:
                'Releasing the hold allows SO-30291 to proceed. The account will remain above its approved limit until the next payment is applied.',
            color: AppColors.error,
            icon: Icons.warning_amber_rounded,
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Keep hold'),
        ),
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: AppColors.error),
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.lock_open_rounded, size: 16),
          label: const Text('Release once'),
        ),
      ],
    );
  }
}

class InvoiceSettlementDialog extends StatelessWidget {
  const InvoiceSettlementDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDialogSurface(
      width: 640,
      title: 'Apply Customer Payment',
      subtitle: 'Receipt RCPT-2026-8831 · Meridian Foods',
      icon: Icons.payments_rounded,
      iconColor: AppColors.success,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DemoMetric(
            label: 'Unapplied receipt',
            value: r'$38,240.00',
            icon: Icons.savings_outlined,
            color: AppColors.success,
            caption: 'Bank matched · 16 Jul 2026',
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoSection(
            title: 'Selected invoices',
            subtitle: 'Oldest due invoices are applied first',
            child: DemoPanel(
              child: Column(
                children: [
                  DemoLineItem(
                    title: 'INV-104982',
                    subtitle: 'Due 04 Jul 2026 · 12 days overdue',
                    amount: r'$18,900.00',
                    status: DemoStatusChip(
                      label: 'Full',
                      color: AppColors.success,
                    ),
                  ),
                  DemoDivider(),
                  DemoLineItem(
                    title: 'INV-105114',
                    subtitle: 'Due 12 Jul 2026 · 4 days overdue',
                    amount: r'$14,600.00',
                    status: DemoStatusChip(
                      label: 'Full',
                      color: AppColors.success,
                    ),
                  ),
                  DemoDivider(),
                  DemoLineItem(
                    title: 'INV-105290',
                    subtitle: 'Due 28 Jul 2026 · Current',
                    amount: r'$4,740.00',
                    status: DemoStatusChip(
                      label: 'Partial',
                      color: AppColors.warning,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoPanel(
            child: Column(
              children: [
                DemoDataRow(label: 'Applied amount', value: r'$38,240.00'),
                DemoDivider(),
                DemoDataRow(
                  label: 'Remaining receipt',
                  value: r'$0.00',
                  valueColor: AppColors.success,
                ),
                DemoDivider(),
                DemoDataRow(label: 'Discount taken', value: r'$0.00'),
              ],
            ),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Review allocation'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.check_circle_outline_rounded, size: 16),
          label: const Text('Post settlement'),
        ),
      ],
    );
  }
}

class VendorOnboardingDialog extends StatelessWidget {
  const VendorOnboardingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDialogSurface(
      width: 660,
      title: 'Vendor Onboarding Review',
      subtitle: 'VND-DRAFT-1192 · Atlas Engineering Services',
      icon: Icons.domain_add_rounded,
      iconColor: AppColors.primary,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              DemoStatusChip(
                label: 'Tax verified',
                color: AppColors.success,
                icon: Icons.verified_outlined,
              ),
              DemoStatusChip(
                label: 'Bank pending',
                color: AppColors.warning,
                icon: Icons.account_balance_outlined,
              ),
              DemoStatusChip(
                label: 'Low risk',
                color: AppColors.success,
                icon: Icons.shield_outlined,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoPanel(
            child: Column(
              children: [
                DemoDataRow(
                  label: 'Legal entity',
                  value: 'Atlas Engineering Services LLC',
                ),
                DemoDivider(),
                DemoDataRow(
                  label: 'Country / tax ID',
                  value: 'United States · 84-***2190',
                ),
                DemoDivider(),
                DemoDataRow(
                  label: 'Category',
                  value: 'Maintenance & technical services',
                ),
                DemoDivider(),
                DemoDataRow(label: 'Payment terms', value: 'Net 45'),
                DemoDivider(),
                DemoDataRow(
                  label: 'Requested by',
                  value: 'Procurement Operations',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoSection(
            title: 'Compliance documents',
            child: DemoPanel(
              child: Column(
                children: [
                  _DocumentRow(
                    title: 'W-9 tax form',
                    status: 'Verified',
                    color: AppColors.success,
                  ),
                  DemoDivider(),
                  _DocumentRow(
                    title: 'Insurance certificate',
                    status: 'Valid to Mar 2027',
                    color: AppColors.success,
                  ),
                  DemoDivider(),
                  _DocumentRow(
                    title: 'Bank ownership letter',
                    status: 'Awaiting validation',
                    color: AppColors.warning,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoNotice(
            message:
                'The vendor can be approved provisionally, but payment remains blocked until bank ownership validation completes.',
            color: AppColors.warning,
            icon: Icons.policy_outlined,
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Request changes'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.how_to_reg_rounded, size: 16),
          label: const Text('Approve provisionally'),
        ),
      ],
    );
  }
}

class PeriodCloseDialog extends StatelessWidget {
  const PeriodCloseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDialogSurface(
      width: 700,
      title: 'Close Accounting Period',
      subtitle: 'FY26 · Period 07 · Preliminary close',
      icon: Icons.event_available_rounded,
      iconColor: AppColors.warning,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DemoResponsiveGrid(
            children: <Widget>[
              DemoMetric(
                label: 'Tasks complete',
                value: '27 / 30',
                icon: Icons.task_alt_rounded,
                color: AppColors.success,
                caption: '90% complete',
              ),
              DemoMetric(
                label: 'Open exceptions',
                value: '3',
                icon: Icons.report_problem_outlined,
                color: AppColors.warning,
                caption: '2 require action',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoPanel(
            child: Column(
              children: [
                _ChecklistRow(
                  label: 'Bank reconciliations',
                  detail: '12 / 12 complete',
                  complete: true,
                ),
                DemoDivider(),
                _ChecklistRow(
                  label: 'Inventory valuation',
                  detail: 'Posted at 18:42',
                  complete: true,
                ),
                DemoDivider(),
                _ChecklistRow(
                  label: 'Intercompany matching',
                  detail: '2 mismatches remaining',
                  complete: false,
                ),
                DemoDivider(),
                _ChecklistRow(
                  label: 'Revenue recognition',
                  detail: 'Completed',
                  complete: true,
                ),
                DemoDivider(),
                _ChecklistRow(
                  label: 'FX revaluation',
                  detail: 'Awaiting treasury rate',
                  complete: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoNotice(
            message:
                'Preliminary close blocks routine postings but permits authorized close adjustments. Final close remains unavailable until all critical exceptions are resolved.',
            color: AppColors.warning,
            icon: Icons.lock_clock_outlined,
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('View exceptions'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.lock_outline_rounded, size: 16),
          label: const Text('Start preliminary close'),
        ),
      ],
    );
  }
}

class StockReorderDialog extends StatelessWidget {
  const StockReorderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDialogSurface(
      width: 600,
      title: 'Reorder Recommendation',
      subtitle: 'SKU RM-4408 · High-tensile steel plate',
      icon: Icons.inventory_rounded,
      iconColor: AppColors.warning,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DemoResponsiveGrid(
            children: <Widget>[
              DemoMetric(
                label: 'Available',
                value: '18 sheets',
                icon: Icons.inventory_2_outlined,
                color: AppColors.error,
                caption: 'Below safety stock',
              ),
              DemoMetric(
                label: 'Recommended order',
                value: '120 sheets',
                icon: Icons.add_shopping_cart_rounded,
                color: AppColors.primary,
                caption: '42 days coverage',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoPanel(
            child: Column(
              children: [
                DemoDataRow(label: 'Average daily usage', value: '2.8 sheets'),
                DemoDivider(),
                DemoDataRow(label: 'Open demand', value: '64 sheets'),
                DemoDivider(),
                DemoDataRow(label: 'Supplier lead time', value: '18 days'),
                DemoDivider(),
                DemoDataRow(
                  label: 'Preferred supplier',
                  value: 'Metro Metals Co.',
                ),
                DemoDivider(),
                DemoDataRow(label: 'Estimated value', value: r'$31,680.00'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoNotice(
            message:
                'Current stock is projected to run out in 6 days. Creating the requisition today maintains production coverage with a 4-day buffer.',
            color: AppColors.error,
            icon: Icons.production_quantity_limits_rounded,
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Dismiss alert'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.playlist_add_rounded, size: 16),
          label: const Text('Create requisition'),
        ),
      ],
    );
  }
}

class BudgetVarianceDialog extends StatelessWidget {
  const BudgetVarianceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDialogSurface(
      width: 680,
      title: 'Budget Variance Review',
      subtitle: 'Cost center CC-410 · Plant Maintenance · Jul 2026',
      icon: Icons.analytics_outlined,
      iconColor: AppColors.error,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DemoResponsiveGrid(
            children: <Widget>[
              DemoMetric(
                label: 'Monthly budget',
                value: r'$185,000',
                icon: Icons.account_balance_wallet_outlined,
                color: AppColors.primary,
              ),
              DemoMetric(
                label: 'Forecast actual',
                value: r'$214,800',
                icon: Icons.trending_up_rounded,
                color: AppColors.error,
                caption: '+16.1% unfavorable',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoPanel(
            child: Column(
              children: [
                DemoLineItem(
                  title: 'Emergency equipment repairs',
                  subtitle: 'Unplanned work order WO-8812',
                  amount: r'+$18,400',
                  status: DemoStatusChip(
                    label: 'Unplanned',
                    color: AppColors.error,
                  ),
                ),
                DemoDivider(),
                DemoLineItem(
                  title: 'Contractor overtime',
                  subtitle: 'Shutdown maintenance support',
                  amount: r'+$9,600',
                  status: DemoStatusChip(
                    label: 'Review',
                    color: AppColors.warning,
                  ),
                ),
                DemoDivider(),
                DemoLineItem(
                  title: 'Spare parts savings',
                  subtitle: 'Supplier rebate and price variance',
                  amount: r'-$4,200',
                  status: DemoStatusChip(
                    label: 'Favorable',
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoNotice(
            message:
                'Submitting the explanation locks this month’s narrative for management reporting. Supporting documents remain editable until final close.',
            color: AppColors.primary,
            icon: Icons.description_outlined,
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Open details'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.send_rounded, size: 16),
          label: const Text('Submit explanation'),
        ),
      ],
    );
  }
}

class PayrollRunDialog extends StatelessWidget {
  const PayrollRunDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDialogSurface(
      width: 650,
      title: 'Approve Payroll Run',
      subtitle: 'US Biweekly · Pay date 24 Jul 2026',
      icon: Icons.groups_rounded,
      iconColor: AppColors.success,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DemoResponsiveGrid(
            children: <Widget>[
              DemoMetric(
                label: 'Employees',
                value: '428',
                icon: Icons.badge_outlined,
                color: AppColors.primary,
              ),
              DemoMetric(
                label: 'Net payroll',
                value: r'$1.42M',
                icon: Icons.payments_outlined,
                color: AppColors.success,
                caption: '+1.8% vs prior run',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoPanel(
            child: Column(
              children: [
                DemoDataRow(label: 'Gross earnings', value: r'$2,084,620.00'),
                DemoDivider(),
                DemoDataRow(label: 'Employee taxes', value: r'$438,270.00'),
                DemoDivider(),
                DemoDataRow(
                  label: 'Benefits and deductions',
                  value: r'$226,940.00',
                ),
                DemoDivider(),
                DemoDataRow(
                  label: 'Net pay',
                  value: r'$1,419,410.00',
                  valueColor: AppColors.success,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoSection(
            title: 'Validation summary',
            child: DemoPanel(
              child: Column(
                children: [
                  _ChecklistRow(
                    label: 'Bank account validation',
                    detail: '428 passed',
                    complete: true,
                  ),
                  DemoDivider(),
                  _ChecklistRow(
                    label: 'Tax calculation',
                    detail: 'No blocking errors',
                    complete: true,
                  ),
                  DemoDivider(),
                  _ChecklistRow(
                    label: 'Large payment review',
                    detail: '3 reviewed by payroll lead',
                    complete: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Return to payroll'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.verified_user_outlined, size: 16),
          label: const Text('Approve payroll'),
        ),
      ],
    );
  }
}

class _TransferLocations extends StatelessWidget {
  const _TransferLocations();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked = constraints.maxWidth < 520;
        const from = _LocationCard(
          label: 'From warehouse',
          code: 'WH-01',
          name: 'Central Distribution',
          color: AppColors.primary,
        );
        const to = _LocationCard(
          label: 'To warehouse',
          code: 'WH-04',
          name: 'East Service Hub',
          color: AppColors.success,
        );
        final arrow = Icon(
          stacked ? Icons.arrow_downward_rounded : Icons.arrow_forward_rounded,
          color: color,
        );
        if (stacked) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              from,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Center(child: arrow),
              ),
              to,
            ],
          );
        }
        return Row(
          children: <Widget>[
            Expanded(child: from),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: arrow,
            ),
            Expanded(child: to),
          ],
        );
      },
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    required this.label,
    required this.code,
    required this.name,
    required this.color,
  });

  final String label;
  final String code;
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DemoPanel(
      tint: color.withValues(alpha: 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.55,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            code,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontFamily: 'JetBrainsMono',
            ),
          ),
          const SizedBox(height: 2),
          Text(
            name,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentRow extends StatelessWidget {
  const _DocumentRow({
    required this.title,
    required this.status,
    required this.color,
  });

  final String title;
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 390;
          final titleWidget = Row(
            children: <Widget>[
              Icon(Icons.description_outlined, size: 18, color: color),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                titleWidget,
                const SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: DemoStatusChip(label: status, color: color),
                ),
              ],
            );
          }
          return Row(
            children: <Widget>[
              Expanded(child: titleWidget),
              const SizedBox(width: AppSpacing.md),
              DemoStatusChip(label: status, color: color),
            ],
          );
        },
      ),
    );
  }
}

class _ChecklistRow extends StatelessWidget {
  const _ChecklistRow({
    required this.label,
    required this.detail,
    required this.complete,
  });

  final String label;
  final String detail;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    final color = complete ? AppColors.success : AppColors.warning;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 420;
          final labelWidget = Row(
            children: <Widget>[
              Icon(
                complete ? Icons.check_circle_rounded : Icons.pending_rounded,
                size: 18,
                color: color,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
          final detailWidget = Text(
            detail,
            style: theme.textTheme.bodySmall?.copyWith(color: color),
          );
          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                labelWidget,
                const SizedBox(height: AppSpacing.xs),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 30),
                  child: detailWidget,
                ),
              ],
            );
          }
          return Row(
            children: <Widget>[
              Expanded(child: labelWidget),
              const SizedBox(width: AppSpacing.md),
              detailWidget,
            ],
          );
        },
      ),
    );
  }
}
