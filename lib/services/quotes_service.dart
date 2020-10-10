import 'package:quote_and_joke/models/quote_model.dart';

class QuoteService {
  List<String> getQuotes() {
    // will be api call
    final List<String> quotes = [
      "It's so hard to forget pain, but it's even harder to remember sweetness.",
      'Darkness cannot drive out darkness, only light can do that.',
      "Even the smallest person can change the course of the future.",
    ];
    return quotes;
  }
}
