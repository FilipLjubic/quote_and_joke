import 'dart:math';

import 'package:quote_and_joke/models/joke_models.dart';
import 'package:quote_and_joke/repositories/abstract/jokes_repository.dart';
import 'package:quote_and_joke/utils/exceptions/network_exception.dart';

final _sampleTwoPartJokes = [
  JokeTwoPart(
      setup: "Anton, do you think I’m a bad mother?",
      delivery: "My name is Paul.")
];

final _sampleSingleJokes = [
  JokeSingle(text: "Java told C a joke, but he didn't get the reference.")
];

final _sampleJod = JokeSingle(
    text: "Anton, do you think I’m a bad mother?\r\nMy name is Paul.\r\n\r\n");

class FakeJokeRepository implements JokeRepository {
  FakeJokeRepository()
      : cachedSingleJokes = _sampleSingleJokes,
        cachedTwoPartJokes = _sampleTwoPartJokes,
        cachedJod = _sampleJod;

  final random = Random();
  final JokeSingle cachedJod;
  final List<JokeSingle> cachedSingleJokes;

  final List<JokeTwoPart> cachedTwoPartJokes;

  @override
  Future<List<JokeSingle>> fetchSingleJokes() async {
    await _waitRandomTime();

    if (random.nextDouble() < ERROR_CHANCE) {
      throw const NetworkException("Error fetching one part jokes");
    } else {
      return cachedSingleJokes;
    }
  }

  @override
  Future<List<JokeTwoPart>> fetchTwoPartJokes() async {
    await _waitRandomTime();

    if (random.nextDouble() < ERROR_CHANCE) {
      throw const NetworkException("Error fetching two part jokes");
    } else {
      return cachedTwoPartJokes;
    }
  }

  @override
  Future<JokeSingle> fetchJod() async {
    await _waitRandomTime();

    if (random.nextDouble() < ERROR_CHANCE) {
      throw const NetworkException("Error fetching QOD");
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
