import 'package:flutter/material.dart';
import '../../models/animation_category.dart';
import '../../models/example_scenario.dart';
import '../../widgets/example_card.dart';

/// Animation list tab view.
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
        .where((s) => category.animations.contains(s.animation))
        .toList();

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: filteredScenarios.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final scenario = filteredScenarios[index];
        return ExampleCard(
          scenario: scenario,
          onTap: () => onScenarioTap(scenario),
        );
      },
    );
  }
}
