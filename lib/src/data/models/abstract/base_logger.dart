import 'dart:async';

import '../../../../vit_logger.dart';

abstract class BaseLogger {
  const BaseLogger({
    this.event,
  });

  final String? event;

  /// Checks if the current [event] should be logged by matching it with
  /// [VitLogger.eventMatchers].
  /// If not, the log won't be effective.
  ///
  /// This is the function that should be used in [BaseLogger]
  /// implementations.
  FutureOr<void> log({
    required String message,
    required LogLevel level,
  }) async {
    var shouldLogEvent = VitLogger.eventMatcher.shouldLogEvent(event);
    if (!shouldLogEvent) {
      return;
    }
    await writer(
      level: level,
      message: message,
    );
  }

  /// The actual logger function containing the implementation to log the
  /// message.
  FutureOr<void> writer({
    required String message,
    required LogLevel level,
  });
}
