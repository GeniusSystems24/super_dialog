import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';
import '../../models/positioned_constants.dart';
import '../../theme/app_theme.dart';
import '../dialogs/dialogs.dart';

/// Premium combination section with expandable design and visual representations.
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
  })
  onCodeTap;

  @override
  State<CombinationSection> createState() => _CombinationSectionState();
}

class _CombinationSectionState extends State<CombinationSection>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _iconAnimController;

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

  /// Gets description for transition type.
  String _getTypeDescription(PositionedTransitionType type) {
    switch (type) {
      case PositionedTransitionType.slide:
        return 'Dialog slides into position';
      case PositionedTransitionType.slideFade:
        return 'Slides while fading in';
      case PositionedTransitionType.slideScale:
        return 'Slides while scaling up';
      case PositionedTransitionType.slideFadeScale:
        return 'Slides with fade and scale';
      case PositionedTransitionType.fade:
        return 'Fades in at position';
      case PositionedTransitionType.scale:
        return 'Scales up at position';
      case PositionedTransitionType.scaleFade:
        return 'Scales while fading in';
      case PositionedTransitionType.bounce:
        return 'Bouncy elastic entrance';
      case PositionedTransitionType.elastic:
        return 'Elastic overshoot effect';
      case PositionedTransitionType.zoom:
        return 'Smooth zoom with bounce';
    }
  }

  @override
  void initState() {
    super.initState();
    _iconAnimController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _iconAnimController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _iconAnimController.reset();
      _iconAnimController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = _getTypeColor(widget.type);
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkCard.withValues(alpha: 0.6)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _isExpanded
              ? color.withValues(alpha: 0.4)
              : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
          width: _isExpanded ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: _isExpanded
                ? color.withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: isDark ? 0.15 : 0.05),
            blurRadius: _isExpanded ? 16 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header - clickable to expand
          InkWell(
            onTap: _toggle,
            borderRadius: BorderRadius.vertical(
              top: const Radius.circular(18),
              bottom: _isExpanded ? Radius.zero : const Radius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  // Animated transition preview icon
                  _buildAnimatedPreview(color, isDark),
                  const SizedBox(width: 14),
                  // Title and description
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          PositionedConstants.getTransitionLabel(widget.type),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _getTypeDescription(widget.type),
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Position count badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '9',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Expand/collapse icon
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Grid content - expandable
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Column(
                children: [
                  // Separator line
                  Container(
                    height: 1,
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          color.withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  _buildPositionPreviewGrid(context, color, isDark),
                ],
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }

  /// Builds the animated preview showing the transition effect.
  Widget _buildAnimatedPreview(Color color, bool isDark) {
    return AnimatedBuilder(
      animation: _iconAnimController,
      builder: (context, child) {
        final progress = Curves.easeInOut.transform(_iconAnimController.value);

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
          width: 44,
          height: 34,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkBackground
                : AppColors.lightDivider.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Transform.translate(
              offset: Offset(offset.dx * 14, offset.dy * 10),
              child: Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity.clamp(0.0, 1.0),
                  child: Center(
                    child: Container(
                      width: 20,
                      height: 14,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [color, color.withValues(alpha: 0.7)],
                        ),
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.4),
                            blurRadius: 6,
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

  /// Builds a 3x3 grid showing all position combinations.
  Widget _buildPositionPreviewGrid(
    BuildContext context,
    Color typeColor,
    bool isDark,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.0,
      ),
      itemCount: PositionedConstants.allPositions.length,
      itemBuilder: (context, index) {
        final position = PositionedConstants.allPositions[index];
        final posColor = PositionedConstants.getPositionColor(position);

        return _PositionPreviewButton(
          position: position,
          transitionType: widget.type,
          positionColor: posColor,
          isDark: isDark,
          onTap: () => _showCombinationDialog(context, position, posColor),
          onCodeTap: () =>
              widget.onCodeTap(position: position, type: widget.type),
        );
      },
    );
  }

  void _showCombinationDialog(
    BuildContext context,
    DialogPosition position,
    Color color,
  ) {
    SuperDialog.showPositionedDialog<void>(
      context,
      (context) => PositionedInfoCard(
        position:
            '${position.displayName}\n${PositionedConstants.getTransitionLabel(widget.type)}',
        accentColor: color,
      ),
      startPosition: DialogPosition.offScreen,
      endPosition: position,
      transitionType: widget.type,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      barrierBlur: 8,
    );
  }
}

/// Single position preview button within a combination section.
class _PositionPreviewButton extends StatefulWidget {
  const _PositionPreviewButton({
    required this.position,
    required this.transitionType,
    required this.positionColor,
    required this.isDark,
    required this.onTap,
    required this.onCodeTap,
  });

  final DialogPosition position;
  final PositionedTransitionType transitionType;
  final Color positionColor;
  final bool isDark;
  final VoidCallback onTap;
  final VoidCallback onCodeTap;

  @override
  State<_PositionPreviewButton> createState() => _PositionPreviewButtonState();
}

class _PositionPreviewButtonState extends State<_PositionPreviewButton> {
  bool _isHovered = false;

  Alignment _getAlignment() {
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: widget.isDark
              ? AppColors.darkBackground.withValues(alpha: 0.5)
              : AppColors.lightDivider.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? widget.positionColor.withValues(alpha: 0.5)
                : (widget.isDark
                      ? AppColors.darkBorder.withValues(alpha: 0.3)
                      : AppColors.lightBorder.withValues(alpha: 0.5)),
            width: _isHovered ? 1.5 : 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.positionColor.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            // Mini screen preview
            Expanded(
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: widget.isDark
                        ? AppColors.darkCard.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: widget.isDark
                          ? AppColors.darkBorder.withValues(alpha: 0.2)
                          : AppColors.lightBorder.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Position indicator
                      Align(
                        alignment: _getAlignment(),
                        child: Container(
                          margin: const EdgeInsets.all(3),
                          width: _isHovered ? 16 : 12,
                          height: _isHovered ? 10 : 8,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                widget.positionColor,
                                widget.positionColor.withValues(alpha: 0.7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(2),
                            boxShadow: [
                              BoxShadow(
                                color: widget.positionColor.withValues(
                                  alpha: _isHovered ? 0.6 : 0.4,
                                ),
                                blurRadius: _isHovered ? 6 : 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Position name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Text(
                widget.position.displayName.replaceAll(' ', '\n'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  color: _isHovered
                      ? widget.positionColor
                      : (widget.isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary),
                  height: 1.0,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
