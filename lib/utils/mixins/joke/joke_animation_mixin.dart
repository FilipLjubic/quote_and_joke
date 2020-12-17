import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:quote_and_joke/screens/jokes.dart';
import 'package:quote_and_joke/utils/mixins/joke/joke_animation_mixin_fields.dart';

final jokeInAnimationProvider = StateProvider((ref) => false);

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
      duration: const Duration(milliseconds: 550),
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

  void onTap(BuildContext context) {
    final inAnimation = context.read(jokeInAnimationProvider);
    final showDelivery = context.read(showDeliveryProvider);

    if (inAnimation.state == false) {
      inAnimation.state = true;

      fields.deliveryAnimationController.isCompleted
          ? fields.deliveryAnimationController.reverse()
          : fields.deliveryAnimationController.forward();
      showDelivery.state = !showDelivery.state;

      inAnimation.state = false;
    }
  }
}
