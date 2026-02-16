import 'dart:developer' as developer;

/// AppLogger
class Logger {
  /// Info
  static void i(Object msg, {String tag = ''}) {
    _print('\x1B[34m$msg\x1B[0m', tag);
  }

  /// Success
  static void s(Object msg, {String tag = ''}) {
    _print('\x1B[32m$msg\x1B[0m', tag);
  }

  /// Warning
  static void w(Object msg, {String tag = ''}) {
    _print('\x1B[33m$msg\x1B[0m', tag);
  }

  /// Error
  static void e(Object msg, {String tag = ''}) {
    _print('\x1B[31m$msg\x1B[0m', tag);
  }

  static void _print(String msg, String? tag) {
    // if (kDebugMode) {
    //   print(msg);
    //   return;
    // }

    developer.log(msg, name: tag ?? '');
  }
}
