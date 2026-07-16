import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

import '../models/example_scenario.dart';
import '../theme/app_theme.dart';
import 'dialogs/code_viewer_dialog.dart';

class ExampleCard extends StatefulWidget {
  const ExampleCard({
    super.key,
    required this.scenario,
    required this.onTap,
    this.compact = false,
  });

  final ExampleScenario scenario;
  final VoidCallback onTap;
  final bool compact;

  @override
  State<ExampleCard> createState() => _ExampleCardState();
}

class _ExampleCardState extends State<ExampleCard> {
  bool _isHovered = false;

  void _showCodeDialog() {
    final code = widget.scenario.generatedCodeSnippet;
    if (code.isEmpty) return;

    SuperDialog.showAnimatedDialog<void>(
      context,
      (context) => CodeViewerDialog(
        title: widget.scenario.title,
        code: code,
        accentColor: widget.scenario.accentColor,
      ),
      animation: DialogAnimation.centerScale,
      barrierDismissible: true,
      barrierBlur: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final scenario = widget.scenario;
    final hasCode = scenario.generatedCodeSnippet.isNotEmpty;
    final accent = scenario.accentColor;
    final isErp = scenario.category == 'ERP';

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: const Cubic(0.4, 0, 0.2, 1),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadii.card),
          border: Border.all(
            color: _isHovered
                ? accent.withValues(alpha: 0.58)
                : colors.outline,
          ),
          boxShadow: _isHovered
              ? <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: theme.brightness == Brightness.dark ? 0.25 : 0.08,
                    ),
                    blurRadius: 24,
                    spreadRadius: -10,
                    offset: const Offset(0, 10),
                  ),
                ]
              : const <BoxShadow>[],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(AppRadii.card),
            child: Padding(
              padding: EdgeInsets.all(
                widget.compact ? AppSpacing.lg : AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(AppRadii.card),
                        ),
                        child: Icon(scenario.icon, color: accent, size: 20),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    scenario.module ?? scenario.category,
                                    style: theme.textTheme.labelMedium?.copyWith(
                                      color: accent,
                                      letterSpacing: 0.75,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (scenario.isRecommended)
                                  Tooltip(
                                    message: 'Recommended ERP dialog pattern',
                                    child: Icon(
                                      Icons.verified_rounded,
                                      size: 16,
                                      color: colors.primary,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              scenario.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: colors.onSurface,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (hasCode) ...[
                        const SizedBox(width: AppSpacing.sm),
                        IconButton(
                          onPressed: _showCodeDialog,
                          icon: const Icon(Icons.code_rounded, size: 16),
                          tooltip: 'View code',
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    scenario.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                    maxLines: widget.compact ? 2 : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (scenario.reference != null ||
                      scenario.statusLabel != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(AppRadii.control),
                        border: Border.all(color: colors.outline),
                      ),
                      child: Row(
                        children: [
                          if (scenario.reference != null)
                            Expanded(
                              child: Text(
                                scenario.reference!,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: colors.onSurfaceVariant,
                                  fontFamily: 'JetBrainsMono',
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          if (scenario.statusLabel != null)
                            _StatusPill(
                              label: scenario.statusLabel!,
                              color: scenario.statusColor ?? accent,
                            ),
                        ],
                      ),
                    ),
                  ],
                  if (scenario.tags.isNotEmpty && !widget.compact) ...[
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: scenario.tags.take(3)
                          .map(
                            (tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: colors.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(
                                  AppRadii.pill,
                                ),
                              ),
                              child: Text(
                                tag,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      Icon(
                        isErp
                            ? Icons.dashboard_customize_outlined
                            : Icons.animation_rounded,
                        size: 14,
                        color: colors.onSurfaceVariant,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          isErp
                              ? (scenario.designPattern ?? scenario.animationLabel)
                              : scenario.animationLabel,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        isErp ? 'Open workflow' : 'Preview',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: accent,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: accent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
