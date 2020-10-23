import 'package:flutter/material.dart';

class VisibilityService with ChangeNotifier {
  bool _isLoading = false;
  // hide if screen is being changed so there is no overlap
  bool _showScreen = false;
  bool _isDrag = false;

  bool get isLoading => _isLoading;

  bool get show => _showScreen;

  bool get isDrag => _isDrag;

  void changeLoadingState() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void showScreen(bool state) {
    _showScreen = state;
    notifyListeners();
  }

  void setDrag(bool drag) {
    _isDrag = drag;
    notifyListeners();
  }
}
