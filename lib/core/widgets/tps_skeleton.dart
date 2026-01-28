import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/theme.dart';

/// TPS Skeleton Widget
///
/// Base skeleton with shimmer animation for loading states.
class TPSSkeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final bool circle;

  const TPSSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.circle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: TPSColors.surface,
      highlightColor: TPSColors.surface.withValues(alpha: 0.5),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: TPSColors.surface,
          borderRadius: circle
              ? null
              : (borderRadius ?? TPSDecorations.compactBorderRadius),
          shape: circle ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }
}

/// Skeleton for stat cards on the dashboard.
class TPSStatCardSkeleton extends StatelessWidget {
  const TPSStatCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TPSSpacing.cardPadding,
      decoration: BoxDecoration(
        color: TPSColors.surface,
        borderRadius: TPSDecorations.standardBorderRadius,
        border: Border.all(color: TPSColors.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TPSSkeleton(width: 40, height: 40),
          const Spacer(),
          const TPSSkeleton(width: 60, height: 24),
          TPSSpacing.vGapXs,
          const TPSSkeleton(width: 80, height: 12),
        ],
      ),
    );
  }
}

/// Skeleton for song cards.
class TPSSongCardSkeleton extends StatelessWidget {
  const TPSSongCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Album art
          AspectRatio(
            aspectRatio: 1,
            child: TPSSkeleton(
              borderRadius: TPSDecorations.compactBorderRadius,
            ),
          ),
          TPSSpacing.vGapMd,
          // Title and artist
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TPSSkeleton(height: 14),
                    TPSSpacing.vGapXs,
                    TPSSkeleton(
                      height: 12,
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ],
                ),
              ),
              TPSSpacing.hGapSm,
              const TPSSkeleton(width: 28, height: 28, circle: true),
            ],
          ),
        ],
      ),
    );
  }
}

/// Skeleton for artist list items.
class TPSArtistItemSkeleton extends StatelessWidget {
  const TPSArtistItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const TPSSkeleton(width: 32, height: 32, circle: true),
          TPSSpacing.hGapMd,
          const Expanded(child: TPSSkeleton(height: 14)),
          TPSSpacing.hGapMd,
          const TPSSkeleton(width: 50, height: 12),
        ],
      ),
    );
  }
}

/// Skeleton for the recently played card.
class TPSRecentlyPlayedSkeleton extends StatelessWidget {
  const TPSRecentlyPlayedSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TPSSpacing.cardPadding,
      decoration: BoxDecoration(
        color: TPSColors.surface,
        borderRadius: TPSDecorations.standardBorderRadius,
        border: Border.all(color: TPSColors.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TPSSkeleton(
                width: 80,
                height: 80,
                borderRadius: TPSDecorations.compactBorderRadius,
              ),
              TPSSpacing.hGapMd,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TPSSkeleton(width: 80, height: 12),
                    TPSSpacing.vGapSm,
                    const TPSSkeleton(height: 20),
                    TPSSpacing.vGapXs,
                    const TPSSkeleton(width: 60, height: 14),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              const TPSSkeleton(width: 48, height: 48, circle: true),
              TPSSpacing.hGapMd,
              Expanded(
                child: TPSSkeleton(
                  height: 4,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              TPSSpacing.hGapMd,
              const TPSSkeleton(width: 60, height: 12),
            ],
          ),
        ],
      ),
    );
  }
}

/// Grid of song card skeletons.
class TPSSongGridSkeleton extends StatelessWidget {
  final int count;
  final int crossAxisCount;

  const TPSSongGridSkeleton({
    super.key,
    this.count = 6,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: count,
      itemBuilder: (context, index) => const TPSSongCardSkeleton(),
    );
  }
}
