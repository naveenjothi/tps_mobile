import 'api_client.dart';
import '../models/models.dart';

/// Dashboard Service
///
/// Fetches dashboard statistics from the catalog service.
class DashboardService {
  final ApiClient _client;

  DashboardService({required ApiClient client}) : _client = client;

  /// Fetch dashboard statistics.
  Future<DashboardStats> getDashboardStats() async {
    try {
      final response = await _client.get('/dashboard/stats');
      final data = response['data'] ?? response;
      return DashboardStats.fromJson(data);
    } catch (e) {
      // Return empty stats on error
      return DashboardStats.empty();
    }
  }

  /// Record playback history.
  Future<void> recordHistory({
    required String songId,
    required int durationPlayedMs,
    bool isCompleted = false,
  }) async {
    await _client.post(
      '/history',
      body: {
        'song_id': songId,
        'duration_played_ms': durationPlayedMs,
        'is_completed': isCompleted,
      },
    );
  }
}
