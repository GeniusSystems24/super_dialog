import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';
import '../../models/example_scenario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/dialogs/dialogs.dart';

/// Transform animation scenarios (all centerScale, centerFade, rotation, bounce, elastic, expand, flip, and combined animations)
class TransformScenarios {
  TransformScenarios._();

  static List<ExampleScenario> getAll() {
    return [
      // ========================================================================
      // CENTER SCALE ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Center Scale - Approval',
        description:
            'Scaled approval prompt that mirrors the reference animation.',
        animation: DialogAnimation.centerScale,
        category: 'Transform',
        icon: Icons.verified_rounded,
        accentColor: AppColors.primary,
        barrierColor: Colors.black.withValues(alpha: 0.50),
        barrierBlur: 8,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Half Width Roadmap',
        description: 'A half-width roadmap card that scales into view.',
        animation: DialogAnimation.centerScale,
        category: 'Transform',
        icon: Icons.map_rounded,
        accentColor: AppColors.accent,
        barrierColor: Colors.black.withValues(alpha: 0.45),
        barrierDismissible: true,
        builder: (context) =>
            const FractionallySizedBox(widthFactor: 0.5, child: RoadmapCard()),
      ),

      ExampleScenario(
        title: 'Countdown Timer',
        description: 'Compact countdown card for upcoming approvals.',
        animation: DialogAnimation.centerScale,
        category: 'Transform',
        icon: Icons.timer_rounded,
        accentColor: AppColors.warning,
        barrierColor: Colors.black.withValues(alpha: 0.40),
        barrierDismissible: true,
        builder: (context) => const CenterCountdownCard(),
      ),

      ExampleScenario(
        title: 'Confirmation Dialog',
        description: 'Standard confirmation with scale animation.',
        animation: DialogAnimation.centerScale,
        category: 'Transform',
        icon: Icons.help_outline_rounded,
        accentColor: AppColors.info,
        barrierColor: Colors.black.withValues(alpha: 0.42),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Image Preview',
        description: 'Photo viewer scaling from center.',
        animation: DialogAnimation.centerScale,
        category: 'Transform',
        icon: Icons.image_rounded,
        accentColor: const Color(0xFF8B5CF6),
        barrierColor: Colors.black.withValues(alpha: 0.60),
        barrierBlur: 10,
        barrierDismissible: true,
        builder: (context) =>
            const FractionallySizedBox(widthFactor: 0.6, child: RoadmapCard()),
      ),

      // ========================================================================
      // CENTER FADE ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Status Toast',
        description: 'Subtle status toast that fades in place.',
        animation: DialogAnimation.centerFade,
        category: 'Transform',
        icon: Icons.check_circle_rounded,
        accentColor: AppColors.success,
        barrierColor: Colors.black.withValues(alpha: 0.35),
        barrierDismissible: true,
        builder: (context) => const StatusNotificationDialog(),
      ),

      ExampleScenario(
        title: 'Guarded Exit Prompt',
        description:
            'Uses onDismissed to confirm leaving the page after fade close.',
        animation: DialogAnimation.centerFade,
        category: 'Transform',
        icon: Icons.lock_rounded,
        accentColor: AppColors.error,
        barrierColor: Colors.black.withValues(alpha: 0.45),
        barrierDismissible: true,
        builder: (context) => const GuardedExitDialog(),
        onDismissed: (context) {
          Future.microtask(() async {
            final bool? shouldLeave = await showDialog<bool>(
              context: context,
              barrierDismissible: false,
              builder: (dialogContext) => AlertDialog(
                title: const Text('Close example screen?'),
                content: const Text(
                  'The dialog has been dismissed.\nDo you want to exit this demo screen?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                    child: const Text('Stay here'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.of(dialogContext).pop(true),
                    child: const Text('Leave screen'),
                  ),
                ],
              ),
            );
            if (shouldLeave == true && context.mounted) {
              Navigator.of(context).maybePop();
            }
          });
        },
      ),

      ExampleScenario(
        title: 'Half Width Reminder',
        description: 'Half-width reminder card that fades without motion.',
        animation: DialogAnimation.centerFade,
        category: 'Transform',
        icon: Icons.lightbulb_rounded,
        accentColor: AppColors.accent,
        barrierColor: Colors.black.withValues(alpha: 0.38),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
          widthFactor: 0.5,
          child: CenterReminderCard(),
        ),
      ),

      ExampleScenario(
        title: 'Loading Overlay',
        description: 'Loading indicator fading in.',
        animation: DialogAnimation.centerFade,
        category: 'Transform',
        icon: Icons.hourglass_empty_rounded,
        accentColor: AppColors.primary,
        barrierColor: Colors.black.withValues(alpha: 0.40),
        barrierDismissible: false,
        builder: (context) => const StatusNotificationDialog(),
      ),

      // ========================================================================
      // ROTATION ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Playful Notification',
        description: 'Dialog rotates in with a fun, dynamic entrance.',
        animation: DialogAnimation.rotateIn,
        category: 'Transform',
        icon: Icons.celebration_rounded,
        accentColor: AppColors.accent,
        barrierColor: Colors.black.withValues(alpha: 0.40),
        barrierDismissible: true,
        builder: (context) => const StatusNotificationDialog(),
      ),

      ExampleScenario(
        title: 'Rotating Alert',
        description: 'Compact alert with smooth rotation animation.',
        animation: DialogAnimation.rotateIn,
        category: 'Transform',
        icon: Icons.notifications_active_rounded,
        accentColor: AppColors.warning,
        barrierColor: Colors.black.withValues(alpha: 0.35),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Fun Achievement',
        description: 'Achievement unlocked with rotation.',
        animation: DialogAnimation.rotateIn,
        category: 'Transform',
        icon: Icons.stars_rounded,
        accentColor: const Color(0xFFFBBF24),
        barrierColor: Colors.black.withValues(alpha: 0.38),
        barrierDismissible: true,
        builder: (context) => const CenterCountdownCard(),
      ),

      ExampleScenario(
        title: 'Dynamic Announcement',
        description: 'Combines rotation and scale for attention-grabbing effect.',
        animation: DialogAnimation.rotateScale,
        category: 'Transform',
        icon: Icons.campaign_rounded,
        accentColor: AppColors.primary,
        barrierColor: Colors.black.withValues(alpha: 0.45),
        barrierBlur: 6,
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Special Offer',
        description: 'Eye-catching entrance for important announcements.',
        animation: DialogAnimation.rotateScale,
        category: 'Transform',
        icon: Icons.star_rounded,
        accentColor: AppColors.accent,
        barrierColor: Colors.black.withValues(alpha: 0.42),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
          widthFactor: 0.5,
          child: RoadmapCard(),
        ),
      ),

      ExampleScenario(
        title: 'Promo Card',
        description: 'Marketing promotion with dynamic entrance.',
        animation: DialogAnimation.rotateScale,
        category: 'Transform',
        icon: Icons.local_offer_rounded,
        accentColor: const Color(0xFFEC4899),
        barrierColor: Colors.black.withValues(alpha: 0.40),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      // ========================================================================
      // BOUNCE ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Success Message',
        description: 'Bouncy entrance perfect for celebratory dialogs.',
        animation: DialogAnimation.bounceIn,
        category: 'Transform',
        icon: Icons.check_circle_rounded,
        accentColor: AppColors.success,
        barrierColor: Colors.black.withValues(alpha: 0.38),
        barrierDismissible: true,
        builder: (context) => const StatusNotificationDialog(),
      ),

      ExampleScenario(
        title: 'Achievement Badge',
        description: 'Playful bounce animation for positive feedback.',
        animation: DialogAnimation.bounceIn,
        category: 'Transform',
        icon: Icons.emoji_events_rounded,
        accentColor: AppColors.accent,
        barrierColor: Colors.black.withValues(alpha: 0.40),
        barrierDismissible: true,
        builder: (context) => const CenterCountdownCard(),
      ),

      ExampleScenario(
        title: 'Level Up',
        description: 'Game-like level up notification.',
        animation: DialogAnimation.bounceIn,
        category: 'Transform',
        icon: Icons.trending_up_rounded,
        accentColor: const Color(0xFF10B981),
        barrierColor: Colors.black.withValues(alpha: 0.42),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Springy Bottom Sheet',
        description: 'Bottom sheet with lively bounce effect.',
        animation: DialogAnimation.bounceSlidBottom,
        category: 'Transform',
        icon: Icons.sports_basketball_rounded,
        accentColor: AppColors.primary,
        barrierColor: Colors.black.withValues(alpha: 0.35),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      ExampleScenario(
        title: 'Action Menu',
        description: 'Energetic slide-up with bounce personality.',
        animation: DialogAnimation.bounceSlidBottom,
        category: 'Transform',
        icon: Icons.menu_rounded,
        accentColor: AppColors.info,
        barrierColor: Colors.black.withValues(alpha: 0.32),
        barrierDismissible: true,
        builder: (context) => const TimeOffDetailsDialog(
          alignment: Alignment.bottomCenter,
          widthFactor: 0.6,
        ),
      ),

      ExampleScenario(
        title: 'Quick Actions',
        description: 'Bouncy action sheet for quick selections.',
        animation: DialogAnimation.bounceSlidBottom,
        category: 'Transform',
        icon: Icons.flash_on_rounded,
        accentColor: const Color(0xFFFBBF24),
        barrierColor: Colors.black.withValues(alpha: 0.30),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      // ========================================================================
      // ELASTIC ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Game-Like Dialog',
        description: 'Elastic overshoot for interactive, playful UIs.',
        animation: DialogAnimation.elasticIn,
        category: 'Transform',
        icon: Icons.videogame_asset_rounded,
        accentColor: const Color(0xFF8B5CF6),
        barrierColor: Colors.black.withValues(alpha: 0.42),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Interactive Card',
        description: 'Spring-like entrance with organic feel.',
        animation: DialogAnimation.elasticIn,
        category: 'Transform',
        icon: Icons.touch_app_rounded,
        accentColor: AppColors.accent,
        barrierColor: Colors.black.withValues(alpha: 0.38),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
          widthFactor: 0.5,
          child: CenterReminderCard(),
        ),
      ),

      ExampleScenario(
        title: 'Reward Popup',
        description: 'Reward notification with elastic bounce.',
        animation: DialogAnimation.elasticIn,
        category: 'Transform',
        icon: Icons.card_giftcard_rounded,
        accentColor: const Color(0xFFEC4899),
        barrierColor: Colors.black.withValues(alpha: 0.40),
        barrierDismissible: true,
        builder: (context) => const StatusNotificationDialog(),
      ),

      ExampleScenario(
        title: 'Modern Bottom Sheet',
        description: 'Smooth slide with elastic overshoot at the end.',
        animation: DialogAnimation.elasticSlideBottom,
        category: 'Transform',
        icon: Icons.settings_ethernet_rounded,
        accentColor: AppColors.info,
        barrierColor: Colors.black.withValues(alpha: 0.35),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      ExampleScenario(
        title: 'Elastic Action Sheet',
        description: 'Bottom sheet with springy, modern feel.',
        animation: DialogAnimation.elasticSlideBottom,
        category: 'Transform',
        icon: Icons.list_rounded,
        accentColor: AppColors.primary,
        barrierColor: Colors.black.withValues(alpha: 0.33),
        barrierDismissible: true,
        builder: (context) => const TimeOffDetailsDialog(
          alignment: Alignment.bottomCenter,
        ),
      ),

      ExampleScenario(
        title: 'Sort Options',
        description: 'Sort selector with elastic slide.',
        animation: DialogAnimation.elasticSlideBottom,
        category: 'Transform',
        icon: Icons.sort_rounded,
        accentColor: AppColors.success,
        barrierColor: Colors.black.withValues(alpha: 0.30),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      // ========================================================================
      // EXPAND ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Dropdown Menu',
        description: 'Unfolds vertically from center like a dropdown.',
        animation: DialogAnimation.expandVertical,
        category: 'Transform',
        icon: Icons.expand_more_rounded,
        accentColor: AppColors.primary,
        barrierColor: Colors.black.withValues(alpha: 0.30),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
          widthFactor: 0.5,
          child: RoadmapCard(),
        ),
      ),

      ExampleScenario(
        title: 'Expandable Panel',
        description: 'Vertical expansion effect for collapsible content.',
        animation: DialogAnimation.expandVertical,
        category: 'Transform',
        icon: Icons.unfold_more_rounded,
        accentColor: AppColors.success,
        barrierColor: Colors.black.withValues(alpha: 0.28),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Accordion Item',
        description: 'Accordion-style vertical expansion.',
        animation: DialogAnimation.expandVertical,
        category: 'Transform',
        icon: Icons.view_headline_rounded,
        accentColor: AppColors.info,
        barrierColor: Colors.black.withValues(alpha: 0.25),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
          widthFactor: 0.6,
          child: CenterReminderCard(),
        ),
      ),

      ExampleScenario(
        title: 'Side Panel Reveal',
        description: 'Stretches horizontally from center.',
        animation: DialogAnimation.expandHorizontal,
        category: 'Transform',
        icon: Icons.unfold_more_rounded,
        accentColor: AppColors.info,
        barrierColor: Colors.black.withValues(alpha: 0.30),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
          widthFactor: 0.6,
          child: FilterPanel(),
        ),
      ),

      ExampleScenario(
        title: 'Horizontal Menu',
        description: 'Expands width for horizontal navigation.',
        animation: DialogAnimation.expandHorizontal,
        category: 'Transform',
        icon: Icons.menu_open_rounded,
        accentColor: AppColors.accent,
        barrierColor: Colors.black.withValues(alpha: 0.28),
        barrierDismissible: true,
        builder: (context) => const CenterReminderCard(),
      ),

      ExampleScenario(
        title: 'Toolbar Expand',
        description: 'Horizontal toolbar expansion.',
        animation: DialogAnimation.expandHorizontal,
        category: 'Transform',
        icon: Icons.build_rounded,
        accentColor: const Color(0xFF8B5CF6),
        barrierColor: Colors.black.withValues(alpha: 0.26),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
          widthFactor: 0.5,
          child: FilterPanel(),
        ),
      ),

      ExampleScenario(
        title: 'Centered Modal',
        description: 'Uniform expansion from center in all directions.',
        animation: DialogAnimation.expandCenter,
        category: 'Transform',
        icon: Icons.zoom_out_map_rounded,
        accentColor: AppColors.primary,
        barrierColor: Colors.black.withValues(alpha: 0.35),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Image Overlay',
        description: 'Smooth expansion for image viewers and overlays.',
        animation: DialogAnimation.expandCenter,
        category: 'Transform',
        icon: Icons.photo_library_rounded,
        accentColor: const Color(0xFF14B8A6),
        barrierColor: Colors.black.withValues(alpha: 0.40),
        barrierBlur: 5,
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
          widthFactor: 0.55,
          child: RoadmapCard(),
        ),
      ),

      ExampleScenario(
        title: 'Zoom Modal',
        description: 'Content zooming from center point.',
        animation: DialogAnimation.expandCenter,
        category: 'Transform',
        icon: Icons.fullscreen_rounded,
        accentColor: AppColors.accent,
        barrierColor: Colors.black.withValues(alpha: 0.38),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      // ========================================================================
      // FLIP ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Card Flip',
        description: 'Flips around horizontal axis like a card reveal.',
        animation: DialogAnimation.flipHorizontal,
        category: 'Transform',
        icon: Icons.flip_rounded,
        accentColor: AppColors.accent,
        barrierColor: Colors.black.withValues(alpha: 0.38),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Info Reveal',
        description: 'Top-bottom flip for revealing information.',
        animation: DialogAnimation.flipHorizontal,
        category: 'Transform',
        icon: Icons.info_rounded,
        accentColor: AppColors.info,
        barrierColor: Colors.black.withValues(alpha: 0.35),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
          widthFactor: 0.5,
          child: CenterReminderCard(),
        ),
      ),

      ExampleScenario(
        title: 'Flip Counter',
        description: 'Counter flip animation effect.',
        animation: DialogAnimation.flipHorizontal,
        category: 'Transform',
        icon: Icons.timer_rounded,
        accentColor: const Color(0xFF8B5CF6),
        barrierColor: Colors.black.withValues(alpha: 0.32),
        barrierDismissible: true,
        builder: (context) => const CenterCountdownCard(),
      ),

      ExampleScenario(
        title: 'Page Turn',
        description: 'Flips around vertical axis like turning a page.',
        animation: DialogAnimation.flipVertical,
        category: 'Transform',
        icon: Icons.flip_rounded,
        accentColor: const Color(0xFFEC4899),
        barrierColor: Colors.black.withValues(alpha: 0.40),
        barrierDismissible: true,
        builder: (context) => const QuickApprovalDialog(),
      ),

      ExampleScenario(
        title: 'Card Reveal',
        description: 'Left-right flip for card transitions.',
        animation: DialogAnimation.flipVertical,
        category: 'Transform',
        icon: Icons.style_rounded,
        accentColor: AppColors.success,
        barrierColor: Colors.black.withValues(alpha: 0.35),
        barrierDismissible: true,
        builder: (context) => const StatusNotificationDialog(),
      ),

      ExampleScenario(
        title: 'Book Page',
        description: 'Book page turn effect.',
        animation: DialogAnimation.flipVertical,
        category: 'Transform',
        icon: Icons.menu_book_rounded,
        accentColor: const Color(0xFF14B8A6),
        barrierColor: Colors.black.withValues(alpha: 0.38),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
          widthFactor: 0.5,
          child: RoadmapCard(),
        ),
      ),

      // ========================================================================
      // COMBINED ANIMATIONS
      // ========================================================================

      ExampleScenario(
        title: 'Modern Action Sheet',
        description: 'Slides up with rotation for dynamic mobile UI.',
        animation: DialogAnimation.slideRotateBottom,
        category: 'Transform',
        icon: Icons.phonelink_rounded,
        accentColor: AppColors.primary,
        barrierColor: Colors.black.withValues(alpha: 0.35),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      ExampleScenario(
        title: 'Dynamic Bottom Dialog',
        description: 'Combines upward slide with subtle rotation.',
        animation: DialogAnimation.slideRotateBottom,
        category: 'Transform',
        icon: Icons.auto_awesome_rounded,
        accentColor: AppColors.accent,
        barrierColor: Colors.black.withValues(alpha: 0.33),
        barrierDismissible: true,
        builder: (context) => const TimeOffDetailsDialog(
          alignment: Alignment.bottomCenter,
          widthFactor: 0.6,
        ),
      ),

      ExampleScenario(
        title: 'Mobile Menu',
        description: 'Mobile-optimized menu with rotation.',
        animation: DialogAnimation.slideRotateBottom,
        category: 'Transform',
        icon: Icons.smartphone_rounded,
        accentColor: AppColors.info,
        barrierColor: Colors.black.withValues(alpha: 0.30),
        barrierDismissible: true,
        builder: (context) => const BottomQuickAssignSheet(),
      ),

      ExampleScenario(
        title: 'Dynamic Notification',
        description: 'Slides down with rotation for top banners.',
        animation: DialogAnimation.slideRotateTop,
        category: 'Transform',
        icon: Icons.notifications_rounded,
        accentColor: AppColors.warning,
        barrierColor: Colors.black.withValues(alpha: 0.28),
        barrierDismissible: true,
        builder: (context) => const TopAnnouncementBanner(widthFactor: 0.7),
      ),

      ExampleScenario(
        title: 'Alert Banner',
        description: 'Top banner with dynamic rotation effect.',
        animation: DialogAnimation.slideRotateTop,
        category: 'Transform',
        icon: Icons.priority_high_rounded,
        accentColor: AppColors.error,
        barrierColor: Colors.black.withValues(alpha: 0.30),
        barrierDismissible: true,
        builder: (context) => const TopMiniAlert(),
      ),

      ExampleScenario(
        title: 'News Alert',
        description: 'Breaking news banner with rotation.',
        animation: DialogAnimation.slideRotateTop,
        category: 'Transform',
        icon: Icons.newspaper_rounded,
        accentColor: const Color(0xFFEF4444),
        barrierColor: Colors.black.withValues(alpha: 0.26),
        barrierDismissible: true,
        builder: (context) => const TopAnnouncementBanner(widthFactor: 0.65),
      ),

      ExampleScenario(
        title: 'Navigation Panel',
        description: 'Professional slide from start with scale effect.',
        animation: DialogAnimation.slideScaleStart,
        category: 'Transform',
        icon: Icons.dashboard_rounded,
        accentColor: AppColors.primary,
        barrierColor: Colors.black.withValues(alpha: 0.28),
        barrierDismissible: true,
        constraints: const BoxConstraints(maxWidth: 720),
        builder: (context) =>
            const AddTimeOffDialog(alignment: Alignment.centerLeft),
      ),

      ExampleScenario(
        title: 'Side Menu',
        description: 'Smooth entrance for navigation menus.',
        animation: DialogAnimation.slideScaleStart,
        category: 'Transform',
        icon: Icons.menu_book_rounded,
        accentColor: AppColors.info,
        barrierColor: Colors.black.withValues(alpha: 0.25),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
          widthFactor: 0.5,
          alignment: AlignmentDirectional.centerStart,
          child: FilterPanel(),
        ),
      ),

      ExampleScenario(
        title: 'Slide Filters',
        description: 'Filter panel sliding with scale.',
        animation: DialogAnimation.slideScaleStart,
        category: 'Transform',
        icon: Icons.filter_alt_rounded,
        accentColor: AppColors.accent,
        barrierColor: Colors.black.withValues(alpha: 0.24),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
          widthFactor: 0.4,
          alignment: AlignmentDirectional.centerStart,
          child: FilterPanel(),
        ),
      ),

      ExampleScenario(
        title: 'Settings Panel',
        description: 'Professional slide from end with scale.',
        animation: DialogAnimation.slideScaleEnd,
        category: 'Transform',
        icon: Icons.settings_rounded,
        accentColor: AppColors.accent,
        barrierColor: Colors.black.withValues(alpha: 0.28),
        barrierDismissible: true,
        constraints: const BoxConstraints(maxWidth: 720),
        builder: (context) =>
            const AddTimeOffDialog(alignment: Alignment.centerRight),
      ),

      ExampleScenario(
        title: 'Detail View',
        description: 'Smooth entrance for detail panels.',
        animation: DialogAnimation.slideScaleEnd,
        category: 'Transform',
        icon: Icons.article_rounded,
        accentColor: AppColors.success,
        barrierColor: Colors.black.withValues(alpha: 0.25),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
          widthFactor: 0.5,
          alignment: AlignmentDirectional.centerEnd,
          child: AnalyticsPanel(),
        ),
      ),

      ExampleScenario(
        title: 'User Profile',
        description: 'Profile sidebar with scale entrance.',
        animation: DialogAnimation.slideScaleEnd,
        category: 'Transform',
        icon: Icons.account_circle_rounded,
        accentColor: const Color(0xFF8B5CF6),
        barrierColor: Colors.black.withValues(alpha: 0.26),
        barrierDismissible: true,
        builder: (context) => const FractionallySizedBox(
          widthFactor: 0.45,
          alignment: AlignmentDirectional.centerEnd,
          child: AnalyticsPanel(),
        ),
      ),
    ];
  }
}
