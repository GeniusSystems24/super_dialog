import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';
import '../../models/example_scenario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/dialogs/dialogs.dart';

/// Reveal animation scenarios (topToBottom, bottomToTop)
class RevealScenarios {
  RevealScenarios._();

  static List<ExampleScenario> getAll() {
    return [
      // ========================================================================
      // TOP TO BOTTOM ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Period Close Reminder',
        description: 'Wide operational banner announcing a financial close deadline.',
        animation: DialogAnimation.topToBottom,
        category: 'Reveal',
        icon: Icons.campaign_rounded,
        accentColor: AppColors.warning,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const TopAnnouncementBanner(widthFactor: 0.8),
      ),

      ExampleScenario(
        title: 'Policy Change Highlight',
        description: 'Focused top banner for a policy or process change.',
        animation: DialogAnimation.topToBottom,
        category: 'Reveal',
        icon: Icons.lightbulb_rounded,
        accentColor: AppColors.primary,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const TopAnnouncementBanner(widthFactor: 0.5),
      ),

      ExampleScenario(
        title: 'Blocking Control Alert',
        description: 'Compact blocking-control alert for immediate review.',
        animation: DialogAnimation.topToBottom,
        category: 'Reveal',
        icon: Icons.warning_amber_rounded,
        accentColor: AppColors.error,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const TopMiniAlert(),
      ),

      ExampleScenario(
        title: 'Posting Success Banner',
        description: 'Posting confirmation dropping from the top edge.',
        animation: DialogAnimation.topToBottom,
        category: 'Reveal',
        icon: Icons.check_circle_rounded,
        accentColor: AppColors.success,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const TopAnnouncementBanner(widthFactor: 0.6),
      ),

      ExampleScenario(
        title: 'Data Export Progress',
        description: 'Download progress indicator from top.',
        animation: DialogAnimation.topToBottom,
        category: 'Reveal',
        icon: Icons.download_rounded,
        accentColor: AppColors.info,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: false,
        builder: (context) => const TopAnnouncementBanner(widthFactor: 0.7),
      ),

      // ========================================================================
      // BOTTOM TO TOP ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Employee Request Details',
        description:
            'Full dialog that lifts from the bottom with dense information.',
        animation: DialogAnimation.bottomToTop,
        category: 'Reveal',
        icon: Icons.description_rounded,
        accentColor: AppColors.primary,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: false,
        builder: (context) =>
            const TimeOffDetailsDialog(alignment: Alignment.bottomCenter),
      ),

      ExampleScenario(
        title: 'Approval Summary',
        description: 'Half-width review panel rising from the bottom center.',
        animation: DialogAnimation.bottomToTop,
        category: 'Reveal',
        icon: Icons.summarize_rounded,
        accentColor: AppColors.success,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const TimeOffDetailsDialog(
          alignment: Alignment.bottomCenter,
          widthFactor: 0.5,
        ),
      ),

      ExampleScenario(
        title: 'Assign Workflow Task',
        description: 'Lightweight assignment bar sliding from the bottom edge.',
        animation: DialogAnimation.bottomToTop,
        category: 'Reveal',
        icon: Icons.person_add_rounded,
        accentColor: AppColors.success,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      ExampleScenario(
        title: 'Document Distribution',
        description: 'Share sheet with multiple options.',
        animation: DialogAnimation.bottomToTop,
        category: 'Reveal',
        icon: Icons.share_rounded,
        accentColor: AppColors.info,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      ExampleScenario(
        title: 'Attachment Picker',
        description: 'Invoice and contract attachment picker rising from the bottom.',
        animation: DialogAnimation.bottomToTop,
        category: 'Reveal',
        icon: Icons.attach_file_rounded,
        accentColor: const Color(0xFF7C5CFC),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const TimeOffDetailsDialog(
          alignment: Alignment.bottomCenter,
          widthFactor: 0.7,
        ),
      ),

      ExampleScenario(
        title: 'Payment Method Selection',
        description: 'Payment selection sheet from bottom.',
        animation: DialogAnimation.bottomToTop,
        category: 'Reveal',
        icon: Icons.payment_rounded,
        accentColor: const Color(0xFF1DB88A),
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      ExampleScenario(
        title: 'Mobile Worklist Filters',
        description: 'Advanced filters panel from bottom.',
        animation: DialogAnimation.bottomToTop,
        category: 'Reveal',
        icon: Icons.tune_rounded,
        accentColor: AppColors.accent,
        barrierColor: const Color(0x8C000000),
        barrierDismissible: true,
        builder: (context) => const TimeOffDetailsDialog(
          alignment: Alignment.bottomCenter,
          widthFactor: 0.6,
        ),
      ),
    ];
  }
}
