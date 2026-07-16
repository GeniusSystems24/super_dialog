import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

import '../../theme/app_theme.dart';
import 'dialog_demo_components.dart';

class RoadmapCard extends StatelessWidget {
  const RoadmapCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDialogSurface(
      width: 640,
      title: 'Implementation Milestones',
      subtitle: 'ERP rollout · Wave 2 · Manufacturing and procurement',
      icon: Icons.route_outlined,
      iconColor: AppColors.primary,
      content: const DemoPanel(
        child: Column(
          children: [
            _Milestone(
              title: 'Master data validation',
              detail: 'Completed 11 Jul · 4,820 records',
              state: 'Complete',
              color: AppColors.success,
              icon: Icons.check_rounded,
            ),
            DemoDivider(),
            _Milestone(
              title: 'Integration testing',
              detail: 'In progress · 84 of 96 scenarios passed',
              state: 'In progress',
              color: AppColors.primary,
              icon: Icons.sync_rounded,
            ),
            DemoDivider(),
            _Milestone(
              title: 'Business readiness review',
              detail: 'Scheduled 22 Jul · 18 process owners',
              state: 'Upcoming',
              color: AppColors.warning,
              icon: Icons.calendar_today_outlined,
            ),
            DemoDivider(),
            _Milestone(
              title: 'Production cutover',
              detail: 'Planned 02 Aug · 36-hour window',
              state: 'Planned',
              color: AppColors.purple,
              icon: Icons.rocket_launch_outlined,
            ),
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Open project'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Acknowledge'),
        ),
      ],
    );
  }
}

class _Milestone extends StatelessWidget {
  const _Milestone({
    required this.title,
    required this.detail,
    required this.state,
    required this.color,
    required this.icon,
  });

  final String title;
  final String detail;
  final String state;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 420;
          final identity = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadii.control),
                ),
                child: Icon(icon, size: 17, color: color),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
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
          );
          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                identity,
                const SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: DemoStatusChip(label: state, color: color),
                ),
              ],
            );
          }
          return Row(
            children: <Widget>[
              Expanded(child: identity),
              const SizedBox(width: AppSpacing.md),
              DemoStatusChip(label: state, color: color),
            ],
          );
        },
      ),
    );
  }
}
