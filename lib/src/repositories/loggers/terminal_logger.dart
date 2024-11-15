import 'dart:developer' as developer;

import '../../data/enums/log_level.dart';
import '../../data/enums/terminal_printer.dart';
import '../../data/models/abstract/text_logger.dart';

class TerminalLogger extends TextLogger {
  const TerminalLogger({
    super.timestampMode,
    super.event,
    this.useColorfulOutput,
  });

  final bool Function(LogLevel level)? useColorfulOutput;

  static TerminalPrinter printer = TerminalPrinter.print;

  static bool disableColorfulOutput = false;

  bool hasColor(LogLevel level) {
    if (disableColorfulOutput) {
      return false;
    }
    var fn = useColorfulOutput;
    if (fn != null) return fn(level);
    return true;
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
  void writer({
    required String message,
    required LogLevel level,
    dynamic data,
  }) {
    switch (printer) {
      case TerminalPrinter.print:
        print(message);
        break;
      case TerminalPrinter.developerLog:
        developer.log(
          message,
          name: event ?? '',
        );
        break;
    }
  }
}
