import 'dart:math';

import 'package:quote_and_joke/models/joke_models.dart';
import 'package:quote_and_joke/repositories/abstract/jod_repository.dart';
import 'package:quote_and_joke/utils/exceptions/joke_exception.dart';

final _sampleJOD = JokeSingle(
    text: "Anton, do you think I’m a bad mother?\r\nMy name is Paul.\r\n\r\n");

class FakeJodRepository implements JodRepository {
  FakeJodRepository() : cachedJod = _sampleJOD;

  final random = Random();
  final JokeSingle cachedJod;

  @override
  Future<JokeSingle> fetchJOD() async {
    await _waitRandomTime();

    if (random.nextDouble() < ERROR_CHANCE) {
      throw const JokeException("Error fetching QOD");
    } else {
      return cachedJod;
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
