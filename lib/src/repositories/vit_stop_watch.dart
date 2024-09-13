import 'package:vit_logger/src/models/abstract/text_logger.dart';

import '../models/lap.dart';

class VitStopWatch {
  /// The event attached to the stop watch.
  final String event;

  final TextLogger? logger;
  final void Function(String msg, int mili)? loggerFn;
  final DateTime start;
  final List<Lap> laps = [];

  /// If given, only logs at [stop], if the time elapsed since the intance
  /// creation is greater than [minDuration].
  final Duration? minDuration;

  VitStopWatch._(
    this.event, {
    this.logger,
    this.loggerFn,
    this.minDuration,
  }) : start = DateTime.now();

  factory VitStopWatch.logger(
    String event, {
    required TextLogger logger,
    Duration? minDuration,
  }) {
    return VitStopWatch._(
      event,
      logger: logger,
      minDuration: minDuration,
    );
  }

  factory VitStopWatch.function(
    String event, {
    required void Function(String msg, int mili)? logger,
    Duration? minDuration,
  }) {
    return VitStopWatch._(
      event,
      loggerFn: logger,
      minDuration: minDuration,
    );
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

  void _log(String msg, int mili) {
    if (logger != null) {
      logger!.info(msg);
    } else {
      loggerFn!(msg, mili);
    }
  }

  Lap lap({
    bool log = true,
    String? tag,
  }) {
    if (_stoped) throw Exception('Stopwatch already stoped');
    var lap = Lap.fromLastDate(lastDate);
    laps.add(lap);
    int elapsed = lap.elapsed;
    if (log) {
      if (tag == null) {
        _log('$event (${elapsed}ms)', elapsed);
      } else {
        _log('$event [$tag] (${elapsed}ms)', elapsed);
      }
    }
    return lap;
  }

  /// Returns total time elapsed in [event].
  int stop([bool log = true]) {
    if (_stoped) throw Exception('Stopwatch already stoped');
    _stoped = true;
    var lap = Lap.fromLastDate(lastDate);
    laps.add(lap);
    var now = DateTime.now();
    Duration diff = now.difference(start);
    var totalElapsed = diff.inMilliseconds;
    if (log) {
      var message = '$event (${totalElapsed}ms)';
      if (minDuration != null) {
        if (diff.compareTo(minDuration!) > 0) {
          _log(message, totalElapsed);
        }
      } else {
        _log(message, totalElapsed);
      }
    }
    return totalElapsed;
  }
}
