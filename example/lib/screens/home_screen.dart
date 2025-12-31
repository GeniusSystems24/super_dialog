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
      animations: [DialogAnimation.centerScale, DialogAnimation.centerFade],
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
