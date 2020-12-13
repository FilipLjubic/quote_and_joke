class NetworkException implements Exception {
  const NetworkException(this.error);

  final error;

  @override
  String toString() {
    return 'Error: $error';
  }
}

const ERROR_CHANCE = 0.1;
