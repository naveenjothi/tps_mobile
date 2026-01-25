import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/theme.dart';
import '../core/widgets/widgets.dart';
import '../core/providers/providers.dart';
import '../core/models/models.dart';

/// TPS Dashboard Screen
///
/// Main dashboard showing user stats, recent plays, and favorites.
/// Uses Riverpod for state management and displays skeleton loaders during loading.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);
    final favoritesAsync = ref.watch(favoritesProvider);
    final authService = ref.watch(authServiceProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              floating: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TPSLogo(size: 32),
                  Text(
                    'The Private Streamer',
                    style: TPSTypography.textTheme.labelSmall?.copyWith(
                      color: TPSColors.muted,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout_rounded),
                  onPressed: () => authService.signOut(),
                  tooltip: 'Sign Out',
                ),
              ],
            ),

            // Content
            SliverPadding(
              padding: TPSSpacing.pagePadding,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Welcome message
                  if (user != null) ...[
                    Text(
                      'Welcome, ${user.displayName ?? 'User'}',
                      style: TPSTypography.textTheme.titleMedium?.copyWith(
                        color: TPSColors.textSecondary,
                      ),
                    ),
                    TPSSpacing.vGapLg,
                  ],

                  // Section Header
                  _buildSectionHeader('Dashboard', 'Your Music Hub'),
                  TPSSpacing.vGapMd,

                  // Stats Cards
                  statsAsync.when(
                    data: (stats) => _buildStatsGrid(stats),
                    loading: () => _buildStatsGridSkeleton(),
                    error: (_, __) => _buildStatsGrid(DashboardStats.empty()),
                  ),

                  TPSSpacing.vGapXl,

                  // Top Artists
                  _buildSectionHeader('Top Artists', 'Your most played'),
                  TPSSpacing.vGapMd,

                  statsAsync.when(
                    data: (stats) => _buildTopArtists(stats.topArtists),
                    loading: () => _buildTopArtistsSkeleton(),
                    error: (_, __) => TPSEmptyState(
                      icon: Icons.person_rounded,
                      title: 'No artists yet',
                      subtitle: 'Start listening to see your top artists',
                    ),
                  ),

                  TPSSpacing.vGapXl,

                  // Favorites
                  _buildSectionHeader('Favorites', 'Songs you love'),
                  TPSSpacing.vGapMd,

                  favoritesAsync.when(
                    data: (favorites) => favorites.isEmpty
                        ? TPSCard.surface(
                            child: TPSEmptyState.favorites(onAction: () {}),
                          )
                        : _buildFavoritesList(favorites),
                    loading: () => const TPSSongGridSkeleton(count: 4),
                    error: (_, __) => TPSCard.surface(
                      child: TPSEmptyState.favorites(onAction: () {}),
                    ),
                  ),

                  TPSSpacing.vGapXl,

                  // Recently Added
                  _buildSectionHeader('Recently Synced', 'Latest additions'),
                  TPSSpacing.vGapMd,

                  statsAsync.when(
                    data: (stats) => stats.recentlyAdded.isEmpty
                        ? _buildEmptyRecentlyAdded()
                        : _buildRecentlyAddedGrid(stats.recentlyAdded),
                    loading: () => const TPSSongGridSkeleton(count: 6),
                    error: (_, __) => _buildEmptyRecentlyAdded(),
                  ),

                  TPSSpacing.vGapXxl,
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TPSTypography.textTheme.headlineSmall),
            Text(subtitle, style: TPSTypography.textTheme.bodySmall),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_rounded),
          color: TPSColors.muted,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildStatsGrid(DashboardStats stats) {
    final statItems = [
      _StatItem(
        icon: Icons.play_circle_rounded,
        iconColor: TPSColors.lilac,
        value: '${stats.totalPlays}',
        label: 'Total Plays',
      ),
      _StatItem(
        icon: Icons.access_time_rounded,
        iconColor: Colors.amber,
        value: '${stats.totalHours.toStringAsFixed(1)}h',
        label: 'Hours Listened',
      ),
      _StatItem(
        icon: Icons.library_music_rounded,
        iconColor: TPSColors.cyan,
        value: '${stats.totalSongs}',
        label: 'Songs',
      ),
      _StatItem(
        icon: Icons.cloud_off_rounded,
        iconColor: Colors.green,
        value: '${(stats.storageSavedMb / 1024).toStringAsFixed(1)}GB',
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

  Widget _buildStatsGridSkeleton() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: List.generate(4, (_) => const TPSStatCardSkeleton()),
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
              color: item.iconColor.withOpacity(0.2),
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

  Widget _buildTopArtists(List<ArtistStat> artists) {
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
                  decoration: BoxDecoration(
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

  Widget _buildTopArtistsSkeleton() {
    return TPSCard.surface(
      child: Column(
        children: List.generate(5, (_) => const TPSArtistItemSkeleton()),
      ),
    );
  }

  Widget _buildFavoritesList(List<Song> favorites) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: favorites.length,
        separatorBuilder: (_, __) => TPSSpacing.hGapMd,
        itemBuilder: (context, index) {
          final song = favorites[index];
          return SizedBox(width: 140, child: _buildSongCard(song));
        },
      ),
    );
  }

  Widget _buildRecentlyAddedGrid(List<Song> songs) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.75,
      children: songs.take(6).map((song) => _buildSongCard(song)).toList(),
    );
  }

  Widget _buildSongCard(Song song) {
    return TPSCard.surface(
      onTap: () {},
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

  Widget _buildEmptyRecentlyAdded() {
    return TPSCard.surface(
      child: Padding(
        padding: TPSSpacing.cardPadding,
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: TPSColors.surface,
                borderRadius: TPSDecorations.standardBorderRadius,
              ),
              child: const Icon(
                Icons.music_off_rounded,
                color: TPSColors.muted,
                size: 32,
              ),
            ),
            TPSSpacing.vGapMd,
            Text('No songs found', style: TPSTypography.textTheme.titleMedium),
            TPSSpacing.vGapXs,
            Text(
              'Sync your mobile device to start streaming',
              style: TPSTypography.textTheme.bodySmall?.copyWith(
                color: TPSColors.muted,
              ),
              textAlign: TextAlign.center,
            ),
            TPSSpacing.vGapLg,
            TPSButton.primary(
              label: 'Pair Device',
              icon: Icons.phonelink_rounded,
              onPressed: () {},
            ),
          ],
        ),
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
