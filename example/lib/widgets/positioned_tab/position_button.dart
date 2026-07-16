import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

import '../../models/positioned_constants.dart';
import '../../theme/app_theme.dart';
import '../dialogs/dialogs.dart';

class PositionButton extends StatefulWidget {
  const PositionButton({
    super.key,
    required this.position,
    required this.onCodeTap,
  });

  final DialogPosition position;
  final VoidCallback onCodeTap;

  @override
  State<PositionButton> createState() => _PositionButtonState();
}

class _PositionButtonState extends State<PositionButton> {
  bool _hovered = false;

  Color get _accent => PositionedConstants.getPositionColor(widget.position);

  Alignment get _alignment => switch (widget.position) {
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
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadii.card),
          border: Border.all(
            color: _hovered
                ? _accent.withValues(alpha: 0.62)
                : theme.colorScheme.outline,
          ),
          boxShadow: _hovered
              ? <BoxShadow>[
                  BoxShadow(
                    color: _accent.withValues(alpha: 0.14),
                    blurRadius: 18,
                    spreadRadius: -8,
                    offset: const Offset(0, 8),
                  ),
                ]
              : const <BoxShadow>[],
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () => _showPositionedDialog(context),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadii.card),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Column(
                      children: <Widget>[
                        Expanded(child: _MiniViewport(alignment: _alignment, accent: _accent, hovered: _hovered)),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          widget.position.displayName,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: _hovered ? _accent : theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: widget.onCodeTap,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(AppRadii.card),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: _accent.withValues(alpha: 0.09),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(AppRadii.card),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.code_rounded, size: 14, color: _accent),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        'View code',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: _accent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPositionedDialog(BuildContext context) {
    SuperDialog.showPositionedDialog<void>(
      context,
      (context) => PositionedInfoCard(
        position: widget.position.displayName,
        accentColor: _accent,
      ),
      startPosition: DialogPosition.offScreen,
      endPosition: widget.position,
      transitionType: PositionedTransitionType.slideFade,
      barrierDismissible: true,
      barrierColor: const Color(0x8C000000),
      barrierBlur: 8,
    );
  }
}

class _MiniViewport extends StatelessWidget {
  const _MiniViewport({
    required this.alignment,
    required this.accent,
    required this.hovered,
  });

  final Alignment alignment;
  final Color accent;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.control),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CustomPaint(
              painter: _GridPainter(
                color: theme.colorScheme.outline.withValues(alpha: 0.52),
              ),
            ),
          ),
          Align(
            alignment: alignment,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.all(AppSpacing.xs),
              width: hovered ? 22 : 18,
              height: hovered ? 15 : 12,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(3),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: accent.withValues(alpha: hovered ? 0.46 : 0.28),
                    blurRadius: hovered ? 8 : 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;
    for (var index = 1; index < 3; index++) {
      final x = size.width * index / 3;
      final y = size.height * index / 3;
      canvas
        ..drawLine(Offset(x, 0), Offset(x, size.height), paint)
        ..drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) =>
      oldDelegate.color != color;
}
