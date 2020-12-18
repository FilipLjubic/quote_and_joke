import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/models/joke_models.dart';
import 'package:quote_and_joke/repositories/repository_providers.dart';
import 'package:quote_and_joke/utils/exceptions/network_exception.dart';

final singleJokesNotifierProvider = StateNotifierProvider<JokeSingleNotifier>(
    (ref) => JokeSingleNotifier(ref.read));

class JokeSingleNotifier extends StateNotifier<AsyncValue<List<JokeSingle>>> {
  JokeSingleNotifier(this.read, [AsyncValue<List<JokeSingle>> jokeSingles])
      : super(jokeSingles ?? const AsyncValue.loading()) {
    getJokeSingles();
  }

  final Reader read;

  Future<void> getJokeSingles() async {
    try {
      state = AsyncValue.loading();

      final jokes = await read(jokeRepositoryProvider).fetchSingleJokes();

      state = AsyncValue.data(jokes);
    } on NetworkException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
