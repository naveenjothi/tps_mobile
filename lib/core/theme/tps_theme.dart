import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tps_colors.dart';
import 'tps_typography.dart';
import 'tps_decorations.dart';
import 'tps_animations.dart';

/// TPS Theme - Complete ThemeData
///
/// Combines all design tokens into a cohesive Material theme.
/// Optimized for the 2026 "Soft Dark Mode" audiophile aesthetic.
class TPSTheme {
  TPSTheme._();

  /// Dark theme - the primary TPS theme
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // ============================================
    // Core Colors
    // ============================================
    scaffoldBackgroundColor: TPSColors.charcoal,
    canvasColor: TPSColors.charcoal,
    cardColor: TPSColors.surface,

    colorScheme: const ColorScheme.dark(
      primary: TPSColors.cyan,
      onPrimary: TPSColors.charcoal,
      secondary: TPSColors.lilac,
      onSecondary: TPSColors.charcoal,
      surface: TPSColors.surface,
      onSurface: TPSColors.textPrimary,
      error: TPSColors.error,
      onError: Colors.white,
    ),

    // ============================================
    // Typography
    // ============================================
    textTheme: TPSTypography.textTheme,

    // ============================================
    // AppBar Theme
    // ============================================
    appBarTheme: AppBarTheme(
      backgroundColor: TPSColors.charcoal,
      foregroundColor: TPSColors.textPrimary,
      elevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: TPSColors.charcoal,
      ),
      titleTextStyle: TPSTypography.textTheme.headlineSmall,
    ),

    // ============================================
    // Card Theme
    // ============================================
    cardTheme: CardThemeData(
      color: TPSColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: TPSDecorations.cardBorderRadius,
      ),
      margin: EdgeInsets.zero,
    ),

    // ============================================
    // Button Themes
    // ============================================
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: TPSColors.cyan,
        foregroundColor: TPSColors.charcoal,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: TPSDecorations.cardBorderRadius,
        ),
        textStyle: TPSTypography.textTheme.labelLarge?.copyWith(
          color: TPSColors.charcoal,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: TPSColors.cyan,
        side: const BorderSide(color: TPSColors.cyan, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: TPSDecorations.cardBorderRadius,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: TPSColors.cyan,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: TPSDecorations.compactBorderRadius,
        ),
      ),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: TPSColors.textPrimary,
        hoverColor: TPSColors.cyan.withValues(alpha: 0.1),
        highlightColor: TPSColors.cyan.withValues(alpha: 0.2),
      ),
    ),

    // ============================================
    // Input Theme
    // ============================================
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: TPSColors.surface,
      hintStyle: TextStyle(color: TPSColors.muted),
      border: OutlineInputBorder(
        borderRadius: TPSDecorations.compactBorderRadius,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: TPSDecorations.compactBorderRadius,
        borderSide: BorderSide(color: TPSColors.glassBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: TPSDecorations.compactBorderRadius,
        borderSide: const BorderSide(color: TPSColors.cyan, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),

    // ============================================
    // Slider Theme (for seek bars)
    // ============================================
    sliderTheme: SliderThemeData(
      activeTrackColor: TPSColors.cyan,
      inactiveTrackColor: TPSColors.surface,
      thumbColor: TPSColors.cyan,
      overlayColor: TPSColors.cyan.withValues(alpha: 0.2),
      trackHeight: 4,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
    ),

    // ============================================
    // Bottom Navigation Bar Theme
    // ============================================
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: TPSColors.surface,
      selectedItemColor: TPSColors.cyan,
      unselectedItemColor: TPSColors.muted,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    // ============================================
    // Navigation Bar Theme (Material 3)
    // ============================================
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: TPSColors.surface,
      indicatorColor: TPSColors.cyan.withValues(alpha: 0.2),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TPSTypography.textTheme.labelSmall?.copyWith(
            color: TPSColors.cyan,
          );
        }
        return TPSTypography.textTheme.labelSmall?.copyWith(
          color: TPSColors.muted,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: TPSColors.cyan);
        }
        return const IconThemeData(color: TPSColors.muted);
      }),
    ),

    // ============================================
    // Bottom Sheet Theme
    // ============================================
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: TPSColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(TPSDecorations.borderRadius),
        ),
      ),
      dragHandleColor: TPSColors.muted,
      dragHandleSize: const Size(40, 4),
    ),

    // ============================================
    // Dialog Theme
    // ============================================
    dialogTheme: DialogThemeData(
      backgroundColor: TPSColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: TPSDecorations.cardBorderRadius,
      ),
      titleTextStyle: TPSTypography.textTheme.headlineSmall,
      contentTextStyle: TPSTypography.textTheme.bodyMedium,
    ),

    // ============================================
    // Snackbar Theme
    // ============================================
    snackBarTheme: SnackBarThemeData(
      backgroundColor: TPSColors.surfaceElevated,
      contentTextStyle: TPSTypography.textTheme.bodyMedium,
      shape: RoundedRectangleBorder(
        borderRadius: TPSDecorations.compactBorderRadius,
      ),
      behavior: SnackBarBehavior.floating,
    ),

    // ============================================
    // Divider Theme
    // ============================================
    dividerTheme: DividerThemeData(
      color: TPSColors.glassBorder,
      thickness: 1,
      space: 1,
    ),

    // ============================================
    // List Tile Theme
    // ============================================
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      tileColor: Colors.transparent,
      selectedTileColor: TPSColors.cyan.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: TPSDecorations.compactBorderRadius,
      ),
    ),

    // ============================================
    // Chip Theme
    // ============================================
    chipTheme: ChipThemeData(
      backgroundColor: TPSColors.surface,
      selectedColor: TPSColors.cyan,
      labelStyle: TPSTypography.textTheme.labelMedium,
      side: BorderSide(color: TPSColors.glassBorder),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TPSDecorations.borderRadiusSm),
      ),
    ),

    // ============================================
    // Progress Indicator Theme
    // ============================================
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: TPSColors.cyan,
      linearTrackColor: TPSColors.surface,
      circularTrackColor: TPSColors.surface,
    ),

    // ============================================
    // Switch Theme
    // ============================================
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TPSColors.cyan;
        }
        return TPSColors.muted;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TPSColors.cyan.withValues(alpha: 0.3);
        }
        return TPSColors.surface;
      }),
    ),

    // ============================================
    // Page Transitions
    // ============================================
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: _TPSPageTransitionsBuilder(),
        TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}

/// Custom page transitions builder for "Calm UI" animations
class _TPSPageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return TPSAnimations.fadeTransition(
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
