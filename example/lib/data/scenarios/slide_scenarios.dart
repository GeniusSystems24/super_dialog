import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';
import '../../models/example_scenario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/dialogs/dialogs.dart';

/// Slide animation scenarios (startToEnd, endToStart)
class SlideScenarios {
  SlideScenarios._();

  static List<ExampleScenario> getAll() {
    return [
      // ========================================================================
      // START TO END ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Start Drawer · Leave Request',
        description:
            'Employee self-service request form sliding from the start edge.',
        animation: DialogAnimation.startToEnd,
        category: 'Slide',
        icon: Icons.calendar_month_rounded,
        accentColor: AppColors.primary,
        constraints: const BoxConstraints(maxWidth: 720),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) =>
            const AddTimeOffDialog(alignment: Alignment.centerLeft),
        codeSnippet: '''SuperDialog.showAnimatedDialog<void>(
  context,
  (context) => const MyDrawer(),
  animation: DialogAnimation.startToEnd,
  constraints: const BoxConstraints(maxWidth: 720),
  barrierColor: Colors.black.withOpacity(0.25),
  barrierDismissible: true,
);''',
      ),

      ExampleScenario(
        title: 'Onboarding Checklist',
        description: 'Half-width task checklist for controlled onboarding activities.',
        animation: DialogAnimation.startToEnd,
        category: 'Slide',
        icon: Icons.checklist_rounded,
        accentColor: AppColors.accent,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.5,
          alignment: AlignmentDirectional.centerStart,
          child: NotesPanel(
            accentColor: AppColors.accent,
            title: 'Onboarding tasks',
            items: ['Send NDA packet', 'Create HRIS account', 'Assign mentor'],
          ),
        ),
        codeSnippet: '''SuperDialog.showAnimatedDialog<void>(
  context,
  (context) => const FractionallySizedBox(
    widthFactor: 0.5,
    alignment: AlignmentDirectional.centerStart,
    child: MyPanel(),
  ),
  animation: DialogAnimation.startToEnd,
);''',
      ),

      ExampleScenario(
        title: 'ERP Worklist Filters',
        description: 'Filter an ERP document worklist by status, period, and owner.',
        animation: DialogAnimation.startToEnd,
        category: 'Slide',
        icon: Icons.filter_list_rounded,
        accentColor: AppColors.success,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const FilterPanel(),
        codeSnippet: '''SuperDialog.showAnimatedDialog<void>(
  context,
  (context) => const FilterPanel(),
  animation: DialogAnimation.startToEnd,
  barrierDismissible: true,
);''',
      ),

      ExampleScenario(
        title: 'Module Navigation',
        description: 'Full-height module navigation for finance and operations.',
        animation: DialogAnimation.startToEnd,
        category: 'Slide',
        icon: Icons.menu_rounded,
        accentColor: AppColors.info,
        constraints: const BoxConstraints(maxWidth: 320),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.35,
          alignment: AlignmentDirectional.centerStart,
          child: NotesPanel(
            accentColor: AppColors.info,
            title: 'Navigation',
            items: ['Dashboard', 'Projects', 'Team', 'Settings'],
          ),
        ),
      ),

      ExampleScenario(
        title: 'Employee Master Sidebar',
        description: 'Employee master-data panel sliding from the start edge.',
        animation: DialogAnimation.startToEnd,
        category: 'Slide',
        icon: Icons.person_rounded,
        accentColor: const Color(0xFF7C5CFC),
        constraints: const BoxConstraints(maxWidth: 400),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) =>
            const AddTimeOffDialog(alignment: Alignment.centerLeft),
      ),

      // ========================================================================
      // END TO START ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'End Drawer · Leave Request',
        description:
            'Mirrored employee request form sliding from the end edge.',
        animation: DialogAnimation.endToStart,
        category: 'Slide',
        icon: Icons.event_note_rounded,
        accentColor: AppColors.info,
        constraints: const BoxConstraints(maxWidth: 720),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) =>
            const AddTimeOffDialog(alignment: Alignment.centerRight),
      ),

      ExampleScenario(
        title: 'Document Audit Trail',
        description: 'Half-width immutable document audit trail pinned to the end side.',
        animation: DialogAnimation.endToStart,
        category: 'Slide',
        icon: Icons.history_rounded,
        accentColor: AppColors.info,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.5,
          alignment: AlignmentDirectional.centerEnd,
          child: NotesPanel(
            accentColor: AppColors.info,
            title: 'Audit log',
            items: [
              '09:24 Approved PTO',
              '09:40 Updated balance',
              '10:15 Emailed summary',
            ],
          ),
        ),
      ),

      ExampleScenario(
        title: 'Operations Analytics Panel',
        description:
            'Operational KPIs and exception metrics sliding from the end edge.',
        animation: DialogAnimation.endToStart,
        category: 'Slide',
        icon: Icons.insights_rounded,
        accentColor: AppColors.success,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const AnalyticsPanel(),
      ),

      ExampleScenario(
        title: 'Purchase Requisition Cart',
        description: 'Draft purchase requisition lines sliding from the end edge.',
        animation: DialogAnimation.endToStart,
        category: 'Slide',
        icon: Icons.playlist_add_rounded,
        accentColor: const Color(0xFFEF4444),
        constraints: const BoxConstraints(maxWidth: 450),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.4,
          alignment: AlignmentDirectional.centerEnd,
          child: NotesPanel(
            accentColor: Color(0xFFEF4444),
            title: 'Requisition',
            items: ['Product A', 'Product B', 'Product C'],
          ),
        ),
      ),

      ExampleScenario(
        title: 'Workflow Notifications',
        description: 'Approval, posting, and exception notifications sliding from the end edge.',
        animation: DialogAnimation.endToStart,
        category: 'Slide',
        icon: Icons.notifications_rounded,
        accentColor: AppColors.warning,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const DemoAdaptivePanel(
          widthFactor: 0.45,
          alignment: AlignmentDirectional.centerEnd,
          child: NotesPanel(
            accentColor: AppColors.warning,
            title: 'Notifications',
            items: ['New message', 'Task completed', 'Update available'],
          ),
        ),
      ),
    ];
  }
}
