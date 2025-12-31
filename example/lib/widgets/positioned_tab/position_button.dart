import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';
import '../../models/positioned_constants.dart';
import '../../theme/app_theme.dart';
import '../dialogs/dialogs.dart';

/// Premium position button that visually represents its position on a mini screen.
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
  bool _isHovered = false;

  Color get _color => PositionedConstants.getPositionColor(widget.position);

  /// Gets the alignment for the position indicator within the mini screen.
  Alignment _getPositionAlignment() {
    switch (widget.position) {
      case DialogPosition.topStart:
        return Alignment.topLeft;
      case DialogPosition.topCenter:
        return Alignment.topCenter;
      case DialogPosition.topEnd:
        return Alignment.topRight;
      case DialogPosition.centerStart:
        return Alignment.centerLeft;
      case DialogPosition.center:
        return Alignment.center;
      case DialogPosition.centerEnd:
        return Alignment.centerRight;
      case DialogPosition.bottomStart:
        return Alignment.bottomLeft;
      case DialogPosition.bottomCenter:
        return Alignment.bottomCenter;
      case DialogPosition.bottomEnd:
        return Alignment.bottomRight;
      case DialogPosition.offScreen:
        return Alignment.center;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkCard.withValues(alpha: 0.8)
              : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? _color.withValues(alpha: 0.6)
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? _color.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
              blurRadius: _isHovered ? 16 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Mini screen visualization
            Expanded(
              child: InkWell(
                onTap: () => _showPositionedDialog(context),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // Mini screen with position indicator
                      Expanded(child: _buildMiniScreen(isDark)),
                      const SizedBox(height: 6),
                      // Position name
                      Text(
                        widget.position.displayName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: _isHovered
                              ? _color
                              : (isDark
                                    ? AppColors.darkText
                                    : AppColors.lightText),
                          letterSpacing: -0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Code button
            InkWell(
              onTap: widget.onCodeTap,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: _color.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.code_rounded, size: 12, color: _color),
                    const SizedBox(width: 4),
                    Text(
                      'Code',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: _color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a mini screen representation showing the position.
  Widget _buildMiniScreen(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkBackground
            : AppColors.lightDivider.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark
              ? AppColors.darkBorder.withValues(alpha: 0.5)
              : AppColors.lightBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Stack(
        children: [
          // Grid lines for reference
          Positioned.fill(
            child: CustomPaint(
              painter: _GridPainter(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.black.withValues(alpha: 0.03),
              ),
            ),
          ),
          // Position indicator (the dialog representation)
          Align(
            alignment: _getPositionAlignment(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.all(4),
              width: _isHovered ? 18 : 14,
              height: _isHovered ? 12 : 10,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_color, _color.withValues(alpha: 0.7)],
                ),
                borderRadius: BorderRadius.circular(3),
                boxShadow: [
                  BoxShadow(
                    color: _color.withValues(alpha: _isHovered ? 0.6 : 0.4),
                    blurRadius: _isHovered ? 8 : 4,
                    spreadRadius: _isHovered ? 1 : 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPositionedDialog(BuildContext context) {
    SuperDialog.showPositionedDialog<void>(
      context,
      (context) => PositionedInfoCard(
        position: widget.position.displayName,
        accentColor: _color,
      ),
      startPosition: DialogPosition.offScreen,
      endPosition: widget.position,
      transitionType: PositionedTransitionType.slideFade,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      barrierBlur: 8,
    );
  }
}

/// Custom painter for grid lines.
class _GridPainter extends CustomPainter {
  final Color color;

  _GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;

    // Vertical lines (divide into 3)
    for (int i = 1; i < 3; i++) {
      final x = size.width * i / 3;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines (divide into 3)
    for (int i = 1; i < 3; i++) {
      final y = size.height * i / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
