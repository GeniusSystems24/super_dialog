import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';
import '../models/example_scenario.dart';
import '../theme/app_theme.dart';
import 'dialogs/code_viewer_dialog.dart';

class ExampleCard extends StatefulWidget {
  const ExampleCard({super.key, required this.scenario, required this.onTap});

  final ExampleScenario scenario;
  final VoidCallback onTap;

  @override
  State<ExampleCard> createState() => _ExampleCardState();
}

class _ExampleCardState extends State<ExampleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) => _controller.forward();
  void _onTapUp(TapUpDetails details) => _controller.reverse();
  void _onTapCancel() => _controller.reverse();

  void _showCodeDialog() {
    final code = widget.scenario.generatedCodeSnippet;
    if (code.isNotEmpty) {
      SuperDialog.showAnimatedDialog<void>(
        context,
        (context) => CodeViewerDialog(
          title: widget.scenario.title,
          code: code,
          accentColor: widget.scenario.accentColor,
        ),
        animation: DialogAnimation.centerScale,
        barrierDismissible: true,
        barrierColor: Colors.black.withValues(alpha: 0.6),
        barrierBlur: 5,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final hasCode = widget.scenario.generatedCodeSnippet.isNotEmpty;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onTap,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _isHovered
                    ? widget.scenario.accentColor.withValues(alpha: 0.6)
                    : borderColor.withValues(alpha: 0.3),
                width: _isHovered ? 2.5 : 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? widget.scenario.accentColor.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.06),
                  blurRadius: _isHovered ? 24 : 12,
                  offset: Offset(0, _isHovered ? 10 : 6),
                  spreadRadius: _isHovered ? 2 : 0,
                ),
                if (_isHovered)
                  BoxShadow(
                    color: widget.scenario.accentColor.withValues(alpha: 0.1),
                    blurRadius: 40,
                    offset: const Offset(0, 15),
                    spreadRadius: 4,
                  ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  // Icon Container with Gradient
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: _isHovered
                          ? LinearGradient(
                              colors: [
                                widget.scenario.accentColor.withValues(
                                  alpha: 0.2,
                                ),
                                widget.scenario.accentColor.withValues(
                                  alpha: 0.1,
                                ),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color: _isHovered
                          ? null
                          : widget.scenario.accentColor.withValues(
                              alpha: 0.12,
                            ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: _isHovered
                          ? [
                              BoxShadow(
                                color: widget.scenario.accentColor.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      widget.scenario.icon,
                      color: widget.scenario.accentColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.scenario.title,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                gradient: _isHovered
                                    ? LinearGradient(
                                        colors: [
                                          widget.scenario.accentColor
                                              .withValues(alpha: 0.15),
                                          widget.scenario.accentColor
                                              .withValues(alpha: 0.08),
                                        ],
                                      )
                                    : null,
                                color: _isHovered
                                    ? null
                                    : widget.scenario.accentColor.withValues(
                                        alpha: 0.12,
                                      ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: widget.scenario.accentColor
                                      .withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                widget.scenario.animationLabel,
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: widget.scenario.accentColor,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.scenario.description,
                          style: TextStyle(
                            fontSize: 13.5,
                            color: secondaryColor,
                            height: 1.5,
                            letterSpacing: -0.1,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // View Code Button
                  if (hasCode)
                    Material(
                      color: Colors.transparent,
                      child: Tooltip(
                        message: 'View Code',
                        child: InkWell(
                          onTap: _showCodeDialog,
                          borderRadius: BorderRadius.circular(10),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _isHovered
                                  ? widget.scenario.accentColor.withValues(
                                      alpha: 0.1,
                                    )
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.code_rounded,
                              size: 20,
                              color: _isHovered
                                  ? widget.scenario.accentColor
                                  : secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(width: 4),
                  // Arrow
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _isHovered
                          ? widget.scenario.accentColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: _isHovered ? Colors.white : secondaryColor,
                    ),
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
