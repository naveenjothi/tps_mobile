import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/theme.dart';

/// TPS Primary Action Button
///
/// A premium button with Electric Cyan glow effect.
/// Used for primary actions throughout the app.
class TPSButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isCompact;
  final IconData? icon;
  final TPSButtonVariant variant;

  const TPSButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isCompact = false,
    this.icon,
    this.variant = TPSButtonVariant.primary,
  });

  /// Primary action button (Electric Cyan with glow)
  const TPSButton.primary({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isCompact = false,
    this.icon,
  }) : variant = TPSButtonVariant.primary;

  /// Secondary action button (Lilac accent)
  const TPSButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isCompact = false,
    this.icon,
  }) : variant = TPSButtonVariant.secondary;

  /// Ghost/outline button
  const TPSButton.ghost({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isCompact = false,
    this.icon,
  }) : variant = TPSButtonVariant.ghost;

  @override
  State<TPSButton> createState() => _TPSButtonState();
}

class _TPSButtonState extends State<TPSButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: TPSAnimations.glowPulseDuration,
      vsync: this,
    );
    _glowAnimation =
        Tween<double>(
          begin: TPSAnimations.glowPulseMin,
          end: TPSAnimations.glowPulseMax,
        ).animate(
          CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
        );

    if (widget.variant == TPSButtonVariant.primary) {
      _glowController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    HapticFeedback.lightImpact();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isLoading;
    final padding = widget.isCompact
        ? TPSSpacing.buttonPaddingCompact
        : TPSSpacing.buttonPadding;

    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return AnimatedContainer(
          duration: TPSAnimations.quick,
          curve: TPSAnimations.easeOut,
          transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
          decoration: _buildDecoration(isEnabled),
          child: child,
        );
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? widget.onPressed : null,
          onTapDown: isEnabled ? _handleTapDown : null,
          onTapUp: isEnabled ? _handleTapUp : null,
          onTapCancel: isEnabled ? _handleTapCancel : null,
          borderRadius: TPSDecorations.cardBorderRadius,
          splashColor: _getSplashColor(),
          child: Padding(padding: padding, child: _buildContent(isEnabled)),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(bool isEnabled) {
    switch (widget.variant) {
      case TPSButtonVariant.primary:
        return BoxDecoration(
          gradient: isEnabled ? TPSColors.cyanGradient : null,
          color: isEnabled ? null : TPSColors.muted.withValues(alpha: 0.3),
          borderRadius: TPSDecorations.cardBorderRadius,
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: TPSColors.cyan.withValues(
                      alpha: _glowAnimation.value,
                    ),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        );

      case TPSButtonVariant.secondary:
        return BoxDecoration(
          gradient: isEnabled ? TPSColors.lilacGradient : null,
          color: isEnabled ? null : TPSColors.muted.withValues(alpha: 0.3),
          borderRadius: TPSDecorations.cardBorderRadius,
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: TPSColors.lilac.withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        );

      case TPSButtonVariant.ghost:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: TPSDecorations.cardBorderRadius,
          border: Border.all(
            color: isEnabled
                ? TPSColors.cyan
                : TPSColors.muted.withValues(alpha: 0.3),
            width: 1.5,
          ),
        );
    }
  }

  Color _getSplashColor() {
    switch (widget.variant) {
      case TPSButtonVariant.primary:
        return Colors.white.withValues(alpha: 0.2);
      case TPSButtonVariant.secondary:
        return Colors.white.withValues(alpha: 0.2);
      case TPSButtonVariant.ghost:
        return TPSColors.cyan.withValues(alpha: 0.1);
    }
  }

  Color _getForegroundColor(bool isEnabled) {
    if (!isEnabled) return TPSColors.muted;

    switch (widget.variant) {
      case TPSButtonVariant.primary:
      case TPSButtonVariant.secondary:
        return TPSColors.charcoal;
      case TPSButtonVariant.ghost:
        return TPSColors.cyan;
    }
  }

  Widget _buildContent(bool isEnabled) {
    final foregroundColor = _getForegroundColor(isEnabled);

    if (widget.isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(foregroundColor),
        ),
      );
    }

    final textWidget = Text(
      widget.label,
      style: TPSTypography.textTheme.labelLarge?.copyWith(
        color: foregroundColor,
        fontWeight: FontWeight.w600,
      ),
    );

    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, color: foregroundColor, size: 20),
          TPSSpacing.hGapSm,
          textWidget,
        ],
      );
    }

    return textWidget;
  }
}

enum TPSButtonVariant { primary, secondary, ghost }
