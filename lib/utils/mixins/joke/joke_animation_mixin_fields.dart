import 'package:flutter/material.dart';

class JokeAnimationMixinFields {
  AnimationController containerAnimationController;
  AnimationController containerAnimationController2;
  AnimationController deliveryAnimationController;
  Animation deliveryAnimation;

  JokeAnimationMixinFields._(
    this.containerAnimationController,
    this.containerAnimationController2,
    this.deliveryAnimationController,
    this.deliveryAnimation,
  );

  factory JokeAnimationMixinFields(
    AnimationController containerAnimationController,
    AnimationController containerAnimationController2,
    AnimationController deliveryAnimationController,
  ) {
    final _deliveryAnimation = CurvedAnimation(
        curve: Curves.elasticOut,
        parent: deliveryAnimationController,
        reverseCurve: Curves.linear);

    return JokeAnimationMixinFields._(
      containerAnimationController,
      containerAnimationController2,
      deliveryAnimationController,
      _deliveryAnimation,
    );
  }
}
