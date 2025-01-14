import 'package:vit_logger/src/usecases/get_timestamp_string.dart';

import '../../enums/log_level.dart';
import '../../enums/timestamp_mode.dart';
import 'base_logger.dart';

abstract class TextLogger extends BaseLogger {
  const TextLogger({
    this.timestampMode = TimestampMode.none,
    super.event,
  });

  final TimestampMode timestampMode;

  /// Useful to insert tags in the log message like "@INFO", functional
  /// characters like the ones used to color the terminal, or timestamps.
  String getPrefix(LogLevel level);

  /// Useful to insert new line characters for file based logs or to place
  /// delimiters.
  String getSuffix(LogLevel level);

  String _getPrefix(LogLevel level) {
    var prefix = getPrefix(level);
    var timestamp = getTimestampString(timestampMode);
    if (timestamp != null) {
      timestamp = '$timestamp ';
    }
    var parts = [prefix, timestamp].where((x) => x != null && x.isNotEmpty);
    var result = parts.whereType<String>().join('');
    return result;
  }

  /// Gets the prefix and suffix.
  (String, String) getEdges(LogLevel level) {
    return (_getPrefix(level), getSuffix(level));
  }

  /// Process the message to the output text logger.
  String digest(String message, LogLevel level) {
    var (prefix, suffix) = getEdges(level);
    return '$prefix$message$suffix';
  }

  /// Used to indicate informational logs.
  void info(String message) async {
    await log(
      message: digest(message, LogLevel.info),
      level: LogLevel.info,
    );
  }

  /// Used to indicate warning logs.
  void warn(String message) async {
    await log(
      message: digest(message, LogLevel.warn),
      level: LogLevel.warn,
    );
  }

  /// Used to indicate error logs.
  void error(String message) async {
    await log(
      message: digest(message, LogLevel.error),
      level: LogLevel.error,
    );
  }

  /// Used to indicate debug logs.
  void debug(String message) async {
    await log(
      message: digest(message, LogLevel.debug),
      level: LogLevel.debug,
    );
  }

  void logByLevel(String message, LogLevel level) async {
    void Function(String message) logFn;
    switch (level) {
      case LogLevel.info:
        logFn = info;
        break;
      case LogLevel.warn:
        logFn = warn;
        break;
      case LogLevel.error:
        logFn = error;
        break;
      case LogLevel.debug:
        logFn = debug;
        break;
    }
    logFn(message);
  }
}
