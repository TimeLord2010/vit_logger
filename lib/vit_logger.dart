library;

import 'package:vit_logger/src/repositories/event_matcher.dart';

export 'src/models/index.dart';
export 'src/repositories/index.dart';

class VitLogger {
  static EventMatcher eventMatcher = EventMatcher();
}
