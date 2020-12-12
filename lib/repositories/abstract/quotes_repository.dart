import 'package:quote_and_joke/models/quote_model.dart';

abstract class QuoteRepository {
  Future<List<Quote>> fetchQuotes();
}
