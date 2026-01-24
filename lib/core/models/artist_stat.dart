/// Artist statistics from the dashboard.
class ArtistStat {
  final String artistId;
  final String name;
  final int playCount;

  ArtistStat({
    required this.artistId,
    required this.name,
    required this.playCount,
  });

  factory ArtistStat.fromJson(Map<String, dynamic> json) {
    return ArtistStat(
      artistId: json['artist_id'] ?? '',
      name: json['name'] ?? 'Unknown Artist',
      playCount: json['play_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'artist_id': artistId, 'name': name, 'play_count': playCount};
  }
}
