import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

import '../../models/positioned_constants.dart';
import '../../theme/app_layout.dart';
import '../../theme/app_theme.dart';
import '../../widgets/dialogs/dialogs.dart';
import '../../widgets/positioned_tab/positioned_tab.dart';
import '../../widgets/showcase_header.dart';

/// Positioned-transition showcase using the shared GeniusLink visual system.
class PositionedTabView extends StatefulWidget {
  const PositionedTabView({super.key});

  @override
  State<PositionedTabView> createState() => _PositionedTabViewState();
}

class _PositionedTabViewState extends State<PositionedTabView> {
  late final ScrollController _scrollController;
  double _scrollProgress = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_updateProgress);
  }

  void _updateProgress() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final progress = maxScroll <= 0
        ? 0.0
        : (_scrollController.offset / maxScroll).clamp(0.0, 1.0);
    if (progress != _scrollProgress) {
      setState(() => _scrollProgress = progress);
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_updateProgress)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final pageInset = AppLayout.pagePaddingFor(width).left;
    final sectionGap = width < AppLayout.compactBreakpoint
        ? AppSpacing.xl
        : AppSpacing.xxl;
    return Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                pageInset,
                pageInset,
                pageInset,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1120),
                    child: ShowcaseHeader(
                      eyebrow: 'Positioned dialog API',
                      title: 'Context-aware overlays for ERP workspaces',
                      description:
                          'Preview nine destination positions and ten transition types for notifications, inspectors, contextual actions, and anchored process surfaces.',
                      icon: Icons.grid_view_rounded,
                      badges: const <Widget>[
                        ShowcaseBadge(label: '9 positions', icon: Icons.place_outlined),
                        ShowcaseBadge(label: '10 transitions', icon: Icons.animation_rounded),
                        ShowcaseBadge(
                          label: '90 combinations',
                          icon: Icons.account_tree_outlined,
                          color: AppColors.success,
                        ),
                      ],
                      trailing: FilledButton.icon(
                        onPressed: () => SuperDialog.showPositionedDialog<void>(
                          context,
                          (context) => const PositionedInfoCard(
                            position: 'bottom end',
                            accentColor: AppColors.primary,
                          ),
                          startPosition: DialogPosition.offScreen,
                          endPosition: DialogPosition.bottomEnd,
                          transitionType: PositionedTransitionType.slideFade,
                          barrierDismissible: true,
                        ),
                        icon: const Icon(Icons.play_arrow_rounded, size: 18),
                        label: const Text('Run example'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                pageInset,
                AppSpacing.lg,
                pageInset,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1120),
                    child: _OverviewCards(),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                pageInset,
                sectionGap,
                pageInset,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SectionHeader(
                          icon: Icons.grid_view_rounded,
                          title: 'Position grid',
                          subtitle:
                              'Choose the destination that matches the surrounding business context.',
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        PositionGrid(
                          onCodeTap: (position) => _showPositionedCodeDialog(
                            context: context,
                            title: position.displayName,
                            startPosition: DialogPosition.offScreen,
                            endPosition: position,
                            transitionType: PositionedTransitionType.slideFade,
                            accentColor: PositionedConstants.getPositionColor(position),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                pageInset,
                sectionGap,
                pageInset,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SectionHeader(
                          icon: Icons.animation_rounded,
                          title: 'Transition behaviors',
                          subtitle:
                              'Use subtle motion for enterprise workflows and reserve expressive motion for non-blocking feedback.',
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Wrap(
                          spacing: AppSpacing.md,
                          runSpacing: AppSpacing.md,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                pageInset,
                sectionGap,
                pageInset,
                AppSpacing.lg,
              ),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1120),
                    child: const SectionHeader(
                      icon: Icons.layers_outlined,
                      title: 'Combined effects',
                      subtitle:
                          'Expand a transition group to inspect all position combinations and generated code.',
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                pageInset,
                0,
                pageInset,
                sectionGap,
              ),
              sliver: SliverList.builder(
                itemCount: PositionedConstants.allTransitionTypes.length,
                itemBuilder: (context, index) {
                  final type = PositionedConstants.allTransitionTypes[index];
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1120),
                      child: CombinationSection(
                        type: type,
                        onCodeTap: ({
                          required DialogPosition position,
                          required PositionedTransitionType type,
                        }) => _showPositionedCodeDialog(
                          context: context,
                          title:
                              '${position.displayName} · ${PositionedConstants.getTransitionLabel(type)}',
                          startPosition: DialogPosition.offScreen,
                          endPosition: position,
                          transitionType: type,
                          accentColor: PositionedConstants.getPositionColor(position),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: IgnorePointer(
            child: AnimatedOpacity(
              opacity: _scrollProgress > 0.01 ? 1 : 0,
              duration: const Duration(milliseconds: 150),
              child: SizedBox(
                height: 3,
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: FractionallySizedBox(
                    widthFactor: _scrollProgress,
                    child: const ColoredBox(color: AppColors.primary),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showPositionedCodeDialog({
    required BuildContext context,
    required String title,
    required DialogPosition startPosition,
    required DialogPosition endPosition,
    PositionedTransitionType transitionType = PositionedTransitionType.slideFade,
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
      barrierColor: const Color(0x8C000000),
      barrierBlur: 8,
    );
  }
}

class _OverviewCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const cards = <Widget>[
          _OverviewCard(
            label: 'Positions',
            value: '9',
            detail: '3 × 3 viewport grid',
            icon: Icons.grid_3x3_rounded,
            color: AppColors.primary,
          ),
          _OverviewCard(
            label: 'Transitions',
            value: '10',
            detail: 'Slide, fade, scale, rotate',
            icon: Icons.animation_rounded,
            color: AppColors.purple,
          ),
          _OverviewCard(
            label: 'Combinations',
            value: '90',
            detail: 'Generated typed examples',
            icon: Icons.account_tree_outlined,
            color: AppColors.success,
          ),
        ];
        if (constraints.maxWidth < 720) {
          return Column(
            children: cards
                .map(
                  (card) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: card,
                  ),
                )
                .toList(),
          );
        }
        return Row(
          children: List.generate(cards.length, (index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  end: index == cards.length - 1 ? 0 : AppSpacing.md,
                ),
                child: cards[index],
              ),
            );
          }),
        );
      },
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({
    required this.label,
    required this.value,
    required this.detail,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final String detail;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadii.card),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      value,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(label, style: theme.textTheme.titleMedium),
                  ],
                ),
                Text(
                  detail,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
