import 'package:flutter/material.dart';

/// TPS Spacing System
///
/// Consistent spacing scale for margins, paddings, and gaps.
/// Based on an 8px grid system for visual harmony.
class TPSSpacing {
  TPSSpacing._();

  // ============================================
  // Spacing Scale (8px base)
  // ============================================

  /// 4px - Extra small (icon padding, tight gaps)
  static const double xs = 4.0;

  /// 8px - Small (list item padding, compact spacing)
  static const double sm = 8.0;

  /// 16px - Medium (standard padding, card margins)
  static const double md = 16.0;

  /// 24px - Large (section spacing, generous padding)
  static const double lg = 24.0;

  /// 32px - Extra large (major section gaps)
  static const double xl = 32.0;

  /// 48px - 2X large (page margins, hero spacing)
  static const double xxl = 48.0;

  /// 64px - 3X large (major layout gaps)
  static const double xxxl = 64.0;

  // ============================================
  // EdgeInsets Presets
  // ============================================

  /// Standard card padding
  static const EdgeInsets cardPadding = EdgeInsets.all(md);

  /// Compact card padding for dense layouts
  static const EdgeInsets cardPaddingCompact = EdgeInsets.all(sm);

  /// Page horizontal padding
  static const EdgeInsets pageHorizontal = EdgeInsets.symmetric(horizontal: md);

  /// Page padding with safe area consideration
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: lg,
  );

  /// List item padding
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  /// Button internal padding
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  /// Compact button padding
  static const EdgeInsets buttonPaddingCompact = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  // ============================================
  // Gap Helpers (for Row/Column spacing)
  // ============================================

  /// Extra small gap widget
  static const SizedBox gapXs = SizedBox(width: xs, height: xs);

  /// Small gap widget
  static const SizedBox gapSm = SizedBox(width: sm, height: sm);

  /// Medium gap widget
  static const SizedBox gapMd = SizedBox(width: md, height: md);

  /// Large gap widget
  static const SizedBox gapLg = SizedBox(width: lg, height: lg);

  /// Extra large gap widget
  static const SizedBox gapXl = SizedBox(width: xl, height: xl);

  // ============================================
  // Horizontal Gap Helpers
  // ============================================

  static const SizedBox hGapXs = SizedBox(width: xs);
  static const SizedBox hGapSm = SizedBox(width: sm);
  static const SizedBox hGapMd = SizedBox(width: md);
  static const SizedBox hGapLg = SizedBox(width: lg);
  static const SizedBox hGapXl = SizedBox(width: xl);

  // ============================================
  // Vertical Gap Helpers
  // ============================================

  static const SizedBox vGapXs = SizedBox(height: xs);
  static const SizedBox vGapSm = SizedBox(height: sm);
  static const SizedBox vGapMd = SizedBox(height: md);
  static const SizedBox vGapLg = SizedBox(height: lg);
  static const SizedBox vGapXl = SizedBox(height: xl);
  static const SizedBox vGapXxl = SizedBox(height: xxl);
}
