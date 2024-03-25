This is a simple library to log events with colorful terminal outputs and stop watch class to measure performance across your application.

# Usage

```dart
import 'package:vit_logger/vit_logger.dart';

void main() async {
  var logger = TerminalLogger();
  logger.info('This is a informational message'); // "This is a informational message" in the green
  logger.warn('This is a warning message'); // "This is a warning message" in yellow
  logger.error('This is a error message'); // "This is a error message" in red
  logger.debug('This is a debug message'); // "This is a debug message" in magenta
  var otherLogger = TerminalLogger(
    timestampMode: TimestampMode.timeIso,
  );
  otherLogger.info('this is a message with a timestamp'); // 16:57:11.00 this is a message with a timestamp
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

```

<img width="633" alt="Screenshot 2024-03-25 at 11 41 35" src="https://github.com/TimeLord2010/vit_logger/assets/50129092/73d1470d-b594-410d-aa07-8f60fa8a7a42">


# Features

## BaseLogger

Base abstract class to implement any logger. This class makes use of `VitLogger.eventMatcher` for
event filtering.

## TerminalLogger

The default logger. This logger uses the terminal to print colorful messages.

## VitStopWatch

Class to help debug methods that take some time to complete or that could take some time.
