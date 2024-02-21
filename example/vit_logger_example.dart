import 'package:vit_logger/vit_logger.dart';

void main() async {
  var logger = TerminalLogger();
  logger.info('This is a informational message'); // "This is a informational message" in the default color
  logger.warn('This is a warning message'); // "This is a warning message" in yellow
  logger.error('This is a error message'); // "This is a error message" in red
  var otherLogger = TerminalLogger(
    timestampMode: TimestampMode.timeIso,
  );
  otherLogger.info('this is a message with a timestamp'); // 16:57:11.00 this is a message with a timestamp
  var stopWatch = VitStopWatch('MyEvent');
  await Future.delayed(const Duration(milliseconds: 200));
  stopWatch.lap(tag: 'FETCHED'); // MyEvent [FETCHED] (204ms)
  await Future.delayed(const Duration(milliseconds: 800));
  stopWatch.stop(); // MyEvent (1008ms)
}
