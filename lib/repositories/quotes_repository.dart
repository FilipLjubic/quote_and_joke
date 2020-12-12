import 'package:hooks_riverpod/all.dart';
import 'package:quote_and_joke/models/quote_model.dart';

abstract class QuoteRepository {
  Future<List<Quote>> fetchQuotes();

  Future<Quote> fetchQOD();
}

final quoteRepositoryProvider =
    Provider<QuoteRepository>((ref) => throw UnimplementedError());
