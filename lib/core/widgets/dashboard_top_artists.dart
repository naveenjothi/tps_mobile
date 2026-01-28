import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../models/models.dart';
import 'tps_card.dart';
import 'tps_empty_state.dart';

/// Dashboard top artists list.
class DashboardTopArtists extends StatelessWidget {
  final List<ArtistStat> artists;

  const DashboardTopArtists({super.key, required this.artists});

  @override
  Widget build(BuildContext context) {
    if (artists.isEmpty) {
      return TPSEmptyState(
        icon: Icons.person_rounded,
        title: 'No artists yet',
        subtitle: 'Start listening to see your top artists',
      );
    }

    return TPSCard.surface(
      child: Column(
        children: artists.take(5).toList().asMap().entries.map((entry) {
          final index = entry.key;
          final artist = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: index < 4 ? 12 : 0),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: TPSColors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TPSTypography.textTheme.labelSmall?.copyWith(
                        color: TPSColors.muted,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TPSSpacing.hGapMd,
                Expanded(
                  child: Text(
                    artist.name,
                    style: TPSTypography.textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${artist.playCount} plays',
                  style: TPSTypography.textTheme.labelSmall?.copyWith(
                    color: TPSColors.muted,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
