part of '../../super_dialog.dart';

/// Route and surface settings layered on top of the `super_core` design system.
///
/// Color, spacing, radius, shadow, and motion defaults are sourced directly
/// from `super_core`. Typography is read from the active
/// [core.SuperMaterialThemeData] by dialog surfaces. Apps may still register this extension to
/// override dialog-specific behavior such as barrier blur or transition timing.
@immutable
class SuperDialogThemeData extends ThemeExtension<SuperDialogThemeData> {
  const SuperDialogThemeData({
    required this.backgroundColor,
    required this.surfaceColor,
    required this.inputColor,
    required this.hoverColor,
    required this.borderColor,
    required this.strongBorderColor,
    required this.foregroundColor,
    required this.secondaryForegroundColor,
    required this.tertiaryForegroundColor,
    required this.disabledForegroundColor,
    required this.accentColor,
    required this.barrierColor,
    this.barrierBlur = 0,
    this.config = const SuperDialogConfig.geniusLink(),
    this.controlRadius = 4,
    this.cardRadius = 8,
    this.pillRadius = 12,
    this.dialogWidth = 440,
    this.insetPadding = const EdgeInsets.all(24),
    this.contentPadding = const EdgeInsets.all(24),
    this.shadow = core.SuperThemeData.popShadow,
  });

  final Color backgroundColor;
  final Color surfaceColor;
  final Color inputColor;
  final Color hoverColor;
  final Color borderColor;
  final Color strongBorderColor;
  final Color foregroundColor;
  final Color secondaryForegroundColor;
  final Color tertiaryForegroundColor;
  final Color disabledForegroundColor;
  final Color accentColor;
  final Color barrierColor;
  final double barrierBlur;
  final SuperDialogConfig config;
  final double controlRadius;
  final double cardRadius;
  final double pillRadius;
  final double dialogWidth;
  final EdgeInsets insetPadding;
  final EdgeInsets contentPadding;
  final List<BoxShadow> shadow;

  /// Creates dialog settings from Material and `super_core` theme data.
  factory SuperDialogThemeData.fromSuperTheme(
    ThemeData materialTheme,
    core.SuperThemeData superTheme,
  ) {
    return SuperDialogThemeData(
      backgroundColor: superTheme.bg,
      surfaceColor: superTheme.surface,
      inputColor: superTheme.inputBg,
      hoverColor: superTheme.hover,
      borderColor: superTheme.border,
      strongBorderColor: superTheme.borderStrong,
      foregroundColor: superTheme.fg1,
      secondaryForegroundColor: superTheme.fg2,
      tertiaryForegroundColor: superTheme.fg3,
      disabledForegroundColor: superTheme.fg4,
      accentColor: materialTheme.colorScheme.primary,
      barrierColor: const Color(0x8C000000),
      config: SuperDialogConfig(
        openDuration: superTheme.tokens.durExpand,
        closeDuration: superTheme.tokens.durBase,
        openCurve: superTheme.tokens.curveOut,
        closeCurve: superTheme.tokens.curveStandard,
      ),
      controlRadius: superTheme.spacing.radiusControl,
      cardRadius: superTheme.spacing.radiusCard,
      pillRadius: superTheme.spacing.radiusPill,
      insetPadding: EdgeInsets.all(superTheme.spacing.space6),
      contentPadding: EdgeInsets.all(superTheme.spacing.space6),
    );
  }

  /// Creates dialog settings from a Material theme.
  ///
  /// When [theme] contains the [core.SuperThemeData] extension installed by
  /// [core.SuperMaterialThemeData], its exact active palette and responsive
  /// surfaces are used. Otherwise, Material colors are used as a fallback.
  factory SuperDialogThemeData.fromTheme(ThemeData theme) {
    final superTheme = theme.extension<core.SuperThemeData>();
    if (superTheme != null) {
      return SuperDialogThemeData.fromSuperTheme(theme, superTheme);
    }

    final isDark = theme.brightness == Brightness.dark;
    final preset = isDark ? dark : light;
    final colors = theme.colorScheme;

    return preset.copyWith(
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceColor: colors.surface,
      inputColor: theme.inputDecorationTheme.fillColor ?? preset.inputColor,
      hoverColor: theme.hoverColor,
      borderColor: isDark ? colors.outlineVariant : colors.outline,
      strongBorderColor: isDark ? colors.outline : colors.outlineVariant,
      foregroundColor: colors.onSurface,
      secondaryForegroundColor: colors.onSurfaceVariant,
      tertiaryForegroundColor: theme.hintColor,
      accentColor: colors.primary,
    );
  }

  /// Light preset sourced from [core.SuperThemeData.light].
  static const SuperDialogThemeData light = SuperDialogThemeData(
    backgroundColor: Color(0xFFF7F8FA),
    surfaceColor: Color(0xFFFFFFFF),
    inputColor: Color(0xFFF1F3F8),
    hoverColor: Color(0xFFEEF1F7),
    borderColor: Color(0xFFE2E8F0),
    strongBorderColor: Color(0xFFC2C6D6),
    foregroundColor: Color(0xFF0F172A),
    secondaryForegroundColor: Color(0xFF424754),
    tertiaryForegroundColor: Color(0xFF64748B),
    disabledForegroundColor: Color(0xFFAEB4C2),
    accentColor: Color(0xFF4A7CFF),
    barrierColor: Color(0x8C000000),
  );

  /// Dark preset sourced from [core.SuperThemeData.dark].
  static const SuperDialogThemeData dark = SuperDialogThemeData(
    backgroundColor: Color(0xFF111318),
    surfaceColor: Color(0xFF1E2025),
    inputColor: Color(0xFF33353A),
    hoverColor: Color(0xFF2F3540),
    borderColor: Color(0x6643464F),
    strongBorderColor: Color(0xFF434654),
    foregroundColor: Color(0xFFE2E2E9),
    secondaryForegroundColor: Color(0xFFC3C6D7),
    tertiaryForegroundColor: Color(0xFF8D90A0),
    disabledForegroundColor: Color(0xFF5A5D68),
    accentColor: Color(0xFF4A7CFF),
    barrierColor: Color(0x8C000000),
  );

  /// Reads an explicit dialog extension first, then adapts the active
  /// `super_core`/Material theme automatically.
  static SuperDialogThemeData of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<SuperDialogThemeData>() ??
        SuperDialogThemeData.fromTheme(theme);
  }

  @override
  SuperDialogThemeData copyWith({
    Color? backgroundColor,
    Color? surfaceColor,
    Color? inputColor,
    Color? hoverColor,
    Color? borderColor,
    Color? strongBorderColor,
    Color? foregroundColor,
    Color? secondaryForegroundColor,
    Color? tertiaryForegroundColor,
    Color? disabledForegroundColor,
    Color? accentColor,
    Color? barrierColor,
    double? barrierBlur,
    SuperDialogConfig? config,
    double? controlRadius,
    double? cardRadius,
    double? pillRadius,
    double? dialogWidth,
    EdgeInsets? insetPadding,
    EdgeInsets? contentPadding,
    List<BoxShadow>? shadow,
  }) {
    return SuperDialogThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      inputColor: inputColor ?? this.inputColor,
      hoverColor: hoverColor ?? this.hoverColor,
      borderColor: borderColor ?? this.borderColor,
      strongBorderColor: strongBorderColor ?? this.strongBorderColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      secondaryForegroundColor:
          secondaryForegroundColor ?? this.secondaryForegroundColor,
      tertiaryForegroundColor:
          tertiaryForegroundColor ?? this.tertiaryForegroundColor,
      disabledForegroundColor:
          disabledForegroundColor ?? this.disabledForegroundColor,
      accentColor: accentColor ?? this.accentColor,
      barrierColor: barrierColor ?? this.barrierColor,
      barrierBlur: barrierBlur ?? this.barrierBlur,
      config: config ?? this.config,
      controlRadius: controlRadius ?? this.controlRadius,
      cardRadius: cardRadius ?? this.cardRadius,
      pillRadius: pillRadius ?? this.pillRadius,
      dialogWidth: dialogWidth ?? this.dialogWidth,
      insetPadding: insetPadding ?? this.insetPadding,
      contentPadding: contentPadding ?? this.contentPadding,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  SuperDialogThemeData lerp(
    covariant ThemeExtension<SuperDialogThemeData>? other,
    double t,
  ) {
    if (other is! SuperDialogThemeData) return this;
    return SuperDialogThemeData(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      inputColor: Color.lerp(inputColor, other.inputColor, t)!,
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      strongBorderColor: Color.lerp(
        strongBorderColor,
        other.strongBorderColor,
        t,
      )!,
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t)!,
      secondaryForegroundColor: Color.lerp(
        secondaryForegroundColor,
        other.secondaryForegroundColor,
        t,
      )!,
      tertiaryForegroundColor: Color.lerp(
        tertiaryForegroundColor,
        other.tertiaryForegroundColor,
        t,
      )!,
      disabledForegroundColor: Color.lerp(
        disabledForegroundColor,
        other.disabledForegroundColor,
        t,
      )!,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      barrierColor: Color.lerp(barrierColor, other.barrierColor, t)!,
      barrierBlur: _lerpDouble(barrierBlur, other.barrierBlur, t),
      config: t < 0.5 ? config : other.config,
      controlRadius: _lerpDouble(controlRadius, other.controlRadius, t),
      cardRadius: _lerpDouble(cardRadius, other.cardRadius, t),
      pillRadius: _lerpDouble(pillRadius, other.pillRadius, t),
      dialogWidth: _lerpDouble(dialogWidth, other.dialogWidth, t),
      insetPadding: EdgeInsets.lerp(insetPadding, other.insetPadding, t)!,
      contentPadding: EdgeInsets.lerp(contentPadding, other.contentPadding, t)!,
      shadow: t < 0.5 ? shadow : other.shadow,
    );
  }
}

double _lerpDouble(double a, double b, double t) => a + (b - a) * t;
