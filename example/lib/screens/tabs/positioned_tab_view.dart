import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';
import '../../models/positioned_constants.dart';
import '../../theme/app_theme.dart';
import '../../widgets/positioned_tab/positioned_tab.dart';
import '../../widgets/dialogs/dialogs.dart';

/// Premium positioned tab with semantic visual representations.
class PositionedTabView extends StatefulWidget {
  const PositionedTabView({super.key});

  @override
  State<PositionedTabView> createState() => _PositionedTabViewState();
}

class _PositionedTabViewState extends State<PositionedTabView> {
  late ScrollController _scrollController;
  double _scrollProgress = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        final maxScroll = _scrollController.position.maxScrollExtent;
        if (maxScroll > 0) {
          setState(() {
            _scrollProgress = (_scrollController.offset / maxScroll).clamp(
              0.0,
              1.0,
            );
          });
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // Subtle background pattern
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,
            ),
          ),
        ),

        // Main content
        CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Overview Cards Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: _buildOverviewSection(isDark),
              ),
            ),

            // Position Grid Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                child: Column(
                  children: [
                    const SectionHeader(
                      icon: Icons.grid_view_rounded,
                      title: 'Position Grid',
                      subtitle:
                          'Each card shows where the dialog will appear on screen',
                    ),
                    const SizedBox(height: 20),
                    PositionGrid(
                      onCodeTap: (position) => _showPositionedCodeDialog(
                        context: context,
                        title: position.displayName,
                        startPosition: DialogPosition.offScreen,
                        endPosition: position,
                        transitionType: PositionedTransitionType.slideFade,
                        accentColor: PositionedConstants.getPositionColor(
                          position,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Transition Types Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                child: Column(
                  children: [
                    const SectionHeader(
                      icon: Icons.animation_rounded,
                      title: 'Transition Animations',
                      subtitle:
                          'Hover over each chip to preview the animation effect',
                    ),
                    const SizedBox(height: 20),
                    _buildTransitionChips(context),
                  ],
                ),
              ),
            ),

            // All Combinations Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                child: const SectionHeader(
                  icon: Icons.layers_rounded,
                  title: 'Combined Effects',
                  subtitle:
                      'Expand each section to see all position + transition combinations',
                ),
              ),
            ),

            // Combination sections (expandable)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final type = PositionedConstants.allTransitionTypes[index];
                  return CombinationSection(
                    type: type,
                    onCodeTap:
                        ({
                          required DialogPosition position,
                          required PositionedTransitionType type,
                        }) => _showPositionedCodeDialog(
                          context: context,
                          title:
                              '${position.displayName} - ${PositionedConstants.getTransitionLabel(type)}',
                          startPosition: DialogPosition.offScreen,
                          endPosition: position,
                          transitionType: type,
                          accentColor: PositionedConstants.getPositionColor(
                            position,
                          ),
                        ),
                  );
                }, childCount: PositionedConstants.allTransitionTypes.length),
              ),
            ),
          ],
        ),

        // Scroll progress indicator
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: IgnorePointer(
            child: AnimatedOpacity(
              opacity: _scrollProgress > 0.01 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 150),
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                    stops: [_scrollProgress, _scrollProgress],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the overview section with visual stat cards.
  Widget _buildOverviewSection(bool isDark) {
    return Row(
      children: [
        // Positions card - shows mini 3x3 grid
        Expanded(
          child: _OverviewCard(
            title: 'Positions',
            value: '9',
            color: AppColors.primary,
            isDark: isDark,
            child: _buildMiniPositionGrid(isDark),
          ),
        ),
        const SizedBox(width: 12),
        // Transitions card - shows animation icons
        Expanded(
          child: _OverviewCard(
            title: 'Transitions',
            value: '7',
            color: AppColors.info,
            isDark: isDark,
            child: _buildMiniTransitionIcons(isDark),
          ),
        ),
        const SizedBox(width: 12),
        // Combinations card - shows equation
        Expanded(
          child: _OverviewCard(
            title: 'Combinations',
            value: '63',
            color: AppColors.success,
            isDark: isDark,
            child: _buildCombinationEquation(isDark),
          ),
        ),
      ],
    );
  }

  /// Builds a mini 3x3 grid representation.
  Widget _buildMiniPositionGrid(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkBackground.withValues(alpha: 0.5)
            : AppColors.lightDivider.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: List.generate(9, (index) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.3 + (index * 0.07)),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      ),
    );
  }

  /// Builds mini transition icons.
  Widget _buildMiniTransitionIcons(bool isDark) {
    final icons = [
      Icons.arrow_forward_rounded,
      Icons.blur_linear_rounded,
      Icons.zoom_in_rounded,
      Icons.gradient_rounded,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: icons.map((icon) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Icon(
            icon,
            size: 12,
            color: AppColors.info.withValues(alpha: 0.7),
          ),
        );
      }).toList(),
    );
  }

  /// Builds the combination equation visual.
  Widget _buildCombinationEquation(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '9',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppColors.primary.withValues(alpha: 0.8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            '×',
            style: TextStyle(
              fontSize: 12,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ),
        Text(
          '7',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppColors.info.withValues(alpha: 0.8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            '=',
            style: TextStyle(
              fontSize: 12,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ),
        Text(
          '63',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppColors.success,
          ),
        ),
      ],
    );
  }

  Widget _buildTransitionChips(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: PositionedConstants.allTransitionTypes.map((type) {
        return TransitionChip(
          type: type,
          onCodeTap: () => _showPositionedCodeDialog(
            context: context,
            title: PositionedConstants.getTransitionLabel(type),
            startPosition: DialogPosition.bottomCenter,
            endPosition: DialogPosition.center,
            transitionType: type,
            accentColor: AppColors.primary,
          ),
        );
      }).toList(),
    );
  }

  void _showPositionedCodeDialog({
    required BuildContext context,
    required String title,
    required DialogPosition startPosition,
    required DialogPosition endPosition,
    PositionedTransitionType transitionType =
        PositionedTransitionType.slideFade,
    Color? accentColor,
  }) {
    final code = PositionedConstants.generatePositionedCode(
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
      barrierBlur: 8,
    );
  }
}

/// Overview card with visual representation.
class _OverviewCard extends StatelessWidget {
  const _OverviewCard({
    required this.title,
    required this.value,
    required this.color,
    required this.isDark,
    required this.child,
  });

  final String title;
  final String value;
  final Color color;
  final bool isDark;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkCard.withValues(alpha: 0.6)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? AppColors.darkBorder.withValues(alpha: 0.5)
              : AppColors.lightBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Visual representation
          SizedBox(height: 32, child: child),
          const SizedBox(height: 10),
          // Value
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          // Label
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
