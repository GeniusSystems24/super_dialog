import 'package:flutter/material.dart';

import '../../models/example_scenario.dart';
import '../../theme/app_layout.dart';
import '../../theme/app_theme.dart';
import '../../widgets/example_card.dart';
import '../../widgets/showcase_header.dart';

class ErpWorkflowsView extends StatefulWidget {
  const ErpWorkflowsView({
    super.key,
    required this.scenarios,
    required this.onScenarioTap,
  });

  final List<ExampleScenario> scenarios;
  final void Function(ExampleScenario scenario) onScenarioTap;

  @override
  State<ErpWorkflowsView> createState() => _ErpWorkflowsViewState();
}

class _ErpWorkflowsViewState extends State<ErpWorkflowsView> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedModule = 'All modules';
  String _selectedPattern = 'All designs';
  String _query = '';

  List<String> get _modules {
    final values = widget.scenarios
        .map((scenario) => scenario.module)
        .whereType<String>()
        .toSet()
        .toList()
      ..sort();
    return <String>['All modules', ...values];
  }

  List<String> get _patterns {
    final values = widget.scenarios
        .map((scenario) => scenario.designFamily)
        .whereType<String>()
        .toSet()
        .toList()
      ..sort();
    return <String>['All designs', ...values];
  }

  List<ExampleScenario> get _filtered {
    final normalized = _query.trim().toLowerCase();
    return widget.scenarios.where((scenario) {
      final moduleMatches = _selectedModule == 'All modules' ||
          scenario.module == _selectedModule;
      final patternMatches = _selectedPattern == 'All designs' ||
          scenario.designFamily == _selectedPattern;
      final queryMatches = normalized.isEmpty ||
          scenario.title.toLowerCase().contains(normalized) ||
          scenario.description.toLowerCase().contains(normalized) ||
          (scenario.reference?.toLowerCase().contains(normalized) ?? false) ||
          (scenario.designPattern?.toLowerCase().contains(normalized) ?? false) ||
          (scenario.designFamily?.toLowerCase().contains(normalized) ?? false) ||
          scenario.tags.any((tag) => tag.toLowerCase().contains(normalized));
      return moduleMatches && patternMatches && queryMatches;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _reset() {
    _searchController.clear();
    setState(() {
      _query = '';
      _selectedModule = 'All modules';
      _selectedPattern = 'All designs';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scenarios = _filtered;

    return LayoutBuilder(
      builder: (context, constraints) {
        final pagePadding = AppLayout.pagePaddingFor(constraints.maxWidth);
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
                    constraints: const BoxConstraints(maxWidth: 1320),
                    child: ShowcaseHeader(
                      eyebrow: 'ERP dialog design library',
                      title: '64 ERP dialog designs · 16 layout families',
                      description:
                          'A large responsive catalog covering finance, procurement, inventory, sales, manufacturing, HCM, projects, assets, service, planning, tax, and governance.',
                      icon: Icons.business_center_outlined,
                      badges: <Widget>[
                        ShowcaseBadge(
                          label: '${widget.scenarios.length} examples',
                          icon: Icons.view_list_outlined,
                        ),
                        ShowcaseBadge(
                          label: '${widget.scenarios.length} design variants',
                          icon: Icons.dashboard_customize_outlined,
                          color: AppColors.purple,
                        ),
                        ShowcaseBadge(
                          label: '${_modules.length - 1} ERP domains',
                          icon: Icons.account_tree_outlined,
                        ),
                        const ShowcaseBadge(
                          label: 'Responsive + audit-aware',
                          icon: Icons.policy_outlined,
                          color: AppColors.success,
                        ),
                      ],
                      trailing: FilledButton.icon(
                        onPressed: scenarios.isEmpty
                            ? null
                            : () => widget.onScenarioTap(scenarios.first),
                        icon: const Icon(Icons.play_arrow_rounded, size: 18),
                        label: const Text('Preview first design'),
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
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1320),
                    child: _WorkflowSummary(scenarios: widget.scenarios),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                pagePadding.left,
                AppSpacing.lg,
                pagePadding.right,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1320),
                    child: Container(
                      padding: EdgeInsets.all(
                        compact ? AppSpacing.md : AppSpacing.lg,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppRadii.card),
                        border: Border.all(color: theme.colorScheme.outline),
                      ),
                      child: _FilterControls(
                        controller: _searchController,
                        query: _query,
                        modules: _modules,
                        patterns: _patterns,
                        selectedModule: _selectedModule,
                        selectedPattern: _selectedPattern,
                        onQueryChanged: (value) =>
                            setState(() => _query = value),
                        onClearQuery: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                        onModuleChanged: (value) =>
                            setState(() => _selectedModule = value),
                        onPatternChanged: (value) =>
                            setState(() => _selectedPattern = value),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (scenarios.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _EmptyWorkflows(onReset: _reset),
              )
            else
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  pagePadding.left,
                  AppSpacing.lg,
                  pagePadding.right,
                  pagePadding.bottom,
                ),
                sliver: SliverLayoutBuilder(
                  builder: (context, sliverConstraints) {
                    final count = AppLayout.gridColumnsFor(
                      sliverConstraints.crossAxisExtent,
                      minTileWidth: 330,
                      maxColumns: 4,
                    );
                    return SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final scenario = scenarios[index];
                          return ExampleCard(
                            scenario: scenario,
                            compact: count >= 4,
                            onTap: () => widget.onScenarioTap(scenario),
                          );
                        },
                        childCount: scenarios.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: count,
                        mainAxisSpacing: AppSpacing.md,
                        crossAxisSpacing: AppSpacing.md,
                        mainAxisExtent: compact ? 382 : (count >= 4 ? 318 : 352),
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

class _FilterControls extends StatelessWidget {
  const _FilterControls({
    required this.controller,
    required this.query,
    required this.modules,
    required this.patterns,
    required this.selectedModule,
    required this.selectedPattern,
    required this.onQueryChanged,
    required this.onClearQuery,
    required this.onModuleChanged,
    required this.onPatternChanged,
  });

  final TextEditingController controller;
  final String query;
  final List<String> modules;
  final List<String> patterns;
  final String selectedModule;
  final String selectedPattern;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onClearQuery;
  final ValueChanged<String> onModuleChanged;
  final ValueChanged<String> onPatternChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked = constraints.maxWidth < 760;
        final search = TextField(
          controller: controller,
          onChanged: onQueryChanged,
          decoration: InputDecoration(
            hintText: 'Search workflow, document, domain, or design pattern',
            prefixIcon: const Icon(Icons.search_rounded, size: 18),
            suffixIcon: query.isEmpty
                ? null
                : IconButton(
                    tooltip: 'Clear search',
                    onPressed: onClearQuery,
                    icon: const Icon(Icons.close_rounded, size: 16),
                  ),
          ),
        );
        final selectors = <Widget>[
          DropdownButtonFormField<String>(
            initialValue: selectedModule,
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'ERP domain',
              prefixIcon: Icon(Icons.account_tree_outlined, size: 18),
            ),
            items: modules
                .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                .toList(),
            onChanged: (value) {
              if (value != null) onModuleChanged(value);
            },
          ),
          DropdownButtonFormField<String>(
            initialValue: selectedPattern,
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Dialog design',
              prefixIcon: Icon(Icons.dashboard_customize_outlined, size: 18),
            ),
            items: patterns
                .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                .toList(),
            onChanged: (value) {
              if (value != null) onPatternChanged(value);
            },
          ),
        ];

        if (stacked) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              search,
              const SizedBox(height: AppSpacing.md),
              selectors[0],
              const SizedBox(height: AppSpacing.md),
              selectors[1],
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            search,
            const SizedBox(height: AppSpacing.md),
            Row(
              children: <Widget>[
                Expanded(child: selectors[0]),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: selectors[1]),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _WorkflowSummary extends StatelessWidget {
  const _WorkflowSummary({required this.scenarios});

  final List<ExampleScenario> scenarios;

  @override
  Widget build(BuildContext context) {
    final recommended = scenarios.where((item) => item.isRecommended).length;
    final blocking =
        scenarios.where((item) => item.barrierDismissible == false).length;
    final modules =
        scenarios.map((item) => item.module).whereType<String>().toSet().length;
    final patterns = scenarios
        .map((item) => item.designFamily)
        .whereType<String>()
        .toSet()
        .length;

    return LayoutBuilder(
      builder: (context, constraints) {
        final count = AppLayout.gridColumnsFor(
          constraints.maxWidth,
          minTileWidth: 220,
          maxColumns: 5,
        );
        final cards = <Widget>[
          _SummaryCard(
            label: 'ERP examples',
            value: '${scenarios.length}',
            icon: Icons.widgets_outlined,
            color: AppColors.primary,
          ),
          _SummaryCard(
            label: 'Layout families',
            value: '$patterns',
            icon: Icons.dashboard_customize_outlined,
            color: AppColors.purple,
          ),
          _SummaryCard(
            label: 'Recommended',
            value: '$recommended',
            icon: Icons.verified_outlined,
            color: AppColors.success,
          ),
          _SummaryCard(
            label: 'Controlled actions',
            value: '$blocking',
            icon: Icons.lock_outline_rounded,
            color: AppColors.warning,
          ),
          _SummaryCard(
            label: 'Business domains',
            value: '$modules',
            icon: Icons.account_tree_outlined,
            color: AppColors.teal,
          ),
        ];

        return GridView.builder(
          itemCount: cards.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            mainAxisExtent: 88,
          ),
          itemBuilder: (context, index) => cards[index],
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
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
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadii.control),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  value,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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

class _EmptyWorkflows extends StatelessWidget {
  const _EmptyWorkflows({required this.onReset});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: AppLayout.pagePadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.search_off_rounded,
              size: 44,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            Text('No ERP examples found', style: theme.textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Clear the search or select another ERP domain and design pattern.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton(
              onPressed: onReset,
              child: const Text('Reset filters'),
            ),
          ],
        ),
      ),
    );
  }
}
