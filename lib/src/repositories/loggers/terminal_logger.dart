import 'package:vit_logger/src/models/index.dart';

class TerminalLogger extends BaseLogger {
  const TerminalLogger({
    super.timestampMode,
  });
  @override
  String getPrefix(LogLevel level) {
    return switch (level) {
      LogLevel.info => '',
      LogLevel.warn => '\x1B[33m',
      LogLevel.error => '\x1B[31m',
    };
  }

  @override
  String getSuffix(LogLevel level) {
    return switch (level) {
      LogLevel.info => '',
      LogLevel.warn => '\x1B[0m',
      LogLevel.error => '\x1B[0m',
    };
  }

  @override
  void writer(String message) {
    print(message);
  }
}
