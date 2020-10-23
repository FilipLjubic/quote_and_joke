import 'package:flutter/material.dart';

class JokeService with ChangeNotifier {
  String jod;

  Future<void> generateJOD() async {
    // final http.Response response =
    //     await http.get("https://quotes.rest/qod.json");

    // if (response.statusCode == 200) {
    //   final decode = jsonDecode(response.body);

    //   var quote = decode['contents']['quotes'][0]['quote'];
    //   var author = decode['contents']['quotes'][0]['author'];
    //   qod = Quote(
    //       quote: quote,
    //       author: author,
    //       authorShort: Quote.createShortAuthor(author));
    // } else {
    // replace with throw("Error fetching data") later
    await Future.delayed(const Duration(seconds: 1));
    jod =
        "Java and C were telling jokes. It was C's turn, so he writes something on the wall, points to it and says \"Do you get the reference?\" But Java didn't.";
  }
}
