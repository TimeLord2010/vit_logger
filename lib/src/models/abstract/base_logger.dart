import 'dart:async';

import 'package:vit_logger/src/models/enums/log_level.dart';

abstract class BaseLogger {
  const BaseLogger({
    this.event,
  });

  final String? event;

  /// The actual logger function. This function will be called automatically
  /// by "info", "warn", "error" with aditional modifiers to the passing String.
  FutureOr<void> writer({
    required String message,
    required LogLevel level,
  });
}
