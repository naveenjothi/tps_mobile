import 'package:flutter/material.dart';
import '../core/theme/theme.dart';
import '../core/widgets/widgets.dart';

/// Search Screen
///
/// Search for songs, artists, and albums.
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search'), centerTitle: true),
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
                    Icons.search_rounded,
                    size: 40,
                    color: TPSColors.cyan,
                  ),
                ),
                TPSSpacing.vGapLg,
                Text(
                  'Search Music',
                  style: TPSTypography.textTheme.headlineSmall,
                ),
                TPSSpacing.vGapSm,
                Text(
                  'Find songs, artists, and albums\nfrom your library.',
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
