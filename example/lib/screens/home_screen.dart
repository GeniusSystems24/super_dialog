// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../data/scenarios/scenarios.dart';
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
      ...SlideScenarios.getAll(),
      ...RevealScenarios.getAll(),
      ...TransformScenarios.getAll(),
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
