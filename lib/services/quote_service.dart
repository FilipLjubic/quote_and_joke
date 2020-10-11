import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quote_and_joke/models/quote_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService with ChangeNotifier {
  List<Quote> _quotes = [];
  int _offset = 0;
  bool _isLoading = false;

  List<Quote> get quotes => _quotes;

  bool get isLoading => _isLoading;

  Future<void> fetchQuotes() async {
    _changeLoadingState();

    _quotes.clear();
    _setOffset();
    final http.Response response =
        await http.get("https://api.quotable.io/quotes?limit=50&skip=$_offset");

    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);

      for (var result in decode['results']) {
        _quotes.add(Quote.fromJson(result));
      }
      _quotes.forEach((element) => print(element.author));
      _changeLoadingState();
    } else {
      _changeLoadingState();
      throw ("Error fetching data");
    }
  }

  void _changeLoadingState() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  // to let the api know how many pages to skip
  // each page has 50 quotes, since thats the limit for 1 request
  void _setOffset() {
    int nextOffset = Random().nextInt(40) * 50; // [0-39] * 50 => [0-1950]
    if (nextOffset == 1950) nextOffset = 1945;

    if (nextOffset == _offset) {
      _setOffset();
    }
    _offset = nextOffset;
  }
}
