import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quote_and_joke/models/quote_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService with ChangeNotifier {
  List<Quote> _quotes = [];
  Quote qod;
  int _pageOffset = 0;
  //TODO: Napraviti VisibilityService s ova 3 dole atributa
  bool _isLoading = false;
  // hide if screen is being changed so there is no overlap
  bool _showScreen = false;
  bool _isDrag = false;

  List<Quote> get quotes => _quotes;

  bool get isLoading => _isLoading;

  bool get show => _showScreen;

  bool get isDrag => _isDrag;

  void _changeLoadingState() {
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

      _changeLoadingState();
    } else {
      _changeLoadingState();
      throw ("Error fetching data");
    }
  }

  // save generated quote into PreferredSettings
  Future<void> generateQOD() async {
    // final http.Response response =
    //     await http.get("https://quotes.rest/qod.json");

    // if (response.statusCode == 200) {
    //   final decode = jsonDecode(response.body);

    //   var quote = decode['contents']['quotes'][0]['quote'];
    //   var author = decode['contents']['quotes'][0]['author'];
    //   qod = Quote(
    //       quote: quote,
    //       author: author,
    //       authorShort: Quote.createShortAuthor(author));
    // } else {
    // replace with throw("Error fetching data") later
    await Future.delayed(const Duration(seconds: 1));
    qod = Quote(
        quote:
            "We hold ourselves back in ways both big and small, by lacking self-confidence, by not raising our hands, and by pulling back when we should be leaning in.",
        author: "Sheryl Sandberg",
        authorShort: "Sandberg");
    // }
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
