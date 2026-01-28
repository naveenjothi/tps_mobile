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

                  // Dashboard Section
                  DashboardSectionHeader(
                    title: 'Dashboard',
                    subtitle: 'Your Music Hub',
                    onAction: () => _showComingSoon(context, 'Dashboard'),
                  ),
                  TPSSpacing.vGapMd,

                  // Stats Cards
                  statsAsync.when(
                    data: (stats) => DashboardStatsGrid(
                      totalPlays: stats.totalPlays,
                      totalHours: stats.totalHours,
                      totalSongs: stats.totalSongs,
                      storageSavedMb: stats.storageSavedMb,
                    ),
                    loading: () => _buildStatsGridSkeleton(),
                    error: (_, __) => DashboardStatsGrid(
                      totalPlays: 0,
                      totalHours: 0,
                      totalSongs: 0,
                      storageSavedMb: 0,
                    ),
                  ),

                  TPSSpacing.vGapXl,

                  // Top Artists
                  DashboardSectionHeader(
                    title: 'Top Artists',
                    subtitle: 'Your most played',
                    onAction: () => _showComingSoon(context, 'Top Artists'),
                  ),
                  TPSSpacing.vGapMd,

                  statsAsync.when(
                    data: (stats) =>
                        DashboardTopArtists(artists: stats.topArtists),
                    loading: () => _buildTopArtistsSkeleton(),
                    error: (_, __) => const DashboardTopArtists(artists: []),
                  ),

                  TPSSpacing.vGapXl,

                  // Favorites
                  DashboardSectionHeader(
                    title: 'Favorites',
                    subtitle: 'Songs you love',
                    onAction: () => _showComingSoon(context, 'Favorites'),
                  ),
                  TPSSpacing.vGapMd,

                  favoritesAsync.when(
                    data: (favorites) => favorites.isEmpty
                        ? TPSCard.surface(
                            child: TPSEmptyState.favorites(onAction: null),
                          )
                        : _buildFavoritesList(favorites, context),
                    loading: () => const TPSSongGridSkeleton(count: 4),
                    error: (_, __) => TPSCard.surface(
                      child: TPSEmptyState.favorites(onAction: null),
                    ),
                  ),

                  TPSSpacing.vGapXl,

                  // Recently Added
                  DashboardSectionHeader(
                    title: 'Recently Synced',
                    subtitle: 'Latest additions',
                    onAction: () => _showComingSoon(context, 'Recently Synced'),
                  ),
                  TPSSpacing.vGapMd,

                  statsAsync.when(
                    data: (stats) => stats.recentlyAdded.isEmpty
                        ? const EmptyRecentlyAdded()
                        : _buildRecentlyAddedGrid(stats.recentlyAdded, context),
                    loading: () => const TPSSongGridSkeleton(count: 6),
                    error: (_, __) => const EmptyRecentlyAdded(),
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

  void _showComingSoon(BuildContext context, String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$section - Coming soon'),
        duration: const Duration(seconds: 1),
      ),
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

  Widget _buildTopArtistsSkeleton() {
    return TPSCard.surface(
      child: Column(
        children: List.generate(5, (_) => const TPSArtistItemSkeleton()),
      ),
    );
  }

  Widget _buildFavoritesList(List<Song> favorites, BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: favorites.length,
        separatorBuilder: (_, __) => TPSSpacing.hGapMd,
        itemBuilder: (ctx, index) {
          final song = favorites[index];
          return SizedBox(
            width: 140,
            child: SongCard(
              song: song,
              onTap: () => _showSongComingSoon(context, song.name),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentlyAddedGrid(List<Song> songs, BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.75,
      children: songs.take(6).map((song) {
        return SongCard(
          song: song,
          onTap: () => _showSongComingSoon(context, song.name),
        );
      }).toList(),
    );
  }

  void _showSongComingSoon(BuildContext context, String songName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Playing "$songName" - Coming soon'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
