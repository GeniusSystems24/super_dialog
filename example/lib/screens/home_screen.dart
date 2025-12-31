// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/dialogs/dialogs.dart';
import 'tabs/tabs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late List<ExampleScenario> _scenarios;

  // Tab categories
  final List<TabCategory> _tabs = const [
    TabCategory(title: 'Slide', icon: Icons.swap_horiz_rounded),
    TabCategory(title: 'Reveal', icon: Icons.swap_vert_rounded),
    TabCategory(title: 'Transform', icon: Icons.blur_on_rounded),
    TabCategory(title: 'Positioned', icon: Icons.grid_3x3_rounded),
  ];

  // Animation categories for the first 3 tabs
  final List<AnimationCategory> _animationCategories = const [
    AnimationCategory(
      title: 'Slide',
      icon: Icons.swap_horiz_rounded,
      animations: [DialogAnimation.startToEnd, DialogAnimation.endToStart],
    ),
    AnimationCategory(
      title: 'Reveal',
      icon: Icons.swap_vert_rounded,
      animations: [DialogAnimation.topToBottom, DialogAnimation.bottomToTop],
    ),
    AnimationCategory(
      title: 'Transform',
      icon: Icons.blur_on_rounded,
      animations: [
        DialogAnimation.centerScale,
        DialogAnimation.centerFade,
        DialogAnimation.rotateIn,
        DialogAnimation.rotateScale,
        DialogAnimation.bounceIn,
        DialogAnimation.bounceSlidBottom,
        DialogAnimation.elasticIn,
        DialogAnimation.elasticSlideBottom,
        DialogAnimation.expandVertical,
        DialogAnimation.expandHorizontal,
        DialogAnimation.expandCenter,
        DialogAnimation.flipHorizontal,
        DialogAnimation.flipVertical,
        DialogAnimation.slideRotateBottom,
        DialogAnimation.slideRotateTop,
        DialogAnimation.slideScaleStart,
        DialogAnimation.slideScaleEnd,
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _initScenarios();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initScenarios() {
    _scenarios = [
      // Start -> End
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

      // End -> Start
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

      // Top -> Bottom
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

      // Bottom -> Top
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

      // Center Scale
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

      // Center Fade
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

      // Rotate In
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

      // Rotate Scale
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

      // Bounce In
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

      // Bounce Slide Bottom
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

      // Elastic In
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

      // Elastic Slide Bottom
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

      // Expand Vertical
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

      // Expand Horizontal
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

      // Expand Center
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

      // Flip Horizontal
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

      // Flip Vertical
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

      // Slide Rotate Bottom
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

      // Slide Rotate Top
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

      // Slide Scale Start
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

      // Slide Scale End
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
    ];
  }

  void _openScenario(ExampleScenario scenario) {
    SuperDialog.showAnimatedDialog<void>(
      context,
      scenario.builder,
      config: scenario.config,
      animation: scenario.animation,
      constraints: scenario.constraints,
      barrierDismissible: scenario.barrierDismissible,
      barrierColor: scenario.barrierColor,
      barrierBlur: scenario.barrierBlur,
      onDismissed: scenario.onDismissed == null
          ? null
          : () => scenario.onDismissed!(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: _buildAppBar(isDark),
      body: Column(
        children: [
          _buildTabBar(isDark),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Slide Tab
                AnimationListView(
                  category: _animationCategories[0],
                  scenarios: _scenarios,
                  onScenarioTap: _openScenario,
                ),
                // Reveal Tab
                AnimationListView(
                  category: _animationCategories[1],
                  scenarios: _scenarios,
                  onScenarioTap: _openScenario,
                ),
                // Transform Tab
                AnimationListView(
                  category: _animationCategories[2],
                  scenarios: _scenarios,
                  onScenarioTap: _openScenario,
                ),
                // Positioned Tab
                const PositionedTabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isDark) {
    return AppBar(
      title: const Text(
        'Super Dialog Examples',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      actions: [
        IconButton(
          onPressed: widget.onThemeToggle,
          icon: Icon(
            widget.isDarkMode
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
          ),
          tooltip: 'Toggle theme',
        ),
      ],
      elevation: 0,
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
    );
  }

  Widget _buildTabBar(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.primary,
        unselectedLabelColor: isDark
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        tabs: _tabs
            .map(
              (tab) => Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(tab.icon, size: 18),
                    const SizedBox(width: 6),
                    Text(tab.title),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
