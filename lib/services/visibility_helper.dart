import 'package:hooks_riverpod/hooks_riverpod.dart';

final quoteIndexProvider = StateNotifierProvider((ref) => QuoteIndex());

/// Is used because containers on quote screen overflow
/// so when we're changing from quote screen we want it to hide itself after a mini-delay
final hideScreenProvider = StateProvider<bool>((ref) => true);

/// to either show qod or jod
final showQodProvider = StateProvider<bool>((ref) => true);

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
