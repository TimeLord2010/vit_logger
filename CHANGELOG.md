## 2.1.1

* Fix exporting missing TerminalPrinter enum.

## 2.1.0

* `VitStopWatch` was reworked to improve usage.

## 2.0.1

* Exposed all models to default import;

## 2.0.0

* [BREAKING] `TextLogger` log methods (info, warm, error and debug) no longer return a
future. If you created a `TextLogger` that has logs asyncronously and you need to way
for it to finish, you will need to create your own class.
* Added `disableColorfulOutput` static field in `TerminalLogger`.
* Added `printer` static field to `TerminalLogger`.

## 1.2.0

* Added event filtering: Each logger instance now has an optional `event`. This event can be filtered out by changing `VitLogger.eventMatcher`.

## 1.1.0

* Added 'debug' log level.
* Added `useColorfulOutput` option to TerminalLog to improve control. This option is useful to disable colors when using Flutter on web since the browser console does not support ANSI escape codes.
* TerminalLog's 'info' log level now outputs in green color.

## 1.0.0

* Initial version.
