import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

import '../../models/positioned_constants.dart';
import '../../theme/app_theme.dart';
import '../dialogs/dialogs.dart';

class CombinationSection extends StatefulWidget {
  const CombinationSection({
    super.key,
    required this.type,
    required this.onCodeTap,
  });

  final PositionedTransitionType type;
  final void Function({
    required DialogPosition position,
    required PositionedTransitionType type,
  }) onCodeTap;

  @override
  State<CombinationSection> createState() => _CombinationSectionState();
}

class _CombinationSectionState extends State<CombinationSection> {
  bool _expanded = false;

  Color get _accent => switch (widget.type) {
        PositionedTransitionType.slide => AppColors.primary,
        PositionedTransitionType.slideFade => AppColors.info,
        PositionedTransitionType.slideScale => AppColors.success,
        PositionedTransitionType.slideFadeScale => AppColors.purple,
        PositionedTransitionType.fade => AppColors.warning,
        PositionedTransitionType.scale => AppColors.error,
        PositionedTransitionType.scaleFade => AppColors.teal,
        PositionedTransitionType.bounce => AppColors.error,
        PositionedTransitionType.elastic => AppColors.warning,
        PositionedTransitionType.zoom => AppColors.success,
      };

  String get _description => switch (widget.type) {
        PositionedTransitionType.slide => 'Direct spatial movement between two viewport anchors.',
        PositionedTransitionType.slideFade => 'Spatial movement with a quieter opacity transition.',
        PositionedTransitionType.slideScale => 'Movement plus subtle scale for contextual panels.',
        PositionedTransitionType.slideFadeScale => 'Combined movement, opacity, and scale treatment.',
        PositionedTransitionType.fade => 'Low-distraction entrance for lightweight feedback.',
        PositionedTransitionType.scale => 'Centered emphasis without directional movement.',
        PositionedTransitionType.scaleFade => 'Soft scale emphasis for confirmations and summaries.',
        PositionedTransitionType.bounce => 'Expressive feedback for non-blocking success states.',
        PositionedTransitionType.elastic => 'Elastic emphasis for demonstrative showcase surfaces.',
        PositionedTransitionType.zoom => 'Compact zoom entrance for inspectors and detail cards.',
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = _accent;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(
          color: _expanded
              ? accent.withValues(alpha: 0.52)
              : theme.colorScheme.outline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(AppRadii.card),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 500;
                  final identity = Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 42,
                        height: 42,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(AppRadii.card),
                        ),
                        child: Icon(
                          PositionedConstants.getTransitionIcon(widget.type),
                          color: accent,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              PositionedConstants.getTransitionLabel(widget.type),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              _description,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                  final controls = Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(AppRadii.pill),
                        ),
                        child: Text(
                          '9 positions',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: accent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      AnimatedRotation(
                        turns: _expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 180),
                        child: const Icon(Icons.keyboard_arrow_down_rounded),
                      ),
                    ],
                  );
                  if (compact) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        identity,
                        const SizedBox(height: AppSpacing.md),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: controls,
                        ),
                      ],
                    );
                  }
                  return Row(
                    children: <Widget>[
                      Expanded(child: identity),
                      const SizedBox(width: AppSpacing.lg),
                      controls,
                    ],
                  );
                },
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Column(
                children: <Widget>[
                  Divider(color: accent.withValues(alpha: 0.28)),
                  const SizedBox(height: AppSpacing.md),
                  _CombinationGrid(
                    type: widget.type,
                    onCodeTap: widget.onCodeTap,
                  ),
                ],
              ),
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }
}

class _CombinationGrid extends StatelessWidget {
  const _CombinationGrid({
    required this.type,
    required this.onCodeTap,
  });

  final PositionedTransitionType type;
  final void Function({
    required DialogPosition position,
    required PositionedTransitionType type,
  }) onCodeTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < 500 ? 2 : 3;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: AppSpacing.sm,
            crossAxisSpacing: AppSpacing.sm,
            childAspectRatio: columns == 2 ? 1.20 : 1.08,
          ),
          itemCount: PositionedConstants.allPositions.length,
          itemBuilder: (context, index) {
            final position = PositionedConstants.allPositions[index];
            return _CombinationTile(
              position: position,
              type: type,
              accent: PositionedConstants.getPositionColor(position),
              onCodeTap: () => onCodeTap(position: position, type: type),
            );
          },
        );
      },
    );
  }
}

class _CombinationTile extends StatelessWidget {
  const _CombinationTile({
    required this.position,
    required this.type,
    required this.accent,
    required this.onCodeTap,
  });

  final DialogPosition position;
  final PositionedTransitionType type;
  final Color accent;
  final VoidCallback onCodeTap;

  Alignment get _alignment => switch (position) {
        DialogPosition.topStart => Alignment.topLeft,
        DialogPosition.topCenter => Alignment.topCenter,
        DialogPosition.topEnd => Alignment.topRight,
        DialogPosition.centerStart => Alignment.centerLeft,
        DialogPosition.center => Alignment.center,
        DialogPosition.centerEnd => Alignment.centerRight,
        DialogPosition.bottomStart => Alignment.bottomLeft,
        DialogPosition.bottomCenter => Alignment.bottomCenter,
        DialogPosition.bottomEnd => Alignment.bottomRight,
        DialogPosition.offScreen => Alignment.center,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.control),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => _show(context),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(AppRadii.control),
                          border: Border.all(color: theme.colorScheme.outline),
                        ),
                        child: Align(
                          alignment: _alignment,
                          child: Container(
                            width: 18,
                            height: 12,
                            margin: const EdgeInsets.all(AppSpacing.xs),
                            decoration: BoxDecoration(
                              color: accent,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      position.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: TextButton.icon(
              onPressed: onCodeTap,
              icon: Icon(Icons.code_rounded, size: 13, color: accent),
              label: Text(
                'Code',
                style: theme.textTheme.labelSmall?.copyWith(color: accent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _show(BuildContext context) {
    SuperDialog.showPositionedDialog<void>(
      context,
      (context) => PositionedInfoCard(
        position:
            '${position.displayName}\n${PositionedConstants.getTransitionLabel(type)}',
        accentColor: accent,
      ),
      startPosition: DialogPosition.offScreen,
      endPosition: position,
      transitionType: type,
      barrierDismissible: true,
      barrierColor: const Color(0x8C000000),
      barrierBlur: 8,
    );
  }
}
