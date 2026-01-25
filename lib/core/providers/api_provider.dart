import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tps_core/core/providers/auth_provider.dart';
import '../services/services.dart';

/// Provider for the API client.
final apiClientProvider = Provider<ApiClient>((ref) {
  final authService = ref.watch(authServiceProvider);
  return ApiClient(authService: authService);
});
