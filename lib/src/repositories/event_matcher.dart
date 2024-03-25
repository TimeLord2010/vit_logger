class EventMatcher {
  List<RegExp>? patterns;

  bool shouldLogEvent(String? event) {
    if (event == null) return true;
    return switch (patterns) {
      null => true,
      [] => false,
      List<RegExp> matchers => matchers.any((x) => x.hasMatch(event)),
    };
  }
}
