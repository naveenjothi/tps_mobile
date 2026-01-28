import 'package:flutter/material.dart';
import '../core/theme/theme.dart';
import '../core/widgets/widgets.dart';

/// Library Screen
///
/// User's music library showing playlists, albums, and liked songs.
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Library'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: TPSSpacing.pagePadding,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: TPSColors.surface,
                    borderRadius: TPSDecorations.heroBorderRadius,
                  ),
                  child: const Icon(
                    Icons.library_music_rounded,
                    size: 40,
                    color: TPSColors.lilac,
                  ),
                ),
                TPSSpacing.vGapLg,
                Text(
                  'Your Library',
                  style: TPSTypography.textTheme.headlineSmall,
                ),
                TPSSpacing.vGapSm,
                Text(
                  'Playlists, albums, and liked songs\nwill appear here.',
                  style: TPSTypography.textTheme.bodyMedium?.copyWith(
                    color: TPSColors.muted,
                  ),
                  textAlign: TextAlign.center,
                ),
                TPSSpacing.vGapXl,
                TPSButton.ghost(
                  label: 'Coming Soon',
                  icon: Icons.construction_rounded,
                  onPressed: null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
