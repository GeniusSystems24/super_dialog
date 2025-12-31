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
        title: 'Start Drawer - Planner',
        description:
            'Full schedule builder sliding from the start edge with form controls.',
        animation: DialogAnimation.startToEnd,
        category: 'Slide',
        icon: Icons.calendar_month_rounded,
        accentColor: AppColors.primary,
        constraints: const BoxConstraints(maxWidth: 720),
        barrierColor: Colors.black.withValues(alpha: 0.25),
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
        title: 'Half Width Checklist',
        description: 'Uses FractionallySizedBox to occupy half the viewport.',
        animation: DialogAnimation.startToEnd,
        category: 'Slide',
        icon: Icons.checklist_rounded,
        accentColor: AppColors.accent,
        barrierColor: Colors.black.withValues(alpha: 0.20),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
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
        title: 'Filter Controls',
        description: 'Compact filter surface that arrives from the start edge.',
        animation: DialogAnimation.startToEnd,
        category: 'Slide',
        icon: Icons.filter_list_rounded,
        accentColor: AppColors.success,
        barrierColor: Colors.black.withValues(alpha: 0.15),
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
        title: 'Navigation Menu',
        description: 'Full-height navigation drawer with menu items.',
        animation: DialogAnimation.startToEnd,
        category: 'Slide',
        icon: Icons.menu_rounded,
        accentColor: AppColors.info,
        constraints: const BoxConstraints(maxWidth: 320),
        barrierColor: Colors.black.withValues(alpha: 0.30),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
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
        title: 'User Profile Sidebar',
        description: 'Profile information panel sliding from start.',
        animation: DialogAnimation.startToEnd,
        category: 'Slide',
        icon: Icons.person_rounded,
        accentColor: const Color(0xFF8B5CF6),
        constraints: const BoxConstraints(maxWidth: 400),
        barrierColor: Colors.black.withValues(alpha: 0.22),
        barrierDismissible: true,
        builder: (context) =>
            const AddTimeOffDialog(alignment: Alignment.centerLeft),
      ),

      // ========================================================================
      // END TO START ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'End Drawer - Planner',
        description:
            'Mirrored schedule builder that slides in from the end edge.',
        animation: DialogAnimation.endToStart,
        category: 'Slide',
        icon: Icons.event_note_rounded,
        accentColor: AppColors.info,
        constraints: const BoxConstraints(maxWidth: 720),
        barrierColor: Colors.black.withValues(alpha: 0.25),
        barrierDismissible: true,
        builder: (context) =>
            const AddTimeOffDialog(alignment: Alignment.centerRight),
      ),

      ExampleScenario(
        title: 'Activity Feed',
        description: 'Half-width activity feed pinned to the end side.',
        animation: DialogAnimation.endToStart,
        category: 'Slide',
        icon: Icons.history_rounded,
        accentColor: AppColors.info,
        barrierColor: Colors.black.withValues(alpha: 0.20),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
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
        title: 'Analytics Panel',
        description:
            'A metrics panel with quick stats sliding from the end edge.',
        animation: DialogAnimation.endToStart,
        category: 'Slide',
        icon: Icons.insights_rounded,
        accentColor: AppColors.success,
        barrierColor: Colors.black.withValues(alpha: 0.18),
        barrierDismissible: true,
        builder: (context) => const AnalyticsPanel(),
      ),

      ExampleScenario(
        title: 'Shopping Cart',
        description: 'E-commerce cart panel sliding from end.',
        animation: DialogAnimation.endToStart,
        category: 'Slide',
        icon: Icons.shopping_cart_rounded,
        accentColor: const Color(0xFFEC4899),
        constraints: const BoxConstraints(maxWidth: 450),
        barrierColor: Colors.black.withValues(alpha: 0.28),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
          widthFactor: 0.4,
          alignment: AlignmentDirectional.centerEnd,
          child: NotesPanel(
            accentColor: Color(0xFFEC4899),
            title: 'Cart',
            items: ['Product A', 'Product B', 'Product C'],
          ),
        ),
      ),

      ExampleScenario(
        title: 'Notifications Center',
        description: 'Notification list sliding from end edge.',
        animation: DialogAnimation.endToStart,
        category: 'Slide',
        icon: Icons.notifications_rounded,
        accentColor: AppColors.warning,
        barrierColor: Colors.black.withValues(alpha: 0.20),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
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
