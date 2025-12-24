import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TimeOffDetailsDialog extends StatelessWidget {
  const TimeOffDetailsDialog({
    super.key,
    this.alignment = Alignment.center,
    this.widthFactor,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
  });

  final AlignmentGeometry alignment;
  final double? widthFactor;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    Widget dialog = Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(0, 20),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Material(
          color: cardColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Accent Bar
              Container(
                height: 6,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: AppColors.primaryGradient),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 24, 28, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Time off details',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: borderColor.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.all(8),
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: Icon(Icons.close_rounded, color: secondaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Employee Card
                    _EmployeeSummary(
                      isDark: isDark,
                      textColor: textColor,
                      secondaryColor: secondaryColor,
                      borderColor: borderColor,
                    ),
                    const SizedBox(height: 24),
                    // Info Grid
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _InfoColumn(
                            title: 'Time off type',
                            value: 'PTO',
                            accentColor: AppColors.primary,
                            textColor: textColor,
                            secondaryColor: secondaryColor,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _InfoColumn(
                            title: 'Time off date',
                            value: 'Jul 01st - Jul 04th, 2022',
                            accentColor: AppColors.success,
                            textColor: textColor,
                            secondaryColor: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _InfoColumn(
                      title: 'Duration',
                      value: '3 days',
                      accentColor: AppColors.accent,
                      textColor: textColor,
                      secondaryColor: secondaryColor,
                    ),
                    const SizedBox(height: 24),
                    _ReasonCard(
                      title: 'Time off reason',
                      value: 'I need to visit my family wedding',
                      isDark: isDark,
                      textColor: textColor,
                      secondaryColor: secondaryColor,
                      borderColor: borderColor,
                    ),
                  ],
                ),
              ),
              // Divider
              Divider(height: 1, color: borderColor),
              // Actions
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                      ),
                      child: const Text('Reject'),
                    ),
                    const SizedBox(width: 12),
                    FilledButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      child: const Text('Approve'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (widthFactor != null) {
      dialog = FractionallySizedBox(widthFactor: widthFactor, child: dialog);
    }

    return Align(alignment: alignment, child: dialog);
  }
}

class _EmployeeSummary extends StatelessWidget {
  const _EmployeeSummary({
    required this.isDark,
    required this.textColor,
    required this.secondaryColor,
    required this.borderColor,
  });

  final bool isDark;
  final Color textColor;
  final Color secondaryColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.08),
            AppColors.primaryLight.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: AppColors.primaryGradient),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              child: Text('JD', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jack Dylen',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'UI/UX Designer',
                  style: TextStyle(fontSize: 14, color: secondaryColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Pending',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  const _InfoColumn({
    required this.title,
    required this.value,
    required this.accentColor,
    required this.textColor,
    required this.secondaryColor,
  });

  final String title;
  final String value;
  final Color accentColor;
  final Color textColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 4,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: secondaryColor,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }
}

class _ReasonCard extends StatelessWidget {
  const _ReasonCard({
    required this.title,
    required this.value,
    required this.isDark,
    required this.textColor,
    required this.secondaryColor,
    required this.borderColor,
  });

  final String title;
  final String value;
  final bool isDark;
  final Color textColor;
  final Color secondaryColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: secondaryColor,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkBackground : AppColors.lightDivider,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor.withValues(alpha: 0.5)),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: textColor, height: 1.5),
          ),
        ),
      ],
    );
  }
}
