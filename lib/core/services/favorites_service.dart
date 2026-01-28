import 'api_client.dart';
import '../models/models.dart';
import '../utils/logger.dart';

/// Favorites Service
///
/// Manages user favorites (liked songs).
class FavoritesService {
  final ApiClient _client;

  FavoritesService({required ApiClient client}) : _client = client;

  /// Get user's favorite songs.
  Future<List<Song>> getFavorites() async {
    try {
      final response = await _client.get('/favorites');
      final data = response['data'] as List<dynamic>? ?? [];
      return data.map((s) => Song.fromJson(s)).toList();
    } catch (e, stackTrace) {
      TPSLogger.error(
        'Failed to fetch favorites',
        error: e,
        stackTrace: stackTrace,
        tag: 'FavoritesService',
      );
      return [];
    }
  }

  /// Like a song (add to favorites).
  Future<void> likeSong(String songId) async {
    await _client.post('/favorites/$songId');
  }

  /// Unlike a song (remove from favorites).
  Future<void> unlikeSong(String songId) async {
    await _client.delete('/favorites/$songId');
  }
}
