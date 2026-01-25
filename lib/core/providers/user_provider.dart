import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tps_core/core/providers/api_provider.dart';
import 'package:tps_core/core/providers/auth_provider.dart';
import '../services/services.dart';

/// Provider for the Dashboard Service.
final userServiceProvider = Provider<UserService>((ref) {
  final client = ref.watch(apiClientProvider);
  return UserService(client: client);
});

final isBackendReadyProvider = StateProvider<bool>((ref) => true);

/// Provider to check if the user is fully ready (Firebase Auth + Backend verified).
final isAppReadyProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  final isBackendReady = ref.watch(isBackendReadyProvider);
  return user != null && isBackendReady;
});
