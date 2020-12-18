import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/models/quote_model.dart';
import 'package:quote_and_joke/repositories/repository_providers.dart';
import 'package:quote_and_joke/utils/exceptions/network_exception.dart';

final qodNotifierProvider =
    StateNotifierProvider<QodNotifier>((ref) => QodNotifier(ref.read));

class QodNotifier extends StateNotifier<AsyncValue<Quote>> {
  QodNotifier(this.read, [AsyncValue<Quote> qod])
      : super(qod ?? const AsyncValue.loading()) {
    getQod();
  }

  final Reader read;

  Future<void> getQod() async {
    try {
      state = AsyncValue.loading();

      final qod = await read(quoteRepositoryProvider).fetchQOD();

      state = AsyncValue.data(qod);
    } on NetworkException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
