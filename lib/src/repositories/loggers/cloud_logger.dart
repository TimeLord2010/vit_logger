import 'dart:async';

abstract class CloudLogger<T> {
  int get maxLogs;
  int get minLogs;
  Duration get timerInterval;
  final List<T> _cacheItems = [];

  Timer? _timer;

  /// This method contains the logic to send the logs to the cloud.
  ///
  /// This method should not be called directly, it is manager by [CloudLogger].
  Stream<List<T>> send(Iterable<T> items);

  void processs(T item) {
    _cacheItems.add(item);

    // Aborting if there is not enough items.
    if (_cacheItems.length < maxLogs) {
      return;
    }

    _sendToCloud();
  }

  void _sendToCloud() {
    var items = [..._cacheItems];
    _cacheItems.clear();
    var sentItemsStream = send(items);
    List<T> sentItems = [];
    sentItemsStream.listen(
      (items) => sentItems.addAll(items),
      onError: (err) {
        Iterable<T> itemsNotSent = items.where((x) => !sentItems.contains(x));
        _cacheItems.insertAll(0, itemsNotSent);
        throw err;
      },
    );
  }

  /// Inserts [_cacheItems] into the cloud every [timerInterval].
  void run() {
    assert(
      timerInterval.inSeconds > 2,
      'The timer interval should not be too small',
    );
    _timer = Timer.periodic(timerInterval, (t) {
      if (_cacheItems.length < minLogs) {
        return;
      }
      _sendToCloud();
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
