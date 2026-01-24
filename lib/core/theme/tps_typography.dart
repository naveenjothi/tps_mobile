import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tps_colors.dart';

/// TPS Typography System
///
/// Uses Google Fonts for premium typography:
/// - Outfit: Headlines and display text (modern, geometric)
/// - Inter: Body text and UI elements (highly readable)
class TPSTypography {
  TPSTypography._();

  // ============================================
  // Font Families
  // ============================================

  /// Headline font family - Outfit
  static String get headlineFamily => GoogleFonts.outfit().fontFamily!;

  /// Body font family - Inter
  static String get bodyFamily => GoogleFonts.inter().fontFamily!;

  // ============================================
  // Complete Text Theme
  // ============================================

  static TextTheme get textTheme => TextTheme(
    // Display styles - Large hero text
    displayLarge: GoogleFonts.outfit(
      fontSize: 57,
      fontWeight: FontWeight.bold,
      color: TPSColors.textPrimary,
      letterSpacing: -0.25,
      height: 1.12,
    ),
    displayMedium: GoogleFonts.outfit(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: TPSColors.textPrimary,
      letterSpacing: 0,
      height: 1.16,
    ),
    displaySmall: GoogleFonts.outfit(
      fontSize: 36,
      fontWeight: FontWeight.w600,
      color: TPSColors.textPrimary,
      letterSpacing: 0,
      height: 1.22,
    ),

    // Headline styles - Section headers
    headlineLarge: GoogleFonts.outfit(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: TPSColors.textPrimary,
      letterSpacing: 0,
      height: 1.25,
    ),
    headlineMedium: GoogleFonts.outfit(
      fontSize: 28,
      fontWeight: FontWeight.w500,
      color: TPSColors.textPrimary,
      letterSpacing: 0,
      height: 1.29,
    ),
    headlineSmall: GoogleFonts.outfit(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: TPSColors.textPrimary,
      letterSpacing: 0,
      height: 1.33,
    ),

    // Title styles - Card headers, list titles
    titleLarge: GoogleFonts.outfit(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: TPSColors.textPrimary,
      letterSpacing: 0,
      height: 1.27,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: TPSColors.textPrimary,
      letterSpacing: 0.15,
      height: 1.5,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: TPSColors.textPrimary,
      letterSpacing: 0.1,
      height: 1.43,
    ),

    // Body styles - Paragraph text
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: TPSColors.textPrimary,
      letterSpacing: 0.5,
      height: 1.5,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: TPSColors.textSecondary,
      letterSpacing: 0.25,
      height: 1.43,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: TPSColors.muted,
      letterSpacing: 0.4,
      height: 1.33,
    ),

    // Label styles - Buttons, tags, metadata
    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: TPSColors.cyan,
      letterSpacing: 0.1,
      height: 1.43,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: TPSColors.textSecondary,
      letterSpacing: 0.5,
      height: 1.33,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: TPSColors.muted,
      letterSpacing: 0.5,
      height: 1.45,
    ),
  );

  // ============================================
  // Custom Text Styles for specific use cases
  // ============================================

  /// Song title in Now Playing view
  static TextStyle get nowPlayingTitle => GoogleFonts.outfit(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: TPSColors.textPrimary,
    letterSpacing: -0.5,
  );

  /// Artist name in Now Playing view
  static TextStyle get nowPlayingArtist => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: TPSColors.muted,
  );

  /// Timestamp labels (current time, duration)
  static TextStyle get timestamp => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: TPSColors.muted,
    fontFeatures: [const FontFeature.tabularFigures()],
  );

  /// Bitrate/quality indicator
  static TextStyle get qualityBadge => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: TPSColors.cyan,
    letterSpacing: 0.5,
  );
}
