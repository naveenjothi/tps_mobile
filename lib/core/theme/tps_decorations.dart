import 'dart:ui';
import 'package:flutter/material.dart';
import 'tps_colors.dart';

/// TPS Decoration System
///
/// Glassmorphism effects, shadows, and "Bento Box" corners.
/// Creates layered depth without heavy borders.
class TPSDecorations {
  TPSDecorations._();

  // ============================================
  // Border Radius - "Bento Box" corners
  // ============================================

  /// Standard corner radius (1.5rem = 24px)
  static const double borderRadius = 24.0;

  /// Compact corner radius for small elements
  static const double borderRadiusSm = 12.0;

  /// Large corner radius for hero cards
  static const double borderRadiusLg = 32.0;

  /// Pill/capsule shape for buttons and tags
  static const double borderRadiusPill = 100.0;

  /// BorderRadius preset for standard cards
  static BorderRadius get cardBorderRadius =>
      BorderRadius.circular(borderRadius);

  /// Alias for cardBorderRadius (for backward compatibility)
  static BorderRadius get standardBorderRadius => cardBorderRadius;

  /// BorderRadius preset for compact elements
  static BorderRadius get compactBorderRadius =>
      BorderRadius.circular(borderRadiusSm);

  /// BorderRadius preset for large/hero elements
  static BorderRadius get heroBorderRadius =>
      BorderRadius.circular(borderRadiusLg);

  // ============================================
  // Glass Card Decorations
  // ============================================

  /// Standard glassmorphism card
  static BoxDecoration get glassCard => BoxDecoration(
    color: TPSColors.surfaceGlass,
    borderRadius: cardBorderRadius,
    border: Border.all(color: TPSColors.glassBorder),
    boxShadow: standardShadow,
  );

  /// Elevated glass card (modals, dropdowns)
  static BoxDecoration get glassCardElevated => BoxDecoration(
    color: TPSColors.surfaceElevated.withValues(alpha: 0.9),
    borderRadius: cardBorderRadius,
    border: Border.all(color: TPSColors.glassBorder),
    boxShadow: elevatedShadow,
  );

  /// Hero card with gradient border
  static BoxDecoration get heroCard => BoxDecoration(
    gradient: TPSColors.surfaceGradient,
    borderRadius: heroBorderRadius,
    border: Border.all(
      color: TPSColors.cyan.withValues(alpha: 0.2),
      width: 1.5,
    ),
    boxShadow: heroShadow,
  );

  // ============================================
  // Glow Effect Decorations
  // ============================================

  /// Electric Cyan glow for primary buttons
  static BoxDecoration get cyanGlow => BoxDecoration(
    gradient: TPSColors.cyanGradient,
    borderRadius: cardBorderRadius,
    boxShadow: [
      BoxShadow(color: TPSColors.cyanGlow, blurRadius: 16, spreadRadius: 2),
      BoxShadow(
        color: TPSColors.cyan.withValues(alpha: 0.2),
        blurRadius: 32,
        spreadRadius: 4,
      ),
    ],
  );

  /// Lilac glow for favorites/secondary actions
  static BoxDecoration get lilacGlow => BoxDecoration(
    gradient: TPSColors.lilacGradient,
    borderRadius: cardBorderRadius,
    boxShadow: [
      BoxShadow(color: TPSColors.lilacGlow, blurRadius: 16, spreadRadius: 2),
    ],
  );

  /// Subtle glow for active states
  static BoxDecoration glowRing(Color color) => BoxDecoration(
    borderRadius: cardBorderRadius,
    border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
    boxShadow: [
      BoxShadow(
        color: color.withValues(alpha: 0.2),
        blurRadius: 12,
        spreadRadius: 0,
      ),
    ],
  );

  // ============================================
  // Shadow Definitions
  // ============================================

  /// Standard shadow for cards
  static List<BoxShadow> get standardShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  /// Elevated shadow for modals/overlays
  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.4),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  /// Hero shadow for main content cards
  static List<BoxShadow> get heroShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.5),
      blurRadius: 32,
      offset: const Offset(0, 12),
    ),
    BoxShadow(
      color: TPSColors.cyan.withValues(alpha: 0.1),
      blurRadius: 48,
      offset: const Offset(0, 16),
    ),
  ];

  // ============================================
  // Input Decorations
  // ============================================

  /// Standard input field decoration
  static InputDecoration inputDecoration({
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) => InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: TPSColors.muted),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: TPSColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadiusSm),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadiusSm),
      borderSide: BorderSide(color: TPSColors.glassBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadiusSm),
      borderSide: BorderSide(color: TPSColors.cyan, width: 1.5),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );

  // ============================================
  // Backdrop Blur (for true glassmorphism)
  // ============================================

  /// Standard backdrop blur
  static ImageFilter get backdropBlur =>
      ImageFilter.blur(sigmaX: 12, sigmaY: 12);

  /// Light backdrop blur
  static ImageFilter get backdropBlurLight =>
      ImageFilter.blur(sigmaX: 6, sigmaY: 6);

  /// Heavy backdrop blur for overlays
  static ImageFilter get backdropBlurHeavy =>
      ImageFilter.blur(sigmaX: 24, sigmaY: 24);
}
