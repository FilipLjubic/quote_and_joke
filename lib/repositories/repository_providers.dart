import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/repositories/abstract/jod_repository.dart';
import 'package:quote_and_joke/repositories/abstract/qod_repository.dart';
import 'package:quote_and_joke/repositories/abstract/quotes_repository.dart';

final qodRepositoryProvider =
    Provider<QodRepository>((ref) => throw UnimplementedError);

final jodRepositoryProvider =
    Provider<JodRepository>((ref) => throw UnimplementedError);

final quoteRepositoryProvider =
    Provider<QuoteRepository>((ref) => throw UnimplementedError());

// TODO: implement automatic refetching once connectionStatus changes
