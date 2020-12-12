class QuoteException implements Exception {
  const QuoteException(this.error);

  final error;

  @override
  String toString() {
    return 'Error: $error';
  }
}

const ERROR_CHANCE = 0.3;
