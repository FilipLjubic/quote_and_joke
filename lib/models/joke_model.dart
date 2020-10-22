class Joke {
  JokeType type; // single or twopart
  String text; // if single
  String setup; // if twopart
  String delivery; // if twopart

  Joke({this.text, String type, this.setup, this.delivery}) {
    // convert type to enum
    this.type = convertStringToType(type);
  }

  static JokeType convertStringToType(String type) {
    return JokeType.values
        .firstWhere((e) => e.toString() == type, orElse: () => null);
  }
}

enum JokeType { single, twopart }
