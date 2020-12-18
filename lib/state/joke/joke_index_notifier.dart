import 'package:hooks_riverpod/hooks_riverpod.dart';

final twoPartJokeIndexProvider = StateNotifierProvider((ref) => TwoPartIndex());

final singleJokeIndexProvider =
    StateNotifierProvider((ref) => SingleJokeIndex());

class SingleJokeIndex extends StateNotifier<int> {
  SingleJokeIndex() : super(0);

  int get currentIndex => state;

  // svakih 10
  void resetIndex() {
    state = 0;
  }

  void increaseIndex() {
    state = state + 1;
  }
}

class TwoPartIndex extends StateNotifier<int> {
  TwoPartIndex() : super(0);

  int get currentIndex => state;

  // svakih 10
  void resetIndex() {
    state = 0;
  }

  void changeIndex(int index) {
    state = index;
  }
}
