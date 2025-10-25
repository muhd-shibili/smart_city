import 'dart:async';
import 'dart:ui';

class DebounceHelper {
  Timer? _timer;

  DebounceHelper();

  void run(VoidCallback action, {int milliseconds = 500}) {
    _timer?.cancel();
    _timer = Timer(
      Duration(milliseconds: milliseconds),
      action,
    );
  }

  void dispose() {
    _timer?.cancel();
  }
}
