import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_core/super_core.dart' as core;
import 'package:super_navigation_sidebar/super_navigation_sidebar.dart';

/// Shared aliases for the GeniusLink palette used by `super_core`.
abstract final class AppColors {
  static const Color primary = Color(0xFF4A7CFF);

  static const Color accent = Color(0xFFF97316);
  static const Color accentLight = Color(0xFFFBBF24);

  static const Color success = Color(0xFF1DB88A);
  static const Color warning = Color(0xFFF97316);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF4A7CFF);
  static const Color purple = Color(0xFF7C5CFC);
  static const Color teal = Color(0xFF1DB88A);

  static const Color lightBackground = Color(0xFFF7F8FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightInput = Color(0xFFF1F3F8);
  static const Color lightHover = Color(0xFFEEF1F7);
  static const Color lightText = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightBorderStrong = Color(0xFFC2C6D6);
  static const Color lightDivider = Color(0xFFEEF1F7);

  static const Color darkBackground = Color(0xFF111318);
  static const Color darkSurface = Color(0xFF1E2025);
  static const Color darkCard = Color(0xFF1E2025);
  static const Color darkSurface2 = Color(0xFF292D38);
  static const Color darkInput = Color(0xFF33353A);
  static const Color darkHover = Color(0xFF2F3540);
  static const Color darkText = Color(0xFFE2E2E9);
  static const Color darkTextSecondary = Color(0xFF8D90A0);
  static const Color darkBorder = Color(0x6643464F);
  static const Color darkBorderStrong = Color(0xFF434654);
  static const Color darkDivider = Color(0xFF2F3540);
}

abstract final class AppRadii {
  static const double control = 4;
  static const double medium = 6;
  static const double card = 8;
  static const double pill = 12;
}

abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

abstract final class AppTheme {
  static ThemeData get light => _build(
        Brightness.light,
        mode: core.SuperDeviceMode.mobile,
      );

  static ThemeData get dark => _build(
        Brightness.dark,
        mode: core.SuperDeviceMode.mobile,
      );

  static ThemeData forWidth(Brightness brightness, double width) => _build(
        brightness,
        mode: core.SuperDeviceMode.forWidth(width),
      );

  static ThemeData _build(
    Brightness brightness, {
    required core.SuperDeviceMode mode,
  }) {
    final isDark = brightness == Brightness.dark;
    final core.SuperMaterialThemeData base = isDark
        ? core.SuperMaterialThemeData.dark(
            palette: core.SuperPalette.bluePalette,
            mode: mode,
          )
        : core.SuperMaterialThemeData.light(
            palette: core.SuperPalette.bluePalette,
            mode: mode,
          );
    final textTheme = _buildTextTheme(base.textTheme);
    final navigationTheme =
        NavigationSidebarThemeData.fromMaterialTheme(base).copyWith(
      selectionIndicator: NavSelectionIndicator.bar,
      widthExpanded: 264,
      widthRail: 72,
      widthDrawer: 304,
      radiusSm: AppRadii.control,
      radiusMd: AppRadii.medium,
      radiusLg: AppRadii.card,
      radiusXl: AppRadii.pill,
    );
    return base.copyWith(
      extensions: <ThemeExtension<dynamic>>[navigationTheme],
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor:
            isDark ? AppColors.darkSurface : AppColors.lightSurface,
        foregroundColor: isDark ? AppColors.darkText : AppColors.lightText,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 16,
          height: 1.3,
          fontWeight: FontWeight.w700,
          color: isDark ? AppColors.darkText : AppColors.lightText,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(0, 40)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.control),
            ),
          ),
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(0, 40)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16),
          ),
          side: WidgetStatePropertyAll(
            BorderSide(
              color: isDark
                  ? AppColors.darkBorderStrong
                  : AppColors.lightBorderStrong,
            ),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.control),
            ),
          ),
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          fixedSize: const Size.square(32),
          minimumSize: const Size.square(32),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.control),
          ),
        ),
      ),
      scaffoldBackgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      cardTheme: CardThemeData(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
          side: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.darkInput : AppColors.lightInput,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        hintStyle: textTheme.bodySmall?.copyWith(
          color: isDark
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary,
        ),
        prefixIconColor: isDark
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary,
        suffixIconColor: isDark
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.control),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.control),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.control),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: isDark ? AppColors.darkInput : AppColors.lightInput,
        selectedColor: AppColors.primary.withValues(alpha: 0.12),
        side: BorderSide(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        labelStyle: textTheme.labelSmall,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      ),
      tabBarTheme: base.tabBarTheme.copyWith(
        dividerColor: Colors.transparent,
        labelStyle: textTheme.labelLarge,
        unselectedLabelStyle: textTheme.labelLarge,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: const WidgetStatePropertyAll(false),
        thickness: const WidgetStatePropertyAll(6),
        radius: const Radius.circular(AppRadii.pill),
        thumbColor: WidgetStatePropertyAll(
          (isDark ? AppColors.darkBorderStrong : AppColors.lightBorderStrong)
              .withValues(alpha: 0.72),
        ),
      ),
      snackBarTheme: base.snackBarTheme.copyWith(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    final inter = GoogleFonts.interTextTheme(base);
    return inter.copyWith(
      headlineLarge: GoogleFonts.manrope(
        textStyle: inter.headlineLarge,
        fontSize: 26,
        height: 1.15,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.65,
      ),
      headlineMedium: GoogleFonts.manrope(
        textStyle: inter.headlineMedium,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: GoogleFonts.inter(
        textStyle: inter.headlineSmall,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: GoogleFonts.inter(
        textStyle: inter.titleLarge,
        fontSize: 16,
        height: 1.3,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: GoogleFonts.inter(
        textStyle: inter.titleMedium,
        fontSize: 14,
        height: 1.4,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.inter(
        textStyle: inter.bodyLarge,
        fontSize: 14,
        height: 1.45,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.inter(
        textStyle: inter.bodyMedium,
        fontSize: 14,
        height: 1.45,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.inter(
        textStyle: inter.bodySmall,
        fontSize: 12,
        height: 1.35,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: GoogleFonts.inter(
        textStyle: inter.labelLarge,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: GoogleFonts.inter(
        textStyle: inter.labelMedium,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.55,
      ),
    );
  }
}
