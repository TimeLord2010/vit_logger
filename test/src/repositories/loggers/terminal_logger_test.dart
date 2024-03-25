import 'package:test/test.dart';
import 'package:vit_logger/vit_logger.dart';

void main() {
  test('"hasColor" property', () {
    expect(TerminalLogger().hasColor(LogLevel.info), true);
    expect(
        TerminalLogger(
          useColorfulOutput: (_) => true,
        ).hasColor(LogLevel.info),
        true);
    expect(
        TerminalLogger(
          useColorfulOutput: (_) => false,
        ).hasColor(LogLevel.info),
        false);
  });

  group('colorful', () {
    var instance = TerminalLogger();

    void checkEscapeCode(String code, LogLevel level) {
      var msg = instance.digest('_message_', level);

      // Checking if the digested message has the ANSI escape code for the
      // desired color at the begining of the string.
      expect(msg.startsWith(code), true);

      // Checking if the digested message has the ANSI escape code for
      // clearing color at the end of the string.
      expect(msg.endsWith('\x1B[0m'), true);

      // Checking if the digested message is fully in compliance.
      expect(msg, '${code}_message_\x1B[0m');
    }

    // Checking if the message is in magenta.
    test('debug', () => checkEscapeCode('\u001b[35m', LogLevel.debug));

    // Checking if the message is in green.
    test('info', () => checkEscapeCode('\u001b[32m', LogLevel.info));

    // Checking if the message is in yellow.
    test('warn', () => checkEscapeCode('\x1B[33m', LogLevel.warn));

    // Checking if the message is in red.
    test('error', () => checkEscapeCode('\x1B[31m', LogLevel.error));
  });

  group('colorless', () {
    var instance = TerminalLogger(
      useColorfulOutput: (_) => false,
    );

    void checkMessage(LogLevel level) {
      var msg = instance.digest('msg', level);
      expect(msg, 'msg');
    }

    test('debug', () => checkMessage(LogLevel.debug));

    test('info', () => checkMessage(LogLevel.info));

    test('warn', () => checkMessage(LogLevel.warn));

    test('error', () => checkMessage(LogLevel.error));
  });
  test('only error level has color', () {
    var instance = TerminalLogger(
      useColorfulOutput: (level) => level == LogLevel.error,
    );
    expect(instance.digest('msg', LogLevel.info), 'msg');
    expect(instance.digest('msg', LogLevel.error) == 'msg', false);
  });
}
