import 'package:vit_logger/src/models/abstract/text_logger.dart';
import 'package:vit_logger/src/repositories/loggers/terminal_logger.dart';

import '../models/lap.dart';

class VitStopWatch {
  final TextLogger logger;
  final String event;
  final DateTime start;
  final List<Lap> laps = [];

  VitStopWatch(
    this.event, {
    this.logger = const TerminalLogger(),
  }) : start = DateTime.now();

  bool _stoped = false;

  /// The date object at the time the stop watch was created.
  ///
  /// If you called [lap], then this is the date object at the time the method
  /// was called.
  DateTime get lastDate {
    if (laps.isEmpty) return start;
    return laps.last.date;
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
        logger.info('$event (${elapsed}ms)');
      } else {
        logger.info('$event [$tag] (${elapsed}ms)');
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
    var diff = now.difference(start);
    var totalElapsed = diff.inMilliseconds;
    if (log) logger.info('$event (${totalElapsed}ms)');
    return totalElapsed;
  }
}
