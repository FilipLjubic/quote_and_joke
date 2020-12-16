import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quote_and_joke/utils/mixins/joke/joke_animation_mixin_fields.dart';

mixin JokeAnimationMixin {
  JokeAnimationMixinFields fields;

  void initializeControllers() {
    final containerAnimationController = useAnimationController(
      duration: const Duration(seconds: 10),
      initialValue: 0,
      lowerBound: -1,
      upperBound: 1,
    );

    final containerAnimationController2 = useAnimationController(
      duration: const Duration(seconds: 7),
      initialValue: 0,
      lowerBound: -1,
      upperBound: 1,
    );

    final deliveryAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 450),
      lowerBound: 0.0,
    );
    fields = useMemoized(
      () => JokeAnimationMixinFields(
        containerAnimationController,
        containerAnimationController2,
        deliveryAnimationController,
      ),
    );
  }
}
