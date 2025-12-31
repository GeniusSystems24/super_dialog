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
        title: 'Top Banner - Reminder',
        description: 'Wide banner dropping from the top to announce deadlines.',
        animation: DialogAnimation.topToBottom,
        category: 'Reveal',
        icon: Icons.campaign_rounded,
        accentColor: AppColors.warning,
        barrierColor: Colors.black.withValues(alpha: 0.25),
        barrierDismissible: true,
        builder: (context) => const TopAnnouncementBanner(widthFactor: 0.8),
      ),

      ExampleScenario(
        title: 'Half Width Highlight',
        description: 'Half-width banner anchored to the top center.',
        animation: DialogAnimation.topToBottom,
        category: 'Reveal',
        icon: Icons.lightbulb_rounded,
        accentColor: AppColors.primary,
        barrierColor: Colors.black.withValues(alpha: 0.28),
        barrierDismissible: true,
        builder: (context) => const TopAnnouncementBanner(widthFactor: 0.5),
      ),

      ExampleScenario(
        title: 'Compact Alert',
        description: 'Minimal alert strip for quick heads-up messages.',
        animation: DialogAnimation.topToBottom,
        category: 'Reveal',
        icon: Icons.warning_amber_rounded,
        accentColor: AppColors.error,
        barrierColor: Colors.black.withValues(alpha: 0.20),
        barrierDismissible: true,
        builder: (context) => const TopMiniAlert(),
      ),

      ExampleScenario(
        title: 'Success Banner',
        description: 'Success message dropping from top.',
        animation: DialogAnimation.topToBottom,
        category: 'Reveal',
        icon: Icons.check_circle_rounded,
        accentColor: AppColors.success,
        barrierColor: Colors.black.withValues(alpha: 0.22),
        barrierDismissible: true,
        builder: (context) => const TopAnnouncementBanner(widthFactor: 0.6),
      ),

      ExampleScenario(
        title: 'Download Progress',
        description: 'Download progress indicator from top.',
        animation: DialogAnimation.topToBottom,
        category: 'Reveal',
        icon: Icons.download_rounded,
        accentColor: AppColors.info,
        barrierColor: Colors.black.withValues(alpha: 0.18),
        barrierDismissible: false,
        builder: (context) => const TopAnnouncementBanner(widthFactor: 0.7),
      ),

      // ========================================================================
      // BOTTOM TO TOP ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Bottom Sheet - Details',
        description:
            'Full dialog that lifts from the bottom with dense information.',
        animation: DialogAnimation.bottomToTop,
        category: 'Reveal',
        icon: Icons.description_rounded,
        accentColor: AppColors.primary,
        barrierColor: Colors.black.withValues(alpha: 0.35),
        barrierDismissible: false,
        builder: (context) =>
            const TimeOffDetailsDialog(alignment: Alignment.bottomCenter),
      ),

      ExampleScenario(
        title: 'Half Width Summary',
        description: 'Half-width review panel rising from the bottom center.',
        animation: DialogAnimation.bottomToTop,
        category: 'Reveal',
        icon: Icons.summarize_rounded,
        accentColor: AppColors.success,
        barrierColor: Colors.black.withValues(alpha: 0.32),
        barrierDismissible: true,
        builder: (context) => const TimeOffDetailsDialog(
          alignment: Alignment.bottomCenter,
          widthFactor: 0.5,
        ),
      ),

      ExampleScenario(
        title: 'Quick Assign',
        description: 'Lightweight assignment bar sliding from the bottom edge.',
        animation: DialogAnimation.bottomToTop,
        category: 'Reveal',
        icon: Icons.person_add_rounded,
        accentColor: AppColors.success,
        barrierColor: Colors.black.withValues(alpha: 0.25),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      ExampleScenario(
        title: 'Share Options',
        description: 'Share sheet with multiple options.',
        animation: DialogAnimation.bottomToTop,
        category: 'Reveal',
        icon: Icons.share_rounded,
        accentColor: AppColors.info,
        barrierColor: Colors.black.withValues(alpha: 0.30),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      ExampleScenario(
        title: 'Media Picker',
        description: 'Photo/video picker rising from bottom.',
        animation: DialogAnimation.bottomToTop,
        category: 'Reveal',
        icon: Icons.photo_library_rounded,
        accentColor: const Color(0xFF8B5CF6),
        barrierColor: Colors.black.withValues(alpha: 0.35),
        barrierDismissible: true,
        builder: (context) => const TimeOffDetailsDialog(
          alignment: Alignment.bottomCenter,
          widthFactor: 0.7,
        ),
      ),

      ExampleScenario(
        title: 'Payment Methods',
        description: 'Payment selection sheet from bottom.',
        animation: DialogAnimation.bottomToTop,
        category: 'Reveal',
        icon: Icons.payment_rounded,
        accentColor: const Color(0xFF14B8A6),
        barrierColor: Colors.black.withValues(alpha: 0.32),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      ExampleScenario(
        title: 'Filter Bottom Sheet',
        description: 'Advanced filters panel from bottom.',
        animation: DialogAnimation.bottomToTop,
        category: 'Reveal',
        icon: Icons.tune_rounded,
        accentColor: AppColors.accent,
        barrierColor: Colors.black.withValues(alpha: 0.28),
        barrierDismissible: true,
        builder: (context) => const TimeOffDetailsDialog(
          alignment: Alignment.bottomCenter,
          widthFactor: 0.6,
        ),
      ),
    ];
  }
}
