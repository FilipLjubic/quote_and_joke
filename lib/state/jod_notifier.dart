import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/models/joke_models.dart';
import 'package:quote_and_joke/repositories/repository_providers.dart';
import 'package:quote_and_joke/utils/exceptions/network_exception.dart';

final jodNotifierProvider =
    StateNotifierProvider<JodNotifier>((ref) => JodNotifier(ref.read));

class JodNotifier extends StateNotifier<AsyncValue<JokeSingle>> {
  JodNotifier(this.read, [AsyncValue<JokeSingle> jod])
      : super(jod ?? const AsyncValue.loading()) {
    getJokeSingles();
  }

  final Reader read;

  Future<void> getJokeSingles() async {
    try {
      state = AsyncValue.loading();

      final jod = await read(jodRepositoryProvider).fetchJOD();

      state = AsyncValue.data(jod);
    } on NetworkException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
