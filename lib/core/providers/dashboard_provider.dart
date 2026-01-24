import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/services.dart';
import '../models/models.dart';
import 'auth_provider.dart';

/// Provider for the API client.
final apiClientProvider = Provider<ApiClient>((ref) {
  final authService = ref.watch(authServiceProvider);
  return ApiClient(authService: authService);
});

/// Provider for the Dashboard Service.
final dashboardServiceProvider = Provider<DashboardService>((ref) {
  final client = ref.watch(apiClientProvider);
  return DashboardService(client: client);
});

/// Provider for the Favorites Service.
final favoritesServiceProvider = Provider<FavoritesService>((ref) {
  final client = ref.watch(apiClientProvider);
  return FavoritesService(client: client);
});

/// Dashboard stats provider.
///
/// Fetches dashboard statistics from the API.
final dashboardStatsProvider = FutureProvider.autoDispose<DashboardStats>((
  ref,
) async {
  final service = ref.watch(dashboardServiceProvider);
  return await service.getDashboardStats();
});

/// Favorites provider.
///
/// Fetches user's favorite songs from the API.
final favoritesProvider = FutureProvider.autoDispose<List<Song>>((ref) async {
  final service = ref.watch(favoritesServiceProvider);
  return await service.getFavorites();
});
