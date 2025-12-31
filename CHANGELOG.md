# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.0] - 2025-12-31

### Added

- **18 New Animation Types** - Massive expansion of animation options:

  **Rotation Animations:**
  - `rotateIn` - Rotates in with fade effect (-15° to 0°)
  - `rotateScale` - Combines rotation with scale (0.7 to 1.0)

  **Bounce Animations:**
  - `bounceIn` - Elastic bounce scale effect
  - `bounceSlidBottom` - Slides from bottom with bounce curve

  **Elastic Animations:**
  - `elasticIn` - Elastic scale with overshoot effect
  - `elasticSlideBottom` - Slides up with elastic overshoot

  **Expand Animations:**
  - `expandVertical` - Expands from center vertically
  - `expandHorizontal` - Expands from center horizontally
  - `expandCenter` - Expands uniformly from center

  **Flip Animations:**
  - `flipHorizontal` - 3D flip around X-axis
  - `flipVertical` - 3D flip around Y-axis

  **Combined Animations:**
  - `slideRotateBottom` - Slide from bottom with rotation
  - `slideRotateTop` - Slide from top with rotation
  - `slideScaleStart` - Slide from start with scale
  - `slideScaleEnd` - Slide from end with scale

- **Enhanced Animation Extension Methods:**
  - `isRotation` - Check if animation involves rotation
  - `isElastic` - Check if animation uses elastic/bounce curves
  - Updated `isSlide` and `isScale` to include new animation types

- **3 New PositionedTransitionType Options:**
  - `bounce` - Bouncy entrance with elastic curve for positioned dialogs
  - `elastic` - Elastic overshoot effect (scale 0.5 to 1.0)
  - `zoom` - Smooth zoom with ease-out curve (scale 0.88 to 1.0)
  - Total positioned combinations now: **90** (9 positions × 10 transition types)

- **Complete Example Coverage:**
  - Added 36+ new example scenarios covering all 24 animation types
  - Every DialogAnimation type now has multiple real-world use cases
  - Enhanced Transform tab with all rotation, bounce, elastic, expand, flip, and combined animations

### Improved

- **Example App Enhancements:**
  - Migrated to `go_router` for modern, declarative routing
  - Added `go_router_builder` for type-safe navigation
  - Significantly improved card design with:
    - Enhanced hover effects with gradient backgrounds
    - Better shadow system with multiple layers
    - Improved typography with better spacing and weights
    - Smoother animations and transitions
    - More prominent accent color highlighting

- **Better Organization:**
  - Categorized all animations in enum with clear section comments
  - Improved documentation with use cases for each animation type
  - Enhanced code structure for better maintainability

### Documentation

- Updated README with all new animation types
- Expanded animation descriptions with visual effects details
- Added comprehensive examples for new animations
- Updated package description to reflect new capabilities

## [0.2.0] - 2025-12-24T19:52:58+03:00

### Added

- **DialogPosition** enum with 10 positions for fine-grained control:
  - `topStart`, `topCenter`, `topEnd`
  - `centerStart`, `center`, `centerEnd`
  - `bottomStart`, `bottomCenter`, `bottomEnd`
  - `offScreen` - For slide-in from outside the screen

- **showPositionedDialog()** - New method for custom position transitions:
  - Define exact start and end positions on a 3x3 grid
  - Multiple transition types: slide, fade, scale, or combinations

- **PositionedTransitionType** enum:
  - `slide`, `slideFade`, `slideScale`, `slideFadeScale`
  - `fade`, `scale`, `scaleFade`

- **DialogPositionExtension** - Utility extension methods:
  - `toAlignment()` - Convert to Alignment
  - `toAlignmentDirectional()` - Convert to AlignmentDirectional (RTL-aware)
  - `toSlideOffset()` - Convert to Offset for sliding
  - `displayName` - Human-readable name
  - `isTop`, `isBottom`, `isStart`, `isEnd`, etc.

- **PositionedDialogTransitionBuilder** - Reusable builder for positioned transitions

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

