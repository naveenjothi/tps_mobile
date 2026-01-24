import 'package:flutter/material.dart';

/// TPS Animation System
///
/// "Calm UI" animation specifications to reduce user anxiety.
/// Soft, deliberate transitions that feel premium and unhurried.
class TPSAnimations {
  TPSAnimations._();

  // ============================================
  // Duration Constants
  // ============================================

  /// Quick micro-interactions (hover effects, icon changes)
  static const Duration quick = Duration(milliseconds: 150);

  /// Standard transitions (page transitions, card reveals)
  /// This is the "Calm UI" default - 300ms for soft fades
  static const Duration standard = Duration(milliseconds: 300);

  /// Slow, deliberate animations (major state changes)
  static const Duration slow = Duration(milliseconds: 500);

  /// Extended animations (onboarding, celebrations)
  static const Duration extended = Duration(milliseconds: 800);

  // ============================================
  // Curve Definitions
  // ============================================

  /// Default ease out for natural deceleration
  static const Curve easeOut = Curves.easeOutCubic;

  /// Ease in-out for reversible animations
  static const Curve easeInOut = Curves.easeInOutCubic;

  /// Ease in for exit animations
  static const Curve easeIn = Curves.easeInCubic;

  /// Spring-like curve for playful interactions
  static const Curve spring = Curves.elasticOut;

  /// Smooth deceleration for scroll-like motion
  static const Curve decelerate = Curves.decelerate;

  // ============================================
  // Page Transition Builders
  // ============================================

  /// Calm fade transition for Dashboard ↔ Song view
  static Widget fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: easeOut),
      child: child,
    );
  }

  /// Slide up transition for modals and bottom sheets
  static Widget slideUpTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: easeOut));

    return SlideTransition(
      position: offsetAnimation,
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  /// Scale transition for dialogs and popups
  static Widget scaleTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(parent: animation, curve: easeOut));

    return ScaleTransition(
      scale: scaleAnimation,
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  // ============================================
  // Reusable Animation Configurations
  // ============================================

  /// Standard implicit animation for widgets
  static const implicitAnimationDuration = standard;
  static const implicitAnimationCurve = easeOut;

  /// Stagger delay for list item animations
  static Duration staggerDelay(int index) {
    return Duration(milliseconds: 50 * index);
  }

  /// Maximum stagger delay to prevent long waits
  static const Duration maxStaggerDelay = Duration(milliseconds: 400);

  // ============================================
  // Glow Animation Values
  // ============================================

  /// Pulse animation for glow effects (min opacity)
  static const double glowPulseMin = 0.3;

  /// Pulse animation for glow effects (max opacity)
  static const double glowPulseMax = 0.6;

  /// Glow pulse duration
  static const Duration glowPulseDuration = Duration(milliseconds: 1500);
}
