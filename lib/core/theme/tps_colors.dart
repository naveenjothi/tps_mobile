import 'package:flutter/material.dart';

/// TPS Design Tokens - Color Palette
///
/// These design tokens map directly to the Tailwind config for web consistency.
/// 2026 "Soft Dark Mode" aesthetic with Electric Cyan and Lilac accents.
class TPSColors {
  TPSColors._();

  // ============================================
  // Base Colors - OLED-optimized dark theme
  // ============================================

  /// 2026 OLED-optimized base - deep charcoal for reduced eye strain
  static const Color charcoal = Color(0xFF0B0D10);

  /// Card and section background - subtle elevation from charcoal
  static const Color surface = Color(0xFF16191D);

  /// Elevated surface for modals, dropdowns
  static const Color surfaceElevated = Color(0xFF1E2227);

  // ============================================
  // Brand Colors - Electric accents
  // ============================================

  /// Primary action color - Electric Cyan
  /// Used for: Primary buttons, toggles, active states, links
  static const Color cyan = Color(0xFF40E0FF);

  /// Secondary accent - Lilac
  /// Used for: Secondary actions, favorites, gradients
  static const Color lilac = Color(0xFFB9A7FF);

  /// Low-emphasis typography and icons
  static const Color muted = Color(0xFF8E95A1);

  // ============================================
  // Text Colors
  // ============================================

  /// Primary text - pure white for high contrast
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Secondary text - slightly muted
  static const Color textSecondary = Color(0xFFE0E4EA);

  /// Tertiary/disabled text
  static const Color textTertiary = Color(0xFF8E95A1);

  // ============================================
  // Semantic Colors
  // ============================================

  /// Success states (e.g., connected, synced)
  static const Color success = Color(0xFF4ADE80);

  /// Warning states (e.g., low signal, buffering)
  static const Color warning = Color(0xFFFBBF24);

  /// Error states (e.g., connection failed, playback error)
  static const Color error = Color(0xFFEF4444);

  /// Info states
  static const Color info = Color(0xFF60A5FA);

  // ============================================
  // Gradient Definitions
  // ============================================

  /// Primary gradient - Electric Cyan
  static const LinearGradient cyanGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [cyan, Color(0xFF20B8E0)],
  );

  /// Secondary gradient - Lilac for Favorites
  static const LinearGradient lilacGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [lilac, Color(0xFF9580FF)],
  );

  /// Surface gradient for glassmorphism
  static const LinearGradient surfaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A1D22), Color(0xFF16191D)],
  );

  // ============================================
  // Opacity Variants
  // ============================================

  /// Cyan with reduced opacity for glow effects
  static Color get cyanGlow => cyan.withValues(alpha: 0.4);

  /// Lilac with reduced opacity for subtle accents
  static Color get lilacGlow => lilac.withValues(alpha: 0.3);

  /// Surface overlay for glassmorphism (70% opacity)
  static Color get surfaceGlass => surface.withValues(alpha: 0.7);

  /// Border color for glass cards
  static Color get glassBorder => Colors.white.withValues(alpha: 0.1);
}
