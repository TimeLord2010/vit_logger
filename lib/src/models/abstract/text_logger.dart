import 'dart:async';

import 'package:vit_logger/src/models/index.dart';
import 'package:vit_logger/src/usecases/get_timestamp_string.dart';

abstract class TextLogger extends BaseLogger {
  const TextLogger({
    this.timestampMode = TimestampMode.none,
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
  FutureOr<void> info(String message) async {
    await writer(
      message: digest(message, LogLevel.info),
      level: LogLevel.info,
    );
  }

  /// Used to indicate warning logs.
  FutureOr<void> warn(String message) async {
    await writer(
      message: digest(message, LogLevel.warn),
      level: LogLevel.warn,
    );
  }

  /// Used to indicate error logs.
  FutureOr<void> error(String message) async {
    await writer(
      message: digest(message, LogLevel.error),
      level: LogLevel.error,
    );
  }

  /// Used to indicate debug logs.
  FutureOr<void> debug(String message) async {
    await writer(
      message: digest(message, LogLevel.debug),
      level: LogLevel.debug,
    );
  }
}