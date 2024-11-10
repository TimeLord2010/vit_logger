class Lap {
  final String? tag;
  final DateTime eventStartDate;
  final DateTime? lastLapDate;
  final DateTime date;
  final bool isLast;

  Lap({
    required this.date,
    required this.eventStartDate,
    this.lastLapDate,
    this.isLast = false,
    this.tag,
  });

  factory Lap.create({
    required DateTime eventStartDate,
    DateTime? lastLapDate,
    String? tag,
    bool isLast = false,
  }) {
    return Lap(
      date: DateTime.now(),
      eventStartDate: eventStartDate,
      lastLapDate: lastLapDate,
      isLast: isLast,
      tag: tag,
    );
  }

  /// The duration between the current lap and the start of the event.
  Duration get eventElapsed => date.difference(eventStartDate);

  /// The duration between the current lap and the last one.
  ///
  /// If this is the first last, this will behave loke [eventElapsed].
  Duration get lapElapsed => date.difference(lastLapDate ?? eventStartDate);
}
