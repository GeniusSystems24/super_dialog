# Design-system alignment

The package and its example app are aligned to the `super_core` design system
using the published [`super_core`](https://pub.dev/packages/super_core) package.

## Source mapping

| Super Dialog implementation | `super_core` source |
|---|---|
| Accent and semantic colors | `lib/src/core/theme/super_tokens.dart` |
| Light/dark surface ramps | `lib/src/core/theme/super_palette.dart` |
| 4/8/12px radii and 4px spacing scale | `lib/src/core/theme/super_tokens.dart` |
| Manrope / Inter / JetBrains Mono typography | `lib/src/core/theme/super_text_styles.dart` |
| Dialog surface, header, spacing and overlay shadow | `lib/src/core/widgets/super_dialog.dart` |
| Material component themes | `lib/src/core/theme/super_material_theme.dart` |

## Local integration

- `super_dialog` depends directly on `super_core ^3.3.0` and reads its public
  tokens and `SuperThemeData` extension at runtime.
- `SuperDialogSurface` provides a package-native dialog body that follows the
  same header, border, radius, padding and action layout. Typography comes from
  the active `SuperMaterialThemeData.textTheme`; `SuperThemeData` no longer owns
  a text theme. A plain Material `TextTheme` remains the fallback.
- The example app builds a responsive `SuperTextTheme` first and passes it to
  both required typography fields on `SuperMaterialThemeData`; the dialog
  adapter inherits the active palette automatically.
- Explicit route arguments still override theme defaults.
