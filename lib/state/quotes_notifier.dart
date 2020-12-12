import 'package:hooks_riverpod/all.dart';
import 'package:quote_and_joke/models/quote_model.dart';
import 'package:quote_and_joke/repositories/abstract/quotes_repository.dart';
import 'package:quote_and_joke/utils/exceptions/quote_exception.dart';

final quotesNotifierProvider =
    StateNotifierProvider<QuotesNotifier>((ref) => QuotesNotifier(ref.read));

class QuotesNotifier extends StateNotifier<AsyncValue<List<Quote>>> {
  QuotesNotifier(this.read, [AsyncValue<List<Quote>> quotes])
      : super(quotes ?? const AsyncValue.loading()) {
    getQuotes();
  }

  final Reader read;

  Future<void> getQuotes() async {
    try {
      state = AsyncValue.loading();

      final quotes = await read(quoteRepositoryProvider).fetchQuotes();

      state = AsyncValue.data(quotes);
    } on QuoteException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
