library;

import 'package:vit_logger/src/repositories/event_matcher.dart';

export 'src/data/enums/log_level.dart';
export 'src/data/enums/terminal_printer.dart';
export 'src/data/enums/timestamp_mode.dart';
export 'src/data/models/abstract/base_logger.dart';
export 'src/data/models/abstract/text_logger.dart';
export 'src/data/models/lap.dart';
export 'src/repositories/event_matcher.dart';
export 'src/repositories/loggers/cloud_logger.dart';
export 'src/repositories/loggers/terminal_logger.dart';
export 'src/repositories/vit_stop_watch.dart';
export 'src/usecases/get_timestamp_string.dart';

class VitLogger {
  static EventMatcher eventMatcher = EventMatcher();
}
