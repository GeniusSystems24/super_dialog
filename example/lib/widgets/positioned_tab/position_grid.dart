import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

import '../../models/positioned_constants.dart';
import '../../theme/app_theme.dart';
import 'position_button.dart';

class PositionGrid extends StatelessWidget {
  const PositionGrid({super.key, required this.onCodeTap});

  final void Function(DialogPosition position) onCodeTap;

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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 520;
          final columns = compact ? 2 : 3;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _ViewportHeader(compact: compact),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Select a viewport destination to preview the overlay. Use the code action to inspect the generated API call.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.md,
                  childAspectRatio: compact ? 1.20 : 1.08,
                ),
                itemCount: PositionedConstants.allPositions.length,
                itemBuilder: (context, index) {
                  final position = PositionedConstants.allPositions[index];
                  return PositionButton(
                    position: position,
                    onCodeTap: () => onCodeTap(position),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ViewportHeader extends StatelessWidget {
  const _ViewportHeader({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.control),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Row(
        children: <Widget>[
          const Wrap(
            spacing: AppSpacing.xs,
            children: <Widget>[
              _WindowDot(color: AppColors.error),
              _WindowDot(color: AppColors.warning),
              _WindowDot(color: AppColors.success),
            ],
          ),
          const Spacer(),
          Icon(
            Icons.crop_square_rounded,
            size: 15,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              compact ? 'Viewport' : 'Responsive viewport positions',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const Spacer(),
          const SizedBox(width: 44),
        ],
      ),
    );
  }
}

class _WindowDot extends StatelessWidget {
  const _WindowDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}
