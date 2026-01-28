import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// TPS Empty State
///
/// A ghosted placeholder for empty lists/sections.
/// Uses the TPS waveform logo in a muted style.
class TPSEmptyState extends StatelessWidget {
  final String title;
  final String? message;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const TPSEmptyState({
    super.key,
    required this.title,
    String? message,
    String? subtitle, // Alias for message
    this.icon,
    this.actionLabel,
    this.onAction,
  }) : message = message ?? subtitle;

  /// Empty favorites state
  factory TPSEmptyState.favorites({VoidCallback? onAction}) {
    return TPSEmptyState(
      title: 'No Favorites Yet',
      message: 'Songs you love will appear here',
      icon: Icons.favorite_outline_rounded,
      actionLabel: 'Browse Library',
      onAction: onAction,
    );
  }

  /// Empty playlist state
  factory TPSEmptyState.playlist({VoidCallback? onAction}) {
    return TPSEmptyState(
      title: 'Playlist is Empty',
      message: 'Add some tracks to get started',
      icon: Icons.queue_music_rounded,
      actionLabel: 'Add Songs',
      onAction: onAction,
    );
  }

  /// No search results
  factory TPSEmptyState.noResults({String? searchQuery}) {
    return TPSEmptyState(
      title: 'No Results Found',
      message: searchQuery != null
          ? 'No matches for "$searchQuery"'
          : 'Try a different search term',
      icon: Icons.search_off_rounded,
    );
  }

  /// Connection required
  factory TPSEmptyState.offline({VoidCallback? onRetry}) {
    return TPSEmptyState(
      title: 'No Connection',
      message: 'Connect to your source to stream music',
      icon: Icons.wifi_off_rounded,
      actionLabel: 'Retry',
      onAction: onRetry,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: TPSSpacing.pagePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ghosted icon/waveform
          _buildIcon(),
          TPSSpacing.vGapLg,

          // Title
          Text(
            title,
            style: TPSTypography.textTheme.headlineSmall?.copyWith(
              color: TPSColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),

          // Message
          if (message != null) ...[
            TPSSpacing.vGapSm,
            Text(
              message!,
              style: TPSTypography.textTheme.bodyMedium?.copyWith(
                color: TPSColors.muted,
              ),
              textAlign: TextAlign.center,
            ),
          ],

          // Action button
          if (actionLabel != null && onAction != null) ...[
            TPSSpacing.vGapXl,
            TextButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.arrow_forward_rounded, size: 18),
              label: Text(actionLabel!),
              style: TextButton.styleFrom(foregroundColor: TPSColors.cyan),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIcon() {
    // If custom icon provided, use it
    if (icon != null) {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: TPSColors.surface,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 40,
          color: TPSColors.muted.withValues(alpha: 0.5),
        ),
      );
    }

    // Default: TPS Waveform visualization
    return _TPSWaveformIcon();
  }
}

/// Ghosted TPS Waveform icon for empty states
class _TPSWaveformIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 60,
      child: CustomPaint(
        painter: _WaveformPainter(
          color: TPSColors.muted.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}

/// Custom painter for the TPS waveform
class _WaveformPainter extends CustomPainter {
  final Color color;

  _WaveformPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // Draw stylized audio waveform bars
    final barCount = 9;
    final barWidth = size.width / (barCount * 2 - 1);
    final heights = [0.3, 0.5, 0.7, 0.9, 1.0, 0.9, 0.7, 0.5, 0.3];

    for (var i = 0; i < barCount; i++) {
      final x = barWidth * (i * 2) + barWidth / 2;
      final barHeight = size.height * heights[i];
      final startY = (size.height - barHeight) / 2;
      final endY = startY + barHeight;

      canvas.drawLine(Offset(x, startY), Offset(x, endY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// TPS Loading Indicator
///
/// A branded loading state using the TPS color scheme.
class TPSLoadingIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;

  const TPSLoadingIndicator({super.key, this.size = 40, this.strokeWidth = 3});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: const AlwaysStoppedAnimation(TPSColors.cyan),
        backgroundColor: TPSColors.surface,
      ),
    );
  }
}
