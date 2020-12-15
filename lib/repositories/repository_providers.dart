import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/repositories/abstract/jokes_repository.dart';
import 'package:quote_and_joke/repositories/abstract/quotes_repository.dart';

final jokeRepositoryProvider =
    Provider<JokeRepository>((ref) => throw UnimplementedError);

final quoteRepositoryProvider =
    Provider<QuoteRepository>((ref) => throw UnimplementedError());

// TODO: implement automatic refetching once connectionStatus changes
