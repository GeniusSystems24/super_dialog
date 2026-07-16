import 'package:flutter/material.dart';

import '../../models/animation_category.dart';
import '../../models/example_scenario.dart';
import '../../theme/app_layout.dart';
import '../../theme/app_theme.dart';
import '../../widgets/example_card.dart';
import '../../widgets/showcase_header.dart';

/// Responsive animation-gallery view shared by slide, reveal, and transform.
class AnimationListView extends StatelessWidget {
  const AnimationListView({
    super.key,
    required this.category,
    required this.scenarios,
    required this.onScenarioTap,
  });

  final AnimationCategory category;
  final List<ExampleScenario> scenarios;
  final void Function(ExampleScenario scenario) onScenarioTap;

  @override
  Widget build(BuildContext context) {
    final filteredScenarios = scenarios
        .where((scenario) => category.animations.contains(scenario.animation))
        .toList();
    final description = switch (category.title) {
      'Slide' =>
        'Side panels and drawers for dense forms, audit trails, filters, analytics, and operational detail.',
      'Reveal' =>
        'Top banners and bottom sheets for timely alerts, quick assignment, status summaries, and focused actions.',
      _ =>
        'Centered transitions for confirmations, approvals, protected actions, status feedback, and compact review surfaces.',
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        final pagePadding = AppLayout.pagePaddingFor(constraints.maxWidth);
        final contentWidth = constraints.maxWidth - pagePadding.horizontal;
        final columns = AppLayout.gridColumnsFor(
          contentWidth,
          minTileWidth: 340,
          maxColumns: 3,
        );
        final compact = constraints.maxWidth < AppLayout.compactBreakpoint;

        return CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                pagePadding.left,
                pagePadding.top,
                pagePadding.right,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1180),
                    child: ShowcaseHeader(
                      eyebrow: 'Motion collection',
                      title: '${category.title} dialog patterns',
                      description: description,
                      icon: category.icon,
                      badges: <Widget>[
                        ShowcaseBadge(
                          label: '${filteredScenarios.length} examples',
                          icon: Icons.view_list_outlined,
                        ),
                        ShowcaseBadge(
                          label: '${category.animations.length} transitions',
                          icon: Icons.animation_rounded,
                        ),
                        const ShowcaseBadge(
                          label: 'Light · Dark · RTL',
                          icon: Icons.language_rounded,
                          color: AppColors.success,
                        ),
                      ],
                      trailing: FilledButton.icon(
                        onPressed: filteredScenarios.isEmpty
                            ? null
                            : () => onScenarioTap(filteredScenarios.first),
                        icon: const Icon(Icons.play_arrow_rounded, size: 18),
                        label: const Text('Preview first'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                pagePadding.left,
                AppSpacing.lg,
                pagePadding.right,
                pagePadding.bottom,
              ),
              sliver: SliverLayoutBuilder(
                builder: (context, sliverConstraints) {
                  final available = sliverConstraints.crossAxisExtent;
                  final resolvedColumns = AppLayout.gridColumnsFor(
                    available,
                    minTileWidth: 340,
                    maxColumns: columns,
                  );
                  return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final scenario = filteredScenarios[index];
                        return ExampleCard(
                          compact: true,
                          scenario: scenario,
                          onTap: () => onScenarioTap(scenario),
                        );
                      },
                      childCount: filteredScenarios.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: resolvedColumns,
                      mainAxisSpacing: AppSpacing.md,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisExtent: compact ? 286 : 264,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
