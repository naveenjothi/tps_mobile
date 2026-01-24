import 'artist_stat.dart';
import 'song.dart';

/// Dashboard statistics from the catalog service.
class DashboardStats {
  final int totalPlays;
  final double totalHours;
  final int totalSongs;
  final double storageSavedMb;
  final List<ArtistStat> topArtists;
  final List<Song> recentPlays;
  final List<Song> recentlyAdded;

  DashboardStats({
    required this.totalPlays,
    required this.totalHours,
    required this.totalSongs,
    required this.storageSavedMb,
    required this.topArtists,
    required this.recentPlays,
    required this.recentlyAdded,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalPlays: json['total_plays'] ?? 0,
      totalHours: (json['total_hours'] ?? 0).toDouble(),
      totalSongs: json['total_songs'] ?? 0,
      storageSavedMb: (json['storage_saved_mb'] ?? 0).toDouble(),
      topArtists:
          (json['top_artists'] as List<dynamic>?)
              ?.map((a) => ArtistStat.fromJson(a))
              .toList() ??
          [],
      recentPlays:
          (json['recent_plays'] as List<dynamic>?)
              ?.map((s) => Song.fromJson(s))
              .toList() ??
          [],
      recentlyAdded:
          (json['recently_added'] as List<dynamic>?)
              ?.map((s) => Song.fromJson(s))
              .toList() ??
          [],
    );
  }

  /// Create an empty stats object.
  factory DashboardStats.empty() {
    return DashboardStats(
      totalPlays: 0,
      totalHours: 0,
      totalSongs: 0,
      storageSavedMb: 0,
      topArtists: [],
      recentPlays: [],
      recentlyAdded: [],
    );
  }
}
