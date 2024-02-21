import 'package:vit_logger/src/models/enums/timestamp_mode.dart';

String? getTimestampString(TimestampMode mode) {
  if (TimestampMode.none == mode) {
    return null;
  }
  var now = DateTime.now();
  switch (mode) {
    case TimestampMode.none:
      return null;

    // Date and time formats
    case TimestampMode.fullLocal:
      return _getFullDate(now.toLocal());
    case TimestampMode.iso8601:
      return now.toUtc().toIso8601String();

    // Date only formats
    case TimestampMode.dateIso:
      return now.toUtc().toIso8601String().split('T')[0];
    case TimestampMode.date:
      var date = now.toLocal().toIso8601String().split('T')[0];
      return date;

    // Time only formats
    case TimestampMode.time:
      return now.toLocal().toIso8601String().split('T')[1];
    case TimestampMode.timeIso:
      return now.toUtc().toIso8601String().split('T')[1];

    // Number formats
    case TimestampMode.epochTimestamp:
      return now.millisecondsSinceEpoch.toString();
  }
}

String _getFullDate(DateTime date) {
  var year = date.year;
  var month = date.month.toString().padLeft(2, '0');
  var day = date.day.toString().padLeft(2, '0');
  var hour = date.hour.toString().padLeft(2, '0');
  var minute = date.minute.toString().padLeft(2, '0');
  var second = date.second.toString().padLeft(2, '0');
  return '$year-$month-$day $hour:$minute:$second';
}
