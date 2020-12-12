class JokeException implements Exception {
  const JokeException(this.error);

  final error;

  @override
  String toString() {
    return 'Error: $error';
  }
}

const ERROR_CHANCE = 0.3;
