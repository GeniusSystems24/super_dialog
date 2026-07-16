import 'package:flutter/material.dart';

import '../../models/example_scenario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/example_card.dart';

class ErpDashboardView extends StatefulWidget {
  const ErpDashboardView({
    super.key,
    required this.scenarios,
    required this.onScenarioTap,
  });

  final List<ExampleScenario> scenarios;
  final void Function(ExampleScenario scenario) onScenarioTap;

  @override
  State<ErpDashboardView> createState() => _ErpDashboardViewState();
}

class _ErpDashboardViewState extends State<ErpDashboardView> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedModule = 'All modules';
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<String> get _modules {
    final modules = widget.scenarios
        .map((scenario) => scenario.module)
        .whereType<String>()
        .toSet()
        .toList()
      ..sort();
    return <String>['All modules', ...modules];
  }

  List<ExampleScenario> get _filteredScenarios {
    final normalizedQuery = _query.trim().toLowerCase();
    return widget.scenarios.where((scenario) {
      final matchesModule = _selectedModule == 'All modules' ||
          scenario.module == _selectedModule;
      final searchable = <String>[
        scenario.title,
        scenario.description,
        scenario.module ?? '',
        scenario.reference ?? '',
        ...scenario.tags,
      ].join(' ').toLowerCase();
      return matchesModule &&
          (normalizedQuery.isEmpty || searchable.contains(normalizedQuery));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final scenarios = _filteredScenarios;
    final guarded = widget.scenarios
        .where((scenario) => scenario.barrierDismissible == false)
        .length;
    final recommended = widget.scenarios
        .where((scenario) => scenario.isRecommended)
        .length;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.xl,
            AppSpacing.xl,
            0,
          ),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1180),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(AppRadii.card),
                        border: Border.all(color: colors.outline),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final compact = constraints.maxWidth < 760;
                          final intro = _ErpIntro(
                            workflowCount: widget.scenarios.length,
                            moduleCount: _modules.length - 1,
                          );
                          final metrics = Wrap(
                            spacing: AppSpacing.sm,
                            runSpacing: AppSpacing.sm,
                            children: [
                              _SummaryMetric(
                                label: 'Workflows',
                                value: '${widget.scenarios.length}',
                                icon: Icons.account_tree_outlined,
                                color: AppColors.primary,
                              ),
                              _SummaryMetric(
                                label: 'Guarded actions',
                                value: '$guarded',
                                icon: Icons.lock_outline_rounded,
                                color: AppColors.warning,
                              ),
                              _SummaryMetric(
                                label: 'Recommended',
                                value: '$recommended',
                                icon: Icons.verified_outlined,
                                color: AppColors.success,
                              ),
                            ],
                          );
                          if (compact) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                intro,
                                const SizedBox(height: AppSpacing.xl),
                                metrics,
                              ],
                            );
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: intro),
                              const SizedBox(width: AppSpacing.xl),
                              metrics,
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(AppRadii.card),
                        border: Border.all(color: colors.outline),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final search = TextField(
                            controller: _searchController,
                            onChanged: (value) => setState(() => _query = value),
                            decoration: InputDecoration(
                              hintText: 'Search workflows, references, or tags',
                              prefixIcon: const Icon(Icons.search_rounded),
                              suffixIcon: _query.isEmpty
                                  ? null
                                  : IconButton(
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() => _query = '');
                                      },
                                      icon: const Icon(Icons.close_rounded),
                                      tooltip: 'Clear search',
                                    ),
                            ),
                          );
                          final filters = SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: _modules
                                  .map(
                                    (module) => Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        end: AppSpacing.sm,
                                      ),
                                      child: FilterChip(
                                        selected: _selectedModule == module,
                                        label: Text(module),
                                        onSelected: (_) => setState(
                                          () => _selectedModule = module,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                          if (constraints.maxWidth < 820) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                search,
                                const SizedBox(height: AppSpacing.md),
                                filters,
                              ],
                            );
                          }
                          return Row(
                            children: [
                              SizedBox(width: 340, child: search),
                              const SizedBox(width: AppSpacing.lg),
                              Expanded(child: filters),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Workflow examples',
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                        Text(
                          '${scenarios.length} shown',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (scenarios.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: _EmptyState(
              onReset: () {
                _searchController.clear();
                setState(() {
                  _query = '';
                  _selectedModule = 'All modules';
                });
              },
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.md,
              AppSpacing.xl,
              AppSpacing.xxl,
            ),
            sliver: SliverLayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.crossAxisExtent >= 1080
                    ? 3
                    : constraints.crossAxisExtent >= 680
                        ? 2
                        : 1;
                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                    mainAxisExtent: 330,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final scenario = scenarios[index];
                      return Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1180),
                          child: ExampleCard(
                            scenario: scenario,
                            onTap: () => widget.onScenarioTap(scenario),
                          ),
                        ),
                      );
                    },
                    childCount: scenarios.length,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _ErpIntro extends StatelessWidget {
  const _ErpIntro({required this.workflowCount, required this.moduleCount});

  final int workflowCount;
  final int moduleCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.20),
            ),
          ),
          child: const Icon(
            Icons.business_center_outlined,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ERP dialog patterns', style: theme.textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '$workflowCount production-oriented examples across $moduleCount ERP modules. Each pattern demonstrates hierarchy, audit context, guarded actions, and clear business outcomes.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 132,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onReset});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 40,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            Text('No matching workflows', style: theme.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Try another module or clear the search query.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton(onPressed: onReset, child: const Text('Reset filters')),
          ],
        ),
      ),
    );
  }
}
