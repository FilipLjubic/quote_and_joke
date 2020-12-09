import 'dart:math';

import 'package:hooks_riverpod/all.dart';
import 'package:quote_and_joke/models/quote_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final quoteProvider = FutureProvider.autoDispose((ref) async {
  final quoteService = QuoteService();

  return quoteService.fetchQuotes();
});

final qodProvider = FutureProvider.autoDispose((ref) async {
  final quoteService = QuoteService();

  return quoteService.getQOD();
});

class QuoteService {
  int _pageOffset = 0;

  Future<List<Quote>> fetchQuotes() async {
    List<Quote> quotes = [];
    _setOffset();
    final http.Response response = await http.get(
        "https://api.quotable.io/quotes?limit=50&skip=$_pageOffset&maxLength=93");

    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);

      for (var result in decode['results']) {
        quotes.add(Quote.fromJson(result));
      }
      return quotes;
    } else {
      throw ("Error fetching data");
    }
  }

  //TODO: save quote into PreferredSettings
  Future<Quote> getQOD() async {
    final http.Response response =
        await http.get("https://quotes.rest/qod.json");

    if (response.statusCode == 200) {
      final jsonString = json.decode(response.body);

      var quote = jsonString['contents']['quotes'][0]['quote'];
      var author = jsonString['contents']['quotes'][0]['author'];
      return Quote(
        quote: quote,
        author: author,
      );
    } else {
      throw ("Error fetching data");
    }
  }

  // to let the api know how many pages to skip so that it doesnt fetch same quotes twice in a row
  // each page has 50 quotes, since thats the limit for 1 request
  void _setOffset() {
    int nextOffset = Random().nextInt(25) * 50; // [0-25] * 50 => [0-1250]
    if (nextOffset == _pageOffset) {
      _setOffset();
    } else {
      _pageOffset = nextOffset;
    }
  }
}
