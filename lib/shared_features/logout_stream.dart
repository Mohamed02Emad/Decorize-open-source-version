import 'dart:async';

final DataStream logoutStream = DataStream();

class DataStream {
  DataStream() : _subscriptions = [];
  final _controller = StreamController<String>.broadcast();
  final List<StreamSubscription<String>> _subscriptions;

  Stream<String> get stream => _controller.stream;

  void addData(String data) {
    _controller.sink.add(data);
  }

  void addListener(void Function(String data) listener) {
    final subscription = _controller.stream.listen(listener);
    _subscriptions.add(subscription);
  }

  void removeListener(StreamSubscription<String> subscription) {
    subscription.cancel();
  }

  void removeAllListeners() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }

  void dispose() {
    _controller.close();
  }
}
