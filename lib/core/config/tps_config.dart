/// TPS Environment Configuration
///
/// Contains environment-specific configuration values.
/// These values are derived from the backend .env file.
import 'dart:io';

class TPSConfig {
  /// Firebase Project ID
  static const String firebaseProjectId = 'audio-streaming-platform-f6587';

  /// API Gateway Base URL (for local development)
  static const String apiBaseUrlLocal = 'http://localhost:4000';

  /// API Gateway Base URL (for production - update when deployed)
  static const String apiBaseUrlProd = 'https://your-api-domain.com';

  /// Catalog Service Base URL
  static const String catalogServiceUrl = 'http://localhost:4000/api/v1';

  /// Signaling Service Base URL
  static const String signalingServiceUrl = 'http://localhost:4001/api/v1';

  /// Current environment
  static const String environment = 'local';

  /// Get the appropriate API base URL based on environment
  static String get apiBaseUrl {
    if (environment == 'production') return apiBaseUrlProd;

    // For Android emulator, use 10.0.2.2 to access host machine
    try {
      if (Platform.isAndroid) {
        return 'http://10.0.2.2:4000'; // Base path is usually handled by ApiClient/Service logic or stripped
      }
    } catch (_) {
      // Platform.isAndroid throws on web
    }

    return 'http://localhost:4000';
  }

  /// Check if running in production
  static bool get isProduction => environment == 'production';

  /// Check if running in development
  static bool get isDevelopment => environment == 'local';
}
