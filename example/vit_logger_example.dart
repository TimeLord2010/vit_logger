import 'package:vit_logger/vit_logger.dart';

void main() async {
  var logger = TerminalLogger();
  logger.info('This is a informational message');
  logger.warn('This is a warning message');
  logger.error('This is a error message');
  var otherLogger = TerminalLogger(
    timestampMode: TimestampMode.timeIso,
  );
  otherLogger.info('this is a message with a timestamp');
  var stopWatch = VitStopWatch('MyEvent');
  await Future.delayed(Duration(milliseconds: 200));
  stopWatch.lap(tag: 'Something happened in MyEvent');
  await Future.delayed(Duration(milliseconds: 800));
  stopWatch.stop();
}
