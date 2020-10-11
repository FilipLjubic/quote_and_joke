import 'dart:math';

import 'package:quote_and_joke/models/quote_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService {
  List<QuoteModel> _quotes = [];
  int _offset = 0;

  List<QuoteModel> get quotes => _quotes;

  Future<void> fetchQuotes() async {
    _quotes.clear();
    _setOffset();
    final http.Response response =
        await http.get("https://api.quotable.io/quotes?limit=50&skip=$_offset");

    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);

      for (var result in decode['results']) {
        _quotes.add(QuoteModel.fromJson(result));
      }
      _quotes.forEach((element) => print(element.authorShort));
      _quotes.forEach((element) => print(element.author));
    }
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
