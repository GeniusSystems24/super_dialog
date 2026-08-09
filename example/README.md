# Super Dialog example

This showcase uses `super_core ^3.3.0` for the GeniusLink design system and
`go_router_builder` for generated, strongly typed navigation. The app constructs
`SuperTextTheme` explicitly before building each light/dark material theme.

The visual system includes:

- the blue `SuperPalette.bluePalette` accent;
- shared light and dark neutral surfaces;
- Inter and Manrope typography;
- a 4px spacing rhythm and compact 4/8/12px radii;
- restrained borders, shadows, barriers, and motion.

Run it with Flutter 3.38 or newer:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```
