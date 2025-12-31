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

class _ExampleCardState extends State<ExampleCard> {
  bool _isHovered = false;

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
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A1A);
    final secondaryColor = isDark
        ? const Color(0xFFB0B0B0)
        : const Color(0xFF666666);
    final borderColor = isDark
        ? const Color(0xFF2A2A2A)
        : const Color(0xFFE0E0E0);

    final hasCode = widget.scenario.generatedCodeSnippet.isNotEmpty;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isHovered
                    ? widget.scenario.accentColor.withValues(alpha: 0.5)
                    : borderColor,
                width: 1,
              ),
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Simple Icon Container
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: widget.scenario.accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    widget.scenario.icon,
                    color: widget.scenario.accentColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
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
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                                height: 1.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: widget.scenario.accentColor.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              widget.scenario.animationLabel,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: widget.scenario.accentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.scenario.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: secondaryColor,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Action Icons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (hasCode)
                      IconButton(
                        onPressed: _showCodeDialog,
                        icon: Icon(
                          Icons.code_rounded,
                          size: 20,
                          color: secondaryColor,
                        ),
                        tooltip: 'View Code',
                        visualDensity: VisualDensity.compact,
                      ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                      color: secondaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
