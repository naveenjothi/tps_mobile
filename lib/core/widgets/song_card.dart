import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../models/models.dart';
import 'tps_card.dart';

/// Song card widget for displaying song info with album art.
class SongCard extends StatelessWidget {
  final Song song;
  final VoidCallback? onTap;

  const SongCard({super.key, required this.song, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TPSCard.surface(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Album art
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                gradient: TPSColors.lilacGradient,
                borderRadius: TPSDecorations.compactBorderRadius,
              ),
              child: song.image != null
                  ? ClipRRect(
                      borderRadius: TPSDecorations.compactBorderRadius,
                      child: Image.network(
                        song.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.music_note_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    )
                  : const Icon(
                      Icons.music_note_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
            ),
          ),
          TPSSpacing.vGapSm,
          // Title
          Text(
            song.name,
            style: TPSTypography.textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // Artist
          Text(
            song.artistName,
            style: TPSTypography.textTheme.bodySmall?.copyWith(
              color: TPSColors.muted,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
