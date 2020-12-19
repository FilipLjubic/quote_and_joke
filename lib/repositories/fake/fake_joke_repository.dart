import 'dart:math';

import 'package:quote_and_joke/models/joke_models.dart';
import 'package:quote_and_joke/repositories/abstract/jokes_repository.dart';
import 'package:quote_and_joke/utils/exceptions/network_exception.dart';

final _sampleTwoPartJokes = [
  JokeTwoPart(
      setup: "Why do most married men die before their wives?",
      delivery: "Because they want to."),
  JokeTwoPart(
      setup: "What do diapers and Politicians have in common?",
      delivery:
          "They both need changing regularly - for exactly the same reason."),
  JokeTwoPart(
    setup: "What is the definition of the early evening news",
    delivery:
        'It starts with the words "Good evening" then spends the next half an hour tellling you why it isn\'t one.',
  ),
  JokeTwoPart(
      setup: "What device will find furniture in a poorly lit room every time?",
      delivery: "Your shinbone."),
  JokeTwoPart(
      setup: "Why do parents give children a middle name?",
      delivery: "So the child knows when it is in seriously in trouble."),
  JokeTwoPart(
      setup: "What is another name for female Viagra?", delivery: "A Diamond "),
  JokeTwoPart(
      setup:
          "What did the cowboy say went he went into the car showroom in Germany?",
      delivery: " Audi."),
  JokeTwoPart(
      setup:
          "What is the quickest way to speed up your 70 year old husband’s heart rate?",
      delivery: "Tell him that you are pregnant ."),
  JokeTwoPart(
      setup: "What three letters alter boys into men and girls into women? ?",
      delivery: "Age."),
  JokeTwoPart(
      setup: "Why are fish so easy to weigh? ?",
      delivery: "Because they have their own scales."),
];

final _sampleSingleJokes = [
  JokeSingle(text: "Java told C a joke, but he didn't get the reference."),
  JokeSingle(text: "Java told C a joke, but he didn't get the memo."),
  JokeSingle(text: "Java told C a joke, but he didn't get it."),
  JokeSingle(text: "Java told C a joke, but he didn't getIt."),
];

final _sampleJod = JokeSingle(
    text:
        'Yesterday I saw a guy spill all his Scrabble letters on the road. I asked him: "What\'s the word on the street?"');

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
