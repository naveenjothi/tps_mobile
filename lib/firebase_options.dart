import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

/// Firebase configuration options for TPS.
///
/// These are derived from the Firebase project configuration.
/// Project: audio-streaming-platform-f6587
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  /// Android configuration
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAshcs0prVQUrZYASVd1MnrDq4Qq5OIE-U',
    appId: '1:1046049642350:android:6d4233774e60b3c8f8d37f',
    messagingSenderId: '1046049642350',
    projectId: 'audio-streaming-platform-f6587',
    storageBucket: 'audio-streaming-platform-f6587.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvuwhw-1oXUFdGJX8mx0-wde_2TO6siEs',
    appId: '1:1046049642350:ios:2e95ec06b593c7a0f8d37f',
    messagingSenderId: '1046049642350',
    projectId: 'audio-streaming-platform-f6587',
    storageBucket: 'audio-streaming-platform-f6587.firebasestorage.app',
    iosBundleId: 'com.tps.core',
  );

  /// macOS configuration
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBvuwhw-1oXUFdGJX8mx0-wde_2TO6siEs',
    appId: '1:1046049642350:ios:2e95ec06b593c7a0f8d37f',
    messagingSenderId: '1046049642350',
    projectId: 'audio-streaming-platform-f6587',
    storageBucket: 'audio-streaming-platform-f6587.firebasestorage.app',
    iosBundleId: 'com.tps.core',
  );
}
