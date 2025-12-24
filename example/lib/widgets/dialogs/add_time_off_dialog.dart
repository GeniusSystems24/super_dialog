import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';

class AddTimeOffDialog extends StatelessWidget {
  const AddTimeOffDialog({super.key, required this.alignment});

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final secondaryColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 35,
              offset: const Offset(0, 24),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: cardColor,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: 680,
            child: Row(
              children: [
                // Left Panel - Form
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // User Header
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: AppColors.primaryGradient,
                                ),
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                child: Text(
                                  'JB',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'James Black',
                                    style: GoogleFonts.inter(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Product Designer',
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: secondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Quota remaining',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: secondaryColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.success.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '46:06:24',
                                    style: GoogleFonts.monoton(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        // Time off types
                        Text(
                          'Time off type',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _TypeTile(label: 'PTO', isPrimary: true),
                            _TypeTile(label: 'Sick Leave'),
                            _TypeTile(label: 'Parent Duty'),
                            _TypeTile(label: 'Covid-19 Family Care'),
                            _TypeTile(label: 'Vacation'),
                            _TypeTile(label: 'Covid-19 Selfcare'),
                          ],
                        ),
                        const SizedBox(height: 26),
                        // Date Selection
                        Row(
                          children: [
                            Expanded(
                              child: _CheckboxRow(
                                label: 'Start - Time off',
                                details: 'Jul 01st, 2022',
                                checked: true,
                                isDark: isDark,
                                textColor: textColor,
                                secondaryColor: secondaryColor,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _CheckboxRow(
                                label: 'Current pay period',
                                details: 'Jul 2022',
                                checked: false,
                                isDark: isDark,
                                textColor: textColor,
                                secondaryColor: secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Divider
                Container(width: 1, color: borderColor),
                // Right Panel - Calendar
                SizedBox(
                  width: 260,
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Current pay period',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: secondaryColor,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.calendar_today_outlined,
                                size: 16,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'July 2022',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _CalendarGrid(
                          highlightedDays: const {1, 2, 3, 4},
                          today: 26,
                          isDark: isDark,
                          textColor: textColor,
                          secondaryColor: secondaryColor,
                          borderColor: borderColor,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: AppColors.accent,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Duration: 4 days',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: secondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.event_available,
                              color: AppColors.success,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Jul 01st - Jul 04th',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: secondaryColor,
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}

class _TypeTile extends StatelessWidget {
  const _TypeTile({required this.label, this.isPrimary = false});

  final String label;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: isPrimary
            ? const LinearGradient(colors: AppColors.primaryGradient)
            : null,
        color: isPrimary ? null : AppColors.lightDivider,
        borderRadius: BorderRadius.circular(12),
        border: isPrimary ? null : Border.all(color: AppColors.lightBorder),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isPrimary ? Colors.white : AppColors.lightTextSecondary,
        ),
      ),
    );
  }
}

class _CheckboxRow extends StatelessWidget {
  const _CheckboxRow({
    required this.label,
    required this.details,
    required this.checked,
    required this.isDark,
    required this.textColor,
    required this.secondaryColor,
  });

  final String label;
  final String details;
  final bool checked;
  final bool isDark;
  final Color textColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: checked
            ? AppColors.primary.withValues(alpha: 0.1)
            : isDark
            ? AppColors.darkBackground
            : AppColors.lightDivider,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: checked
              ? AppColors.primary.withValues(alpha: 0.5)
              : isDark
              ? AppColors.darkBorder
              : AppColors.lightBorder,
          width: checked ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            checked ? Icons.check_circle_rounded : Icons.circle_outlined,
            color: checked ? AppColors.primary : secondaryColor,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: checked ? AppColors.primary : secondaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: textColor,
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

class _CalendarGrid extends StatelessWidget {
  const _CalendarGrid({
    required this.highlightedDays,
    required this.today,
    required this.isDark,
    required this.textColor,
    required this.secondaryColor,
    required this.borderColor,
  });

  final Set<int> highlightedDays;
  final int today;
  final bool isDark;
  final Color textColor;
  final Color secondaryColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final days = List<int>.generate(31, (index) => index + 1);
    const weekdayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekdayLabels
              .map(
                (label) => Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: days.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 4,
            mainAxisSpacing: 6,
          ),
          itemBuilder: (context, index) {
            final day = days[index];
            final isHighlighted = highlightedDays.contains(day);
            final isToday = day == today;

            return _CalendarDay(
              day: day,
              isHighlighted: isHighlighted,
              isToday: isToday,
              isDark: isDark,
              textColor: textColor,
              borderColor: borderColor,
            );
          },
        ),
      ],
    );
  }
}

class _CalendarDay extends StatelessWidget {
  const _CalendarDay({
    required this.day,
    required this.isHighlighted,
    required this.isToday,
    required this.isDark,
    required this.textColor,
    required this.borderColor,
  });

  final int day;
  final bool isHighlighted;
  final bool isToday;
  final bool isDark;
  final Color textColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    Color background = isDark ? AppColors.darkSurface : Colors.white;
    Color border = borderColor.withValues(alpha: 0.5);
    Color dayTextColor = textColor;

    if (isHighlighted) {
      background = AppColors.primary.withValues(alpha: 0.15);
      border = AppColors.primary;
      dayTextColor = AppColors.primary;
    } else if (isToday) {
      background = AppColors.info.withValues(alpha: 0.15);
      border = AppColors.info;
      dayTextColor = AppColors.info;
    }

    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border),
      ),
      alignment: Alignment.center,
      child: Text(
        '$day',
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: dayTextColor,
        ),
      ),
    );
  }
}
