import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/models/quote_model.dart';

final qodRepositoryProvider =
    Provider<QodRepository>((ref) => throw UnimplementedError);

abstract class QodRepository {
  Future<Quote> fetchQOD();
}
