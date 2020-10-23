import 'package:flutter/material.dart';

class VisibilityService with ChangeNotifier {
  bool _isLoading = false;
  // hide if screen is being changed so there is no overlap
  bool _showScreen = false;
  bool _isDrag = false;
  bool _isQuoteOfDaySelected = true;
  int _quoteIndex = 0;

  int get quoteIndex => _quoteIndex;

  bool get isQuoteOfDaySelected => _isQuoteOfDaySelected;

  bool get isLoading => _isLoading;

  bool get show => _showScreen;

  bool get isDrag => _isDrag;

  void increaseIndex() {
    _quoteIndex++;
    notifyListeners();
  }

  void resetIndex() {
    _quoteIndex = 0;
    notifyListeners();
  }

  void changeButtonSelected() {
    _isQuoteOfDaySelected = !_isQuoteOfDaySelected;
    notifyListeners();
  }

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
