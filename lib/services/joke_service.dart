import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quote_and_joke/models/joke_models.dart';
import 'package:quote_and_joke/utils/exceptions/network_exception.dart';

class JokeService {
  Future<JokeSingle> getDadJoke() async {
    final http.Response response = await http.get("https://icanhazdadjoke.com/",
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      final jsonString = jsonDecode(response.body);

      return JokeSingle(text: jsonString["joke"]);
    } else {
      throw const NetworkException('Error fetching dad joke');
    }
  }

  Future<JokeSingle> fetchQod() async {
    final http.Response response =
        await http.get("https://api.jokes.one/jod.json");

    if (response.statusCode == 200) {
      final jsonString = jsonDecode(response.body);

      return JokeSingle(
          text: jsonString['contents']['jokes'][0]['joke']['text']);
    } else {
      throw const NetworkException('Error fetching joke');
    }
  }
}
