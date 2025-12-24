# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-12-24T19:22:21+03:00

### Added

- **SuperDialog** - Core class with static methods for showing animated dialogs
  - `showAnimatedDialog()` - Shows dialog with sensible defaults (barrier dismissible)
  - `showAnimatedGeneralDialog()` - Full control over all dialog options
  - `showAnimatedAdaptiveDialog()` - Platform-adaptive dialog (iOS/macOS vs others)

- **DialogAnimation** enum with 6 animation styles:
  - `startToEnd` - Slides from leading edge (respects RTL)
  - `endToStart` - Slides from trailing edge (respects RTL)
  - `topToBottom` - Drops from top
  - `bottomToTop` - Rises from bottom (iOS default)
  - `centerScale` - Scales from 92% with fade
  - `centerFade` - Simple fade in/out

- **SuperDialogConfig** - Configuration class for animation timing:
  - Customizable open/close durations
  - Customizable open/close curves
  - `copyWith()` method for easy modification
  - Proper `==`, `hashCode`, and `toString()` implementations

- **Barrier Customization**:
  - `barrierDismissible` - Allow/prevent tap-to-dismiss
  - `barrierColor` - Custom barrier tint color
  - `barrierBlur` - Optional Gaussian blur (auto on iOS/macOS)

- **Additional Features**:
  - `onDismissed` callback for dialog lifecycle
  - `useSafeArea` option for notch/taskbar handling
  - `constraints` for dialog size limits
  - `useRootNavigator` for nested navigation support
  - Static `rootKey` for custom root navigator

- **DialogAnimationExtension** - Utility extension methods:
  - `displayName` - Human-readable animation name
  - `isSlide`, `isScale`, `isFadeOnly` - Animation type checks
  - `isHorizontal`, `isVertical` - Direction checks

- **DialogTransitionBuilder** - Reusable transition builder class

- **Example App** - Comprehensive demo with:
  - 18 example scenarios
  - Light/Dark theme support
  - Modern, professional UI design
  - All animation types demonstrated

- **Documentation**:
  - Full API documentation with examples
  - pub.dev style README
  - Code organized using `part` directives

## [0.0.1] - 2025-12-01

### Added
- Initial project setup
- Basic animated dialog implementation (as AnimatedDialog)
