import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Is used because containers on quote screen overflow
/// so when we're changing from quote screen we want it to hide itself after a mini-delay
final hideScreenProvider = StateProvider<bool>((ref) => true);

/// to either show qod or jod
final showQodProvider = StateProvider<bool>((ref) => true);
