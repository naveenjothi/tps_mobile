import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../utils/logger.dart';

/// TPS Device Service
///
/// Handles device identity and pairing code generation/persistence.
class DeviceService {
  static const String _deviceIdKey = 'tps_device_id';
  static const String _pairingCodeKey = 'tps_pairing_code';

  final Uuid _uuid = const Uuid();

  /// Initialize and retrieve the unique Device ID.
  /// Generates a new one if it doesn't exist.
  Future<String> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString(_deviceIdKey);

    if (deviceId == null) {
      deviceId = _uuid.v4();
      await prefs.setString(_deviceIdKey, deviceId);
      TPSLogger.info(
        'Generated new Device ID: $deviceId',
        tag: 'DeviceService',
      );
    } else {
      TPSLogger.debug(
        'Retrieved existing Device ID: $deviceId',
        tag: 'DeviceService',
      );
    }

    return deviceId;
  }

  /// Initialize and retrieve the unique Pairing Code.
  /// Generates a new 6-character alphanumeric code if it doesn't exist.
  Future<String> getPairingCode() async {
    final prefs = await SharedPreferences.getInstance();
    String? code = prefs.getString(_pairingCodeKey);

    if (code == null) {
      code = _generatePairingCode();
      await prefs.setString(_pairingCodeKey, code);
      TPSLogger.info('Generated new Pairing Code: $code', tag: 'DeviceService');
    } else {
      TPSLogger.debug(
        'Retrieved existing Pairing Code: $code',
        tag: 'DeviceService',
      );
    }

    return code;
  }

  /// Generate a random 6-character alphanumeric code (uppercase).
  String _generatePairingCode() {
    const chars =
        'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; // Removed I, 1, O, 0 for clarity
    final random = Random();
    return List.generate(
      6,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }
}
