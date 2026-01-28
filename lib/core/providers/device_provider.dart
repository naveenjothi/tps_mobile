import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/device_service.dart';

/// Provider for the DeviceService.
final deviceServiceProvider = Provider<DeviceService>((ref) {
  return DeviceService();
});

/// State class for Device information.
class DeviceState {
  final String? deviceId;
  final String? pairingCode;
  final bool isConnected;

  const DeviceState({
    this.deviceId,
    this.pairingCode,
    this.isConnected = false,
  });

  DeviceState copyWith({
    String? deviceId,
    String? pairingCode,
    bool? isConnected,
  }) {
    return DeviceState(
      deviceId: deviceId ?? this.deviceId,
      pairingCode: pairingCode ?? this.pairingCode,
      isConnected: isConnected ?? this.isConnected,
    );
  }
}

/// Notifier for Device State.
class DeviceNotifier extends AsyncNotifier<DeviceState> {
  @override
  Future<DeviceState> build() async {
    final service = ref.watch(deviceServiceProvider);

    try {
      final deviceId = await service.getDeviceId();
      final pairingCode = await service.getPairingCode();

      // TODO: Check actual connection status from a WebSocket/WebRTC service
      const isConnected = false;

      return DeviceState(
        deviceId: deviceId,
        pairingCode: pairingCode,
        isConnected: isConnected,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Toggle connection status (Mock functionality for now)
  void toggleConnection() {
    state.whenData((value) {
      state = AsyncValue.data(value.copyWith(isConnected: !value.isConnected));
    });
  }
}

/// Provider for the Device State.
final deviceControllerProvider =
    AsyncNotifierProvider<DeviceNotifier, DeviceState>(() {
      return DeviceNotifier();
    });
