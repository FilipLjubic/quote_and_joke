import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/models/quote_model.dart';
import 'package:quote_and_joke/repositories/abstract/qod_repository.dart';
import 'package:quote_and_joke/utils/exceptions/quote_exception.dart';

class QuotesNotifier extends StateNotifier<AsyncValue<Quote>> {
  QuotesNotifier(this.read, [AsyncValue<Quote> qod])
      : super(qod ?? const AsyncValue.loading()) {
    getQuotes();
  }

  final Reader read;

  Future<void> getQuotes() async {
    try {
      state = AsyncValue.loading();

      final qod = await read(qodRepositoryProvider).fetchQOD();

      state = AsyncValue.data(qod);
    } on QuoteException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
