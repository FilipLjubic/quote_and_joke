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
        "The six stages of debugging:\n1. That can't happen.\n2. That doesn't happen on my machine.\n3. That shouldn't happen.\n4. Why does that happen?\n5. Oh, I see.\n6. How did that ever work?";
  }
}
