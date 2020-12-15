import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/models/joke_models.dart';
import 'package:quote_and_joke/repositories/repository_providers.dart';
import 'package:quote_and_joke/utils/exceptions/network_exception.dart';

final twoPartJokesNotifierProvider = StateNotifierProvider<JokeTwoPartNotifier>(
    (ref) => JokeTwoPartNotifier(ref.read));

class JokeTwoPartNotifier extends StateNotifier<AsyncValue<List<JokeTwoPart>>> {
  JokeTwoPartNotifier(this.read, [AsyncValue<List<JokeTwoPart>> jokeTwoParts])
      : super(jokeTwoParts ?? const AsyncValue.loading()) {
    getJokeTwoParts();
  }

  final Reader read;

  Future<void> getJokeTwoParts() async {
    try {
      state = AsyncValue.loading();

      final jokes = await read(jokeRepositoryProvider).fetchTwoPartJokes();

      state = AsyncValue.data(jokes);
    } on NetworkException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
