import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:quote_and_joke/models/joke_models.dart';

final dadJokeProvider = FutureProvider((ref) async {
  final jokeService = JokeService();

  return jokeService.getDadJoke();
});

class JokeService {
  Future<JokeSingle> getDadJoke() async {
    final http.Response response = await http.get("https://icanhazdadjoke.com/",
        headers: {'Accept': 'application/json'});

    JokeSingle dadJoke;
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);

      dadJoke = JokeSingle(text: decode["joke"]);
    } else {
      dadJoke = JokeSingle(
        text: "No internet connection :(",
      );
    }
    return dadJoke;
  }
}
