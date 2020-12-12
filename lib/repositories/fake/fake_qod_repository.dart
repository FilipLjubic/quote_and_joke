import 'dart:math';

import 'package:quote_and_joke/models/quote_model.dart';
import 'package:quote_and_joke/repositories/abstract/qod_repository.dart';
import 'package:quote_and_joke/utils/exceptions/quote_exception.dart';

final _sampleQOD = Quote(
    quote: 'Go put your creed into the deed. Nor speak with double tongue.',
    author: 'Ralph Waldo Emerson',
    authorShort: 'Emerson');

class FakeQodRepository implements QodRepository {
  FakeQodRepository() : cachedQod = _sampleQOD;

  final random = Random();
  final Quote cachedQod;

  @override
  Future<Quote> fetchQOD() async {
    await _waitRandomTime();

    if (random.nextDouble() < ERROR_CHANCE) {
      throw const QuoteException("Error fetching QOD");
    } else {
      return cachedQod;
    }
  }

  /// Simulates API call
  Future<void> _waitRandomTime() async {
    await Future.delayed(
      Duration(seconds: random.nextInt(3)),
      () {},
    ); // simulate loading
  }
}
