import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'tps_card.dart';

/// Dashboard stats grid showing key metrics.
class DashboardStatsGrid extends StatelessWidget {
  final int totalPlays;
  final double totalHours;
  final int totalSongs;
  final double storageSavedMb;

  const DashboardStatsGrid({
    super.key,
    required this.totalPlays,
    required this.totalHours,
    required this.totalSongs,
    required this.storageSavedMb,
  });

  @override
  Widget build(BuildContext context) {
    final statItems = [
      _StatItem(
        icon: Icons.play_circle_rounded,
        iconColor: TPSColors.lilac,
        value: '$totalPlays',
        label: 'Total Plays',
      ),
      _StatItem(
        icon: Icons.access_time_rounded,
        iconColor: Colors.amber,
        value: '${totalHours.toStringAsFixed(1)}h',
        label: 'Hours Listened',
      ),
      _StatItem(
        icon: Icons.library_music_rounded,
        iconColor: TPSColors.cyan,
        value: '$totalSongs',
        label: 'Songs',
      ),
      _StatItem(
        icon: Icons.cloud_off_rounded,
        iconColor: Colors.green,
        value: '${(storageSavedMb / 1024).toStringAsFixed(1)}GB',
        label: 'Cloud Saved',
      ),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: statItems.map((item) => _buildStatCard(item)).toList(),
    );
  }

  Widget _buildStatCard(_StatItem item) {
    return TPSCard.surface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: item.iconColor.withValues(alpha: 0.2),
              borderRadius: TPSDecorations.compactBorderRadius,
            ),
            child: Icon(item.icon, color: item.iconColor, size: 20),
          ),
          const Spacer(),
          Text(
            item.value,
            style: TPSTypography.textTheme.displaySmall?.copyWith(
              color: item.iconColor,
            ),
          ),
          Text(item.label, style: TPSTypography.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _StatItem {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  _StatItem({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });
}
