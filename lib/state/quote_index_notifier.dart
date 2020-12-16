import 'package:hooks_riverpod/hooks_riverpod.dart';

final quoteIndexProvider = StateNotifierProvider((ref) => QuoteIndex());

class QuoteIndex extends StateNotifier<int> {
  QuoteIndex() : super(0);

  int get currentIndex => state;

  void resetIndex() {
    state = 0;
  }

  void increaseIndex() {
    state = state + 1;
  }
}
