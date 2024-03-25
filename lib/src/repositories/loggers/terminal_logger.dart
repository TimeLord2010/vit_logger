import 'dart:async';

import 'package:vit_logger/src/models/abstract/text_logger.dart';
import 'package:vit_logger/src/models/index.dart';

class TerminalLogger extends TextLogger {
  const TerminalLogger({
    super.timestampMode,
    this.useColorfulOutput,
  });

  final bool Function(LogLevel level)? useColorfulOutput;

  bool hasColor(LogLevel level) {
    var fn = useColorfulOutput;
    if (fn == null) {
      return true;
    }
    return fn(level);
  }

  @override
  String getPrefix(LogLevel level) {
    if (!hasColor(level)) {
      return '';
    }
    return switch (level) {
      LogLevel.info => '\u001b[32m',
      LogLevel.debug => '\u001b[35m', // Starts magenta cursor
      LogLevel.warn => '\x1B[33m', // Starts yellow cursor
      LogLevel.error => '\x1B[31m', // Starts red cursor
    };
  }

  @override
  String getSuffix(LogLevel level) {
    if (!hasColor(level)) {
      return '';
    }
    return switch (level) {
      LogLevel.info => '\x1B[0m',
      LogLevel.debug => '\x1B[0m', // Ends magenta cursor
      LogLevel.warn => '\x1B[0m', // Ends yellow cursor
      LogLevel.error => '\x1B[0m', // Ends red cursor
    };
  }

  @override
  FutureOr<void> writer({
    required String message,
    required LogLevel level,
  }) {
    print(message);
  }
}
