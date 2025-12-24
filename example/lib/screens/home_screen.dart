// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';
import '../theme/app_theme.dart';
import '../widgets/example_card.dart';
import '../widgets/dialogs/dialogs.dart';
import '../models/example_scenario.dart';

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

  // Categories now include Positioned
  final List<_TabCategory> _tabs = [
    _TabCategory(title: 'Slide', icon: Icons.swap_horiz_rounded),
    _TabCategory(title: 'Reveal', icon: Icons.swap_vert_rounded),
    _TabCategory(title: 'Transform', icon: Icons.blur_on_rounded),
    _TabCategory(title: 'Positioned', icon: Icons.grid_3x3_rounded),
  ];

  final List<AnimationCategory> _animationCategories = [
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

  // All positions for Positioned tab
  static const List<DialogPosition> allPositions = [
    DialogPosition.topStart,
    DialogPosition.topCenter,
    DialogPosition.topEnd,
    DialogPosition.centerStart,
    DialogPosition.center,
    DialogPosition.centerEnd,
    DialogPosition.bottomStart,
    DialogPosition.bottomCenter,
    DialogPosition.bottomEnd,
  ];

  // All transition types
  static const List<PositionedTransitionType> allTransitionTypes = [
    PositionedTransitionType.slide,
    PositionedTransitionType.slideFade,
    PositionedTransitionType.slideScale,
    PositionedTransitionType.slideFadeScale,
    PositionedTransitionType.fade,
    PositionedTransitionType.scale,
    PositionedTransitionType.scaleFade,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _initScenarios();
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

  List<ExampleScenario> _getScenariosForCategory(AnimationCategory category) {
    return _scenarios
        .where((s) => category.animations.contains(s.animation))
        .toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ===========================================================================
  // POSITIONED TAB HELPERS
  // ===========================================================================
  Color _getPositionColor(DialogPosition position) {
    switch (position) {
      case DialogPosition.topStart:
        return AppColors.error;
      case DialogPosition.topCenter:
        return AppColors.warning;
      case DialogPosition.topEnd:
        return AppColors.success;
      case DialogPosition.centerStart:
        return AppColors.info;
      case DialogPosition.center:
        return AppColors.primary;
      case DialogPosition.centerEnd:
        return AppColors.accent;
      case DialogPosition.bottomStart:
        return const Color(0xFF8B5CF6);
      case DialogPosition.bottomCenter:
        return const Color(0xFFEC4899);
      case DialogPosition.bottomEnd:
        return const Color(0xFF14B8A6);
      case DialogPosition.offScreen:
        return AppColors.lightTextSecondary;
    }
  }

  IconData _getTransitionIcon(PositionedTransitionType type) {
    switch (type) {
      case PositionedTransitionType.slide:
        return Icons.arrow_forward_rounded;
      case PositionedTransitionType.slideFade:
        return Icons.blur_linear_rounded;
      case PositionedTransitionType.slideScale:
        return Icons.zoom_in_rounded;
      case PositionedTransitionType.slideFadeScale:
        return Icons.auto_awesome_rounded;
      case PositionedTransitionType.fade:
        return Icons.gradient_rounded;
      case PositionedTransitionType.scale:
        return Icons.zoom_out_map_rounded;
      case PositionedTransitionType.scaleFade:
        return Icons.filter_vintage_rounded;
    }
  }

  String _getTransitionLabel(PositionedTransitionType type) {
    switch (type) {
      case PositionedTransitionType.slide:
        return 'Slide';
      case PositionedTransitionType.slideFade:
        return 'Slide + Fade';
      case PositionedTransitionType.slideScale:
        return 'Slide + Scale';
      case PositionedTransitionType.slideFadeScale:
        return 'Slide + Fade + Scale';
      case PositionedTransitionType.fade:
        return 'Fade Only';
      case PositionedTransitionType.scale:
        return 'Scale Only';
      case PositionedTransitionType.scaleFade:
        return 'Scale + Fade';
    }
  }

  /// Generates code snippet for positioned dialog.
  String _generatePositionedCode({
    required DialogPosition startPosition,
    required DialogPosition endPosition,
    PositionedTransitionType transitionType =
        PositionedTransitionType.slideFade,
  }) {
    final startPosName = startPosition.toString().split('.').last;
    final endPosName = endPosition.toString().split('.').last;
    final transTypeName = transitionType.toString().split('.').last;

    return '''SuperDialog.showPositionedDialog<void>(
  context,
  (context) => const MyDialog(),
  startPosition: DialogPosition.$startPosName,
  endPosition: DialogPosition.$endPosName,
  transitionType: PositionedTransitionType.$transTypeName,
  barrierDismissible: true,
);''';
  }

  /// Shows the code viewer dialog for positioned dialogs.
  void _showPositionedCodeDialog({
    required String title,
    required DialogPosition startPosition,
    required DialogPosition endPosition,
    PositionedTransitionType transitionType =
        PositionedTransitionType.slideFade,
    Color? accentColor,
  }) {
    final code = _generatePositionedCode(
      startPosition: startPosition,
      endPosition: endPosition,
      transitionType: transitionType,
    );
    SuperDialog.showAnimatedDialog<void>(
      context,
      (context) => CodeViewerDialog(
        title: title,
        code: code,
        accentColor: accentColor ?? AppColors.primary,
      ),
      animation: DialogAnimation.centerScale,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      barrierBlur: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 210,
            floating: false,
            pinned: true,
            backgroundColor: isDark
                ? AppColors.darkSurface
                : AppColors.lightSurface,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [AppColors.darkSurface, AppColors.darkBackground]
                        : [
                            AppColors.primary.withValues(alpha: 0.1),
                            AppColors.lightBackground,
                          ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: AppColors.primaryGradient,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.animation_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: widget.onThemeToggle,
                              icon: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: Icon(
                                  widget.isDarkMode
                                      ? Icons.light_mode_rounded
                                      : Icons.dark_mode_rounded,
                                  key: ValueKey(widget.isDarkMode),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          'Super Dialog',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.darkText
                                : AppColors.lightText,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Beautiful animated dialogs for Flutter',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Tab Bar
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              child: Container(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                child: TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                  indicatorColor: AppColors.primary,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  labelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
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
              ),
            ),
          ),

          // Content
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Slide Tab
                _buildAnimationList(_animationCategories[0]),
                // Reveal Tab
                _buildAnimationList(_animationCategories[1]),
                // Transform Tab
                _buildAnimationList(_animationCategories[2]),
                // Positioned Tab
                _buildPositionedTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimationList(AnimationCategory category) {
    final scenarios = _getScenariosForCategory(category);
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: scenarios.length,
      itemBuilder: (context, index) {
        final scenario = scenarios[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ExampleCard(
            scenario: scenario,
            onTap: () => _openScenario(scenario),
          ),
        );
      },
    );
  }

  // ===========================================================================
  // POSITIONED TAB
  // ===========================================================================
  Widget _buildPositionedTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Position Grid Section
        _buildSectionHeader(
          icon: Icons.grid_3x3_rounded,
          title: 'Position Grid (9 positions)',
          subtitle: 'Tap any position to show dialog there',
        ),
        const SizedBox(height: 16),
        _buildPositionGrid(),
        const SizedBox(height: 28),

        // Transition Types Section
        _buildSectionHeader(
          icon: Icons.animation_rounded,
          title: 'Transition Types (7 types)',
          subtitle: 'Different animation combinations',
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: allTransitionTypes.map((type) {
            return _buildTransitionChip(type);
          }).toList(),
        ),
        const SizedBox(height: 28),

        // Combinations Grid
        _buildSectionHeader(
          icon: Icons.apps_rounded,
          title: 'All Combinations (63 total)',
          subtitle: '9 positions × 7 transitions',
        ),
        const SizedBox(height: 16),
        ...allTransitionTypes.map((type) {
          return _buildCombinationSection(type);
        }),
      ],
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: AppColors.primaryGradient),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: secondaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPositionGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.2,
      ),
      itemCount: allPositions.length,
      itemBuilder: (context, index) {
        final position = allPositions[index];
        return _buildPositionButton(position);
      },
    );
  }

  Widget _buildPositionButton(DialogPosition position) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final secondaryColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final color = _getPositionColor(position);

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            // Main content - tappable area
            Expanded(
              child: InkWell(
                onTap: () {
                  SuperDialog.showPositionedDialog<void>(
                    context,
                    (context) => PositionedInfoCard(
                      position: position.displayName,
                      accentColor: color,
                    ),
                    startPosition: DialogPosition.offScreen,
                    endPosition: position,
                    transitionType: PositionedTransitionType.slideFade,
                    barrierDismissible: true,
                    barrierColor: Colors.black.withValues(alpha: 0.4),
                  );
                },
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: color.withValues(alpha: 0.5),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        position.displayName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.lightText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Code button
            InkWell(
              onTap: () => _showPositionedCodeDialog(
                title: position.displayName,
                startPosition: DialogPosition.offScreen,
                endPosition: position,
                transitionType: PositionedTransitionType.slideFade,
                accentColor: color,
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(14),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(14),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.code_rounded, size: 12, color: secondaryColor),
                    const SizedBox(width: 3),
                    Text(
                      'Code',
                      style: TextStyle(fontSize: 8, color: secondaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransitionChip(PositionedTransitionType type) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Main content - tappable
            InkWell(
              onTap: () {
                SuperDialog.showPositionedDialog<void>(
                  context,
                  (context) =>
                      const PositionedCornerDialog(fromCorner: 'Bottom'),
                  startPosition: DialogPosition.bottomCenter,
                  endPosition: DialogPosition.center,
                  transitionType: type,
                  barrierDismissible: true,
                  barrierColor: Colors.black.withValues(alpha: 0.5),
                );
              },
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getTransitionIcon(type),
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _getTransitionLabel(type),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Code button
            Container(
              width: 1,
              height: 24,
              color: AppColors.primary.withValues(alpha: 0.15),
            ),
            InkWell(
              onTap: () => _showPositionedCodeDialog(
                title: _getTransitionLabel(type),
                startPosition: DialogPosition.bottomCenter,
                endPosition: DialogPosition.center,
                transitionType: type,
                accentColor: AppColors.primary,
              ),
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Icon(
                  Icons.code_rounded,
                  size: 16,
                  color: secondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCombinationSection(PositionedTransitionType type) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getTransitionIcon(type),
                size: 14,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
              Text(
                _getTransitionLabel(type),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),

        // 3x3 Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 1.2,
          ),
          itemCount: allPositions.length,
          itemBuilder: (context, index) {
            final position = allPositions[index];
            final color = _getPositionColor(position);

            return Material(
              color: cardColor,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    // Main area
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          SuperDialog.showPositionedDialog<void>(
                            context,
                            (context) => PositionedInfoCard(
                              position:
                                  '${position.displayName}\n${_getTransitionLabel(type)}',
                              accentColor: color,
                            ),
                            startPosition: DialogPosition.offScreen,
                            endPosition: position,
                            transitionType: type,
                            barrierDismissible: true,
                            barrierColor: Colors.black.withValues(alpha: 0.4),
                          );
                        },
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                position.displayName.replaceAll(' ', '\n'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryColor,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Code button
                    InkWell(
                      onTap: () => _showPositionedCodeDialog(
                        title:
                            '${position.displayName} - ${_getTransitionLabel(type)}',
                        startPosition: DialogPosition.offScreen,
                        endPosition: position,
                        transitionType: type,
                        accentColor: color,
                      ),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(8),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.08),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(8),
                          ),
                        ),
                        child: Icon(
                          Icons.code_rounded,
                          size: 10,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}

// =============================================================================
// HELPER CLASSES
// =============================================================================
class _TabCategory {
  final String title;
  final IconData icon;

  _TabCategory({required this.title, required this.icon});
}

class AnimationCategory {
  final String title;
  final IconData icon;
  final List<DialogAnimation> animations;

  AnimationCategory({
    required this.title,
    required this.icon,
    required this.animations,
  });
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  const _TabBarDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) =>
      child != oldDelegate.child;
}
