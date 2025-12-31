import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';
import '../../models/positioned_constants.dart';
import '../../theme/app_theme.dart';
import 'position_button.dart';

/// Premium position grid with visual screen representation.
class PositionGrid extends StatelessWidget {
  const PositionGrid({super.key, required this.onCodeTap});

  final void Function(DialogPosition position) onCodeTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkCard.withValues(alpha: 0.6)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? AppColors.darkBorder.withValues(alpha: 0.5)
              : AppColors.lightBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Device mockup header (like a browser/app window)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [AppColors.darkSurface, AppColors.darkBackground]
                    : [AppColors.lightDivider, AppColors.lightBackground],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Window controls (macOS style)
                Row(
                  children: [
                    _buildWindowDot(const Color(0xFFFF5F57)),
                    const SizedBox(width: 6),
                    _buildWindowDot(const Color(0xFFFFBD2E)),
                    const SizedBox(width: 6),
                    _buildWindowDot(const Color(0xFF28CA41)),
                  ],
                ),
                const Spacer(),
                // Title
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.crop_square_rounded,
                      size: 14,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Screen Positions',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Placeholder for symmetry
                const SizedBox(width: 60),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Guide text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.touch_app_rounded,
                size: 14,
                color: isDark
                    ? AppColors.darkTextSecondary.withValues(alpha: 0.7)
                    : AppColors.lightTextSecondary.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 6),
              Text(
                'Tap a position to see the dialog appear there',
                style: TextStyle(
                  fontSize: 11,
                  color: isDark
                      ? AppColors.darkTextSecondary.withValues(alpha: 0.7)
                      : AppColors.lightTextSecondary.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // 3x3 Position Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.95,
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
      ),
    );
  }

  Widget _buildWindowDot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
