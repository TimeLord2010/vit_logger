## 1.2.0

* Added event filtering: Each logger instance now has an optional `event`. This event can be filtered out by changing `VitLogger.eventMatcher`.

## 1.1.0

* Added 'debug' log level.
* Added `useColorfulOutput` option to TerminalLog to improve control. This option is useful to disable colors when using Flutter on web since the browser console does not support ANSI escape codes.
* TerminalLog's 'info' log level now outputs in green color.

## 1.0.0

* Initial version.
