import 'package:vit_logger/src/models/enums/log_level.dart';
import 'package:vit_logger/src/models/enums/timestamp_mode.dart';
import 'package:vit_logger/src/usecases/get_timestamp_string.dart';

abstract class BaseLogger {
  const BaseLogger({
    this.timestampMode = TimestampMode.none,
  });

  final TimestampMode timestampMode;

  /// The actual logger function. This function will be called automatically
  /// by "info", "warn", "error" with aditional modifiers to the passing String.
  void writer(String message);

  /// Useful to insert tags in the log message like "@INFO", functional
  /// characters like the ones used to color the terminal, or timestamps.
  String getPrefix(LogLevel level);

  String _getPrefix(LogLevel level) {
    var prefix = getPrefix(level);
    var timestamp = getTimestampString(timestampMode);
    var parts = [prefix, timestamp];
    return parts.whereType<String>().join(' ');
  }

  /// Useful to insert new line characters for file based logs or to place
  /// delimiters.
  String getSuffix(LogLevel level);

  /// Gets the prefix and suffix.
  (String, String) getEdges(LogLevel level) {
    return (_getPrefix(level), getSuffix(level));
  }

  /// Used to indicate informational logs.
  void info(String message) {
    var (prefix, suffix) = getEdges(LogLevel.info);
    writer('$prefix$message$suffix');
  }

  /// Used to indicate warning logs.
  void warn(String message) {
    var (prefix, suffix) = getEdges(LogLevel.warn);
    writer('$prefix$message$suffix');
  }

  /// Used to indicate error logs.
  void error(String message) {
    var (prefix, suffix) = getEdges(LogLevel.error);
    writer('$prefix$message$suffix');
  }
}
