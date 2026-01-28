import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/api_provider.dart';
import '../providers/auth_provider.dart';
import '../models/models.dart';
import '../services/services.dart';

/// Provider for the Dashboard Service.
final userServiceProvider = Provider<UserService>((ref) {
  final client = ref.watch(apiClientProvider);
  return UserService(client: client);
});

/// Provider to track if backend is ready.
final isBackendReadyProvider = NotifierProvider<_IsBackendReady, bool>(
  _IsBackendReady.new,
);

class _IsBackendReady extends Notifier<bool> {
  @override
  bool build() => true;

  void setReady(bool value) => state = value;
}

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
