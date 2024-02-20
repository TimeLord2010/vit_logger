import '../models/lap.dart';

class StopWatch {
  final String event;
  final DateTime start;
  final List<Lap> laps = [];

  StopWatch(this.event) : start = DateTime.now();

  bool _stoped = false;

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
        logInfo('$event (${elapsed}ms)');
      } else {
        logInfo('$event [$tag] (${elapsed}ms)');
      }
    }
    return lap;
  }

  int stop([bool log = true]) {
    if (_stoped) throw Exception('Stopwatch already stoped');
    _stoped = true;
    var lap = Lap.fromLastDate(lastDate);
    laps.add(lap);
    var now = DateTime.now();
    var diff = now.difference(start);
    var totalElapsed = diff.inMilliseconds;
    if (log) logInfo('$event (${totalElapsed}ms)');
    return totalElapsed;
  }
}
