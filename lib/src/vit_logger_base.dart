class VitLogger {
  VitLogger();

  void logInfo(String msg) {
    _log(msg, (message) => print(message));
  }

  void logError(String msg) {
    _log(msg, (message) => _error(message));
  }

  void logWarn(String msg) {
    _log(msg, (message) => _warn(message));
  }

  void _log(String msg, void Function(String message) func) {
    var dt = DateTime.now();
    var iso = dt.toIso8601String().split('T')[1];
    var parts = iso.split('.');
    parts[1] = parts[1].substring(0, 1);
    iso = parts.join('.');
    func('$iso: $msg');
  }

  void _warn(String text) {
    print('\x1B[33m$text\x1B[0m');
  }

  void _error(String text) {
    print('\x1B[31m$text\x1B[0m');
  }
}
