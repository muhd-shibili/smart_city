import 'package:flutter/material.dart';

enum _ViewState { ideal, busy }

class BaseProvider extends ChangeNotifier {
  bool _mounted = true;

  bool get mounted => _mounted;

  _ViewState _viewState = _ViewState.ideal;

  bool get isBusy => _viewState == _ViewState.busy;

  void setViewBusy({
    bool notify = true,
  }) {
    _viewState = _ViewState.busy;
    if (notify && _mounted) {
      notifyListeners();
    }
  }

  void setViewIdeal({
    bool notify = true,
  }) {
    _viewState = _ViewState.ideal;
    if (notify && _mounted) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }
}
