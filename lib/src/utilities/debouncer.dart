import 'dart:async';
import 'dart:ui';

class Debouncer {
  Debouncer({required this.milliseconds});

  late VoidCallback action;
  Timer? _timer;
  final int milliseconds;

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
