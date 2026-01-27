import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tps_core/core/providers/api_provider.dart';
import 'package:tps_core/core/providers/auth_provider.dart';
import 'package:tps_core/core/models/models.dart';
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

/// Provider for the currently authenticated backend user.
final currentDbUserProvider = AsyncNotifierProvider<CurrentDbUser, TPSUser?>(
  CurrentDbUser.new,
);

class CurrentDbUser extends AsyncNotifier<TPSUser?> {
  @override
  Future<TPSUser?> build() async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return null;

    // Wait for backend to be ready so we don't fail immediately on login
    final isBackendReady = ref.watch(isBackendReadyProvider);
    if (!isBackendReady) return null;

    final userService = ref.watch(userServiceProvider);
    return userService.getUserByFirebaseId(user.uid);
  }

  void setUser(TPSUser? user) {
    state = AsyncData(user);
  }
}
