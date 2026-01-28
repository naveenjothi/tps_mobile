import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// TPS Logger
///
/// Centralized logging utility that only outputs in debug mode.
/// Replaces raw print statements throughout the codebase.
class TPSLogger {
  TPSLogger._();

  static const String _name = 'TPS';

  /// Log a debug message (only in debug mode).
  static void debug(String message, {String? tag}) {
    if (kDebugMode) {
      developer.log(message, name: tag ?? _name);
    }
  }

  /// Log an info message.
  static void info(String message, {String? tag}) {
    if (kDebugMode) {
      developer.log('[INFO] $message', name: tag ?? _name);
    }
  }

  /// Log a warning message.
  static void warning(String message, {String? tag}) {
    if (kDebugMode) {
      developer.log('[WARN] $message', name: tag ?? _name);
    }
  }

  /// Log an error with optional error object and stack trace.
  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    if (kDebugMode) {
      developer.log(
        '[ERROR] $message',
        name: tag ?? _name,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
