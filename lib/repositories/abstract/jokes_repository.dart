import 'package:quote_and_joke/models/joke_models.dart';

abstract class JokeRepository {
  Future<List<JokeTwoPart>> fetchTwoPartJokes();

  Future<List<JokeSingle>> fetchSingleJokes();
}
