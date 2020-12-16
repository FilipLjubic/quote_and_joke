class NetworkException implements Exception {
  const NetworkException(this.error);

  final error;

  @override
  String toString() {
    return '$error';
  }
}

const ERROR_CHANCE = 0.02;
