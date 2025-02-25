import 'package:logger/logger.dart';

class LoggerUtils {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static void debug(String message) {
    _logger.d('🔍 $message');
  }

  static void info(String message) {
    _logger.i('ℹ️ $message');
  }

  static void warning(String message) {
    _logger.w('⚠️ $message');
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e('❌ $message', error: error, stackTrace: stackTrace);
  }
} 