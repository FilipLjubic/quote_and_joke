import 'dart:math';

import 'package:hooks_riverpod/all.dart';
import 'package:quote_and_joke/models/quote_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quote_and_joke/services/visibility_helper.dart';

final quoteServiceProvider = Provider((ref) => QuoteService(ref.read));

final refetchQuotesProvider = StateNotifierProvider((ref) => Refetch());

final quoteProvider = FutureProvider((ref) async {
  final quoteService = ref.watch(quoteServiceProvider);

  return quoteService.fetchQuotes();
});

final qodProvider = FutureProvider((ref) async {
  final quoteService = ref.watch(quoteServiceProvider);

  return quoteService.getQOD();
});

// TODO: Create repository to check if device has internet connection and handle if it doesn't
// also gonna use _setOffset in it, instead of service class being pAcKeD
class QuoteService {
  QuoteService(this.read);

  int _pageOffset = 0;
  final Reader read;

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
    } else {
      throw Exception("Error fetching data");
    }
    return quotes;
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
    } else if (response.statusCode == 429) {
      return Quote(
          quote: "You only need to click once, fool.", author: 'Mordekeiser');
    } else {
      // only 10 calls of this api are possible per hour
      throw Exception("Error fetching data");
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
