class Lap {
  final String? tag;
  final DateTime date;
  final int elapsed;

  Lap({
    required this.date,
    required this.elapsed,
    this.tag,
  });

  factory Lap.fromLastDate(DateTime last, [String? tag]) {
    var now = DateTime.now();
    var diff = now.difference(last);
    return Lap(
      date: now,
      elapsed: diff.inMilliseconds,
      tag: tag,
    );
  }
}
