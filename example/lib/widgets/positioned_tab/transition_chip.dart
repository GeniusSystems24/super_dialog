import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

import '../../models/positioned_constants.dart';
import '../../theme/app_theme.dart';
import '../dialogs/dialogs.dart';

class TransitionChip extends StatefulWidget {
  const TransitionChip({
    super.key,
    required this.type,
    required this.onCodeTap,
  });

  final PositionedTransitionType type;
  final VoidCallback onCodeTap;

  @override
  State<TransitionChip> createState() => _TransitionChipState();
}

class _TransitionChipState extends State<TransitionChip> {
  bool _hovered = false;

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = _accent;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadii.card),
          border: Border.all(
            color: _hovered
                ? accent.withValues(alpha: 0.62)
                : theme.colorScheme.outline,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InkWell(
              onTap: () => _showTransitionDialog(context),
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(AppRadii.card),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(AppRadii.control),
                      ),
                      child: AnimatedScale(
                        scale: _hovered ? 1.12 : 1,
                        duration: const Duration(milliseconds: 150),
                        child: Icon(
                          PositionedConstants.getTransitionIcon(widget.type),
                          size: 16,
                          color: accent,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      PositionedConstants.getTransitionLabel(widget.type),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: _hovered ? accent : theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(width: 1, height: 30, color: theme.colorScheme.outline),
            IconButton(
              onPressed: widget.onCodeTap,
              tooltip: 'View generated code',
              icon: Icon(Icons.code_rounded, size: 16, color: accent),
            ),
          ],
        ),
      ),
    );
  }

  void _showTransitionDialog(BuildContext context) {
    SuperDialog.showPositionedDialog<void>(
      context,
      (context) => PositionedInfoCard(
        position: PositionedConstants.getTransitionLabel(widget.type),
        accentColor: _accent,
      ),
      startPosition: DialogPosition.bottomCenter,
      endPosition: DialogPosition.center,
      transitionType: widget.type,
      barrierDismissible: true,
      barrierColor: const Color(0x8C000000),
      barrierBlur: 8,
    );
  }
}
