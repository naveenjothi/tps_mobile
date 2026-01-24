import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// TPS Glass Card
///
/// A glassmorphism card with backdrop blur and subtle borders.
/// Creates layered depth without heavy shadows.
class TPSCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final TPSCardVariant variant;
  final bool enableBlur;

  const TPSCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.variant = TPSCardVariant.standard,
    this.enableBlur = false,
  });

  /// Standard surface card
  const TPSCard.surface({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.enableBlur = false,
  }) : variant = TPSCardVariant.standard;

  /// Elevated card for modals and important content
  const TPSCard.elevated({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.enableBlur = true,
  }) : variant = TPSCardVariant.elevated;

  /// Hero card with subtle cyan accent
  const TPSCard.hero({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.enableBlur = true,
  }) : variant = TPSCardVariant.hero;

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ?? TPSSpacing.cardPadding;

    Widget cardContent = Container(
      padding: effectivePadding,
      decoration: _buildDecoration(),
      child: child,
    );

    // Apply backdrop blur if enabled
    if (enableBlur) {
      cardContent = ClipRRect(
        borderRadius: _getBorderRadius(),
        child: BackdropFilter(
          filter: TPSDecorations.backdropBlur,
          child: cardContent,
        ),
      );
    }

    // Wrap with tap handler if provided
    if (onTap != null) {
      cardContent = _TappableCard(
        onTap: onTap!,
        borderRadius: _getBorderRadius(),
        child: cardContent,
      );
    }

    // Apply margin if provided
    if (margin != null) {
      cardContent = Padding(padding: margin!, child: cardContent);
    }

    return cardContent;
  }

  BorderRadius _getBorderRadius() {
    switch (variant) {
      case TPSCardVariant.hero:
        return TPSDecorations.heroBorderRadius;
      default:
        return TPSDecorations.cardBorderRadius;
    }
  }

  BoxDecoration _buildDecoration() {
    switch (variant) {
      case TPSCardVariant.standard:
        return TPSDecorations.glassCard;

      case TPSCardVariant.elevated:
        return TPSDecorations.glassCardElevated;

      case TPSCardVariant.hero:
        return TPSDecorations.heroCard;
    }
  }
}

/// Internal tappable wrapper for cards
class _TappableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final BorderRadius borderRadius;

  const _TappableCard({
    required this.child,
    required this.onTap,
    required this.borderRadius,
  });

  @override
  State<_TappableCard> createState() => _TappableCardState();
}

class _TappableCardState extends State<_TappableCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: TPSAnimations.quick,
        curve: TPSAnimations.easeOut,
        child: AnimatedOpacity(
          opacity: _isPressed ? 0.9 : 1.0,
          duration: TPSAnimations.quick,
          child: widget.child,
        ),
      ),
    );
  }
}

enum TPSCardVariant { standard, elevated, hero }

/// TPS Bento Grid
///
/// A modular grid layout for dashboard-style interfaces.
/// Supports variable-sized cards in a flexible grid.
class TPSBentoGrid extends StatelessWidget {
  final List<TPSBentoItem> items;
  final double spacing;
  final int crossAxisCount;

  const TPSBentoGrid({
    super.key,
    required this.items,
    this.spacing = TPSSpacing.md,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - spacing * (crossAxisCount - 1)) /
            crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: items.map((item) {
            final width = item.spanColumns > 1
                ? itemWidth * item.spanColumns +
                      spacing * (item.spanColumns - 1)
                : itemWidth;

            return SizedBox(
              width: width,
              height: item.height,
              child: item.child,
            );
          }).toList(),
        );
      },
    );
  }
}

/// Item configuration for TPSBentoGrid
class TPSBentoItem {
  final Widget child;
  final int spanColumns;
  final double height;

  const TPSBentoItem({
    required this.child,
    this.spanColumns = 1,
    this.height = 160,
  });

  /// Large card spanning full width
  const TPSBentoItem.large({required this.child, this.height = 200})
    : spanColumns = 2;

  /// Standard single-column card
  const TPSBentoItem.standard({required this.child, this.height = 160})
    : spanColumns = 1;

  /// Tall single-column card
  const TPSBentoItem.tall({required this.child, this.height = 240})
    : spanColumns = 1;
}
