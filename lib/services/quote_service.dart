import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quote_and_joke/models/quote_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService with ChangeNotifier {
  List<Quote> _quotes = [];
  int _pageOffset = 0;
  bool _isLoading = false;
  bool _showScreen = false;

  List<Quote> get quotes => _quotes;

  bool get show => _showScreen;

  bool get isLoading => _isLoading;

  Future<void> fetchQuotes() async {
    _changeLoadingState();

    _quotes.clear();
    _setOffset();
    final http.Response response = await http.get(
        "https://api.quotable.io/quotes?limit=50&skip=$_pageOffset&maxLength=93");

    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);

      for (var result in decode['results']) {
        _quotes.add(Quote.fromJson(result));
      }
      _quotes.forEach(
          (element) => print("${element.quote.length} ${element.quote}"));
      _changeLoadingState();
    } else {
      _changeLoadingState();
      throw ("Error fetching data");
    }
  }

  void showScreen(bool state) {
    _showScreen = state;
    notifyListeners();
  }

  void _changeLoadingState() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  // to let the api know how many pages to skip
  // each page has 50 quotes, since thats the limit for 1 request
  void _setOffset() {
    int nextOffset = Random().nextInt(25) * 50; // [0-25] * 50 => [0-1250]
    if (nextOffset == _pageOffset) {
      _setOffset();
    }
    _pageOffset = nextOffset;
  }
}
