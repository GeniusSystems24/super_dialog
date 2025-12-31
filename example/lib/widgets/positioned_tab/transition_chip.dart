import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';
import '../../models/positioned_constants.dart';
import '../../theme/app_theme.dart';
import '../dialogs/dialogs.dart';

/// Premium transition chip that visually represents its animation type.
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

class _TransitionChipState extends State<TransitionChip>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animController;

  Color _getTypeColor(PositionedTransitionType type) {
    switch (type) {
      case PositionedTransitionType.slide:
        return AppColors.primary;
      case PositionedTransitionType.slideFade:
        return AppColors.info;
      case PositionedTransitionType.slideScale:
        return AppColors.success;
      case PositionedTransitionType.slideFadeScale:
        return const Color(0xFF8B5CF6);
      case PositionedTransitionType.fade:
        return AppColors.warning;
      case PositionedTransitionType.scale:
        return const Color(0xFFEC4899);
      case PositionedTransitionType.scaleFade:
        return const Color(0xFF14B8A6);
      case PositionedTransitionType.bounce:
        return const Color(0xFFEF4444);
      case PositionedTransitionType.elastic:
        return const Color(0xFFF59E0B);
      case PositionedTransitionType.zoom:
        return const Color(0xFF10B981);
    }
  }

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _animController.reset();
    _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = _getTypeColor(widget.type);
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _startAnimation();
      },
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkCard.withValues(alpha: 0.8)
              : AppColors.lightCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _isHovered
                ? color.withValues(alpha: 0.6)
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? color.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: isDark ? 0.15 : 0.05),
              blurRadius: _isHovered ? 12 : 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Main content with animation preview
            InkWell(
              onTap: () => _showTransitionDialog(context),
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Animated transition preview
                    SizedBox(
                      width: 32,
                      height: 24,
                      child: _buildTransitionPreview(color, isDark),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      PositionedConstants.getTransitionLabel(widget.type),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _isHovered ? color : textColor,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Divider
            Container(
              width: 1,
              height: 24,
              color: isDark
                  ? AppColors.darkBorder.withValues(alpha: 0.5)
                  : AppColors.lightBorder,
            ),
            // Code button
            InkWell(
              onTap: widget.onCodeTap,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Icon(
                  Icons.code_rounded,
                  size: 16,
                  color: _isHovered
                      ? color
                      : (isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds animated preview showing what the transition looks like.
  Widget _buildTransitionPreview(Color color, bool isDark) {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        final progress = Curves.easeInOut.transform(_animController.value);

        // Calculate animation based on type
        double opacity = 1.0;
        double scale = 1.0;
        Offset offset = Offset.zero;

        switch (widget.type) {
          case PositionedTransitionType.slide:
            offset = Offset.lerp(const Offset(-1, 0), Offset.zero, progress)!;
            break;
          case PositionedTransitionType.slideFade:
            offset = Offset.lerp(const Offset(-1, 0), Offset.zero, progress)!;
            opacity = progress;
            break;
          case PositionedTransitionType.slideScale:
            offset = Offset.lerp(const Offset(-1, 0), Offset.zero, progress)!;
            scale = 0.5 + (0.5 * progress);
            break;
          case PositionedTransitionType.slideFadeScale:
            offset = Offset.lerp(const Offset(-1, 0), Offset.zero, progress)!;
            opacity = progress;
            scale = 0.5 + (0.5 * progress);
            break;
          case PositionedTransitionType.fade:
            opacity = progress;
            break;
          case PositionedTransitionType.scale:
            scale = 0.3 + (0.7 * progress);
            break;
          case PositionedTransitionType.scaleFade:
            scale = 0.3 + (0.7 * progress);
            opacity = progress;
            break;
          case PositionedTransitionType.bounce:
            // Bouncy scale animation with elastic curve
            final bounceProgress = Curves.elasticOut.transform(progress);
            scale = 0.3 + (0.7 * bounceProgress);
            opacity = progress;
            break;
          case PositionedTransitionType.elastic:
            // Elastic overshoot from 0.5 to 1.0
            final elasticProgress = Curves.easeOutBack.transform(progress);
            scale = 0.5 + (0.5 * elasticProgress);
            opacity = progress;
            break;
          case PositionedTransitionType.zoom:
            // Smooth zoom from 0.88 to 1.0
            final zoomProgress = Curves.easeOutBack.transform(progress);
            scale = 0.88 + (0.12 * zoomProgress);
            opacity = progress;
            break;
        }

        return Container(
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkBackground
                : AppColors.lightDivider.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isDark
                  ? AppColors.darkBorder.withValues(alpha: 0.3)
                  : AppColors.lightBorder.withValues(alpha: 0.5),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Transform.translate(
              offset: Offset(offset.dx * 10, offset.dy * 8),
              child: Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity.clamp(0.0, 1.0),
                  child: Center(
                    child: Container(
                      width: 14,
                      height: 10,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color, color.withValues(alpha: 0.7)],
                        ),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showTransitionDialog(BuildContext context) {
    SuperDialog.showPositionedDialog<void>(
      context,
      (context) => const PositionedCornerDialog(fromCorner: 'Bottom'),
      startPosition: DialogPosition.bottomCenter,
      endPosition: DialogPosition.center,
      transitionType: widget.type,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      barrierBlur: 8,
    );
  }
}
