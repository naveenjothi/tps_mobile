/// Song model matching the backend.
class Song {
  final String id;
  final String name;
  final String? image;
  final String? url;
  final int duration;
  final bool explicit;
  final String? language;
  final String? fileFormat;
  final int? bitrate;
  final List<SongArtist> artists;
  final DateTime? createdAt;

  Song({
    required this.id,
    required this.name,
    this.image,
    this.url,
    required this.duration,
    this.explicit = false,
    this.language,
    this.fileFormat,
    this.bitrate,
    this.artists = const [],
    this.createdAt,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      image: json['image'],
      url: json['url'],
      duration: json['duration'] ?? 0,
      explicit: json['explicit'] ?? false,
      language: json['language'],
      fileFormat: json['file_format'],
      bitrate: json['bitrate'],
      artists:
          (json['artists'] as List<dynamic>?)
              ?.map((a) => SongArtist.fromJson(a))
              .toList() ??
          [],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'url': url,
      'duration': duration,
      'explicit': explicit,
      'language': language,
      'file_format': fileFormat,
      'bitrate': bitrate,
      'artists': artists.map((a) => a.toJson()).toList(),
      'created_at': createdAt?.toIso8601String(),
    };
  }

  /// Get the primary artist name.
  String get artistName =>
      artists.isNotEmpty ? artists.first.name : 'Unknown Artist';
}

/// Nested artist within a song.
class SongArtist {
  final String id;
  final String name;

  SongArtist({required this.id, required this.name});

  factory SongArtist.fromJson(Map<String, dynamic> json) {
    return SongArtist(id: json['id'] ?? '', name: json['name'] ?? 'Unknown');
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
