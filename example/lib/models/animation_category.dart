import 'package:flutter/material.dart';
import 'package:super_dialog/super_dialog.dart';

/// Represents an animation category with associated animations.
class AnimationCategory {
  final String title;
  final IconData icon;
  final List<DialogAnimation> animations;

  const AnimationCategory({
    required this.title,
    required this.icon,
    required this.animations,
  });
}
