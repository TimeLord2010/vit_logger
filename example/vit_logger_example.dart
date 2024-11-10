import 'package:vit_logger/vit_logger.dart';

void main() async {
  var logger = TerminalLogger();
  logger.info(
      'This is a informational message'); // "This is a informational message" in the green
  logger.warn(
      'This is a warning message'); // "This is a warning message" in yellow
  logger.error('This is a error message'); // "This is a error message" in red
  logger
      .debug('This is a debug message'); // "This is a debug message" in magenta
  var otherLogger = TerminalLogger(
    timestampMode: TimestampMode.timeIso,
  );
  otherLogger.info(
      'this is a message with a timestamp'); // 16:57:11.00 this is a message with a timestamp
  var stopWatch = VitStopWatch('MyEvent');
  await Future.delayed(const Duration(milliseconds: 200));
  stopWatch.lap(tag: 'FETCHED'); // MyEvent [FETCHED] (204ms)
  await Future.delayed(const Duration(milliseconds: 800));
  stopWatch.stop(); // MyEvent (1008ms)

  VitLogger.eventMatcher.patterns = [RegExp(r'Home(:.*)?')];

  var loginLogger = TerminalLogger(
    event: 'Login',
  );
  loginLogger.info('This is not printed because event was filtered');

  var homeLogger = TerminalLogger(
    event: 'Home',
  );
  homeLogger.info('This is a "Home" message');

  var homeMenuLogger = TerminalLogger(
    event: 'Home:Menu',
  );
  homeMenuLogger.info('This is a "Home:Menu" message');
}
