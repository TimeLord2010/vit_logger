import '../data/enums/log_level.dart';
import '../data/models/lap.dart';
import 'loggers/terminal_logger.dart';

class VitStopWatch {
  /// The event associated with the stopwatch, represented as a string.
  final String event;

  /// A function for logging messages, which takes a string message and
  /// an integer representing milliseconds.
  late final void Function(StopWatchLapData data, LogLevel level) loggerFn;

  /// The timestamp when the stopwatch was created.
  final DateTime start;

  /// A list storing the recorded laps.
  final List<Lap> laps = [];

  /// The minimum duration threshold for marking logs as warnings.
  ///
  /// Logs produced after a duration greater than [minWarnDuration],
  /// from when the instance was created, are marked as warnings.
  /// If [minErrorDuration] is set and exceeded, logs are marked as
  /// errors instead.
  final Duration? minWarnDuration;

  /// The minimum duration threshold for marking logs as errors.
  ///
  /// Logs produced after a duration greater than [minErrorDuration],
  /// calculated from the instance's creation time, are marked as errors.
  final Duration? minErrorDuration;

  VitStopWatch(
    this.event, {
    void Function(StopWatchLapData data, LogLevel level)? logger,
    this.minWarnDuration,
    this.minErrorDuration,
  }) : start = DateTime.now() {
    loggerFn = logger ??
        (data, level) async {
          var event = data.event;
          var tag = data.tag;
          var milli = data.lap.lapElapsed.inMilliseconds;
          String msg;
          if (tag == null) {
            msg = '$event (${milli}ms)';
          } else {
            msg = '$event [$tag] (${milli}ms)';
          }
          var terminalLogger = TerminalLogger(event: event);
          await terminalLogger.log(
            message: msg,
            level: level,
          );
        };
  }

  bool _stoped = false;

  /// The date object at the time the stop watch was created.
  ///
  /// If you called [lap], then this is the date object at the time the method
  /// was called.
  DateTime get lastDate {
    if (laps.isEmpty) return start;
    return laps.last.date;
  }

  /// Create a lap object and logs if necessary.
  Lap _createLap(String? tag, [bool isLastLap = false]) {
    // Creating lap
    DateTime? getLapDate() {
      if (laps.isEmpty) return null;
      return laps.last.date;
    }

    var lap = Lap.create(
      eventStartDate: start,
      lastLapDate: getLapDate(),
      tag: tag,
      isLast: isLastLap,
    );

    // Logging
    var data = StopWatchLapData(
      event: event,
      lap: lap,
      tag: tag,
    );
    var duration = lap.eventElapsed;
    LogLevel level = LogLevel.info;
    if (minErrorDuration != null && duration > minErrorDuration!) {
      level = LogLevel.error;
    } else if (minWarnDuration != null && duration > minWarnDuration!) {
      level = LogLevel.warn;
    }
    loggerFn(data, level);

    return lap;
  }

  Lap lap({
    String? tag,
  }) {
    if (_stoped) throw Exception('Stopwatch already stoped');
    var lap = _createLap(tag);
    laps.add(lap);

    return lap;
  }

  /// Returns total time elapsed in [event].
  Duration stop([bool log = true]) {
    if (_stoped) throw Exception('Stopwatch already stoped');
    _stoped = true;
    var lap = _createLap(null, true);
    laps.add(lap);
    return lap.eventElapsed;
  }
}

class StopWatchLapData {
  final String event;
  String? tag;
  Lap lap;

  StopWatchLapData({
    required this.event,
    required this.lap,
    this.tag,
  });
}
