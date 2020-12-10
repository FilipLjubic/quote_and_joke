import 'package:flutter/material.dart';

// Class where all the boilerplate for initializing animations is

class AnimationMixinFields {
  AnimationController animationController;
  AnimationController animationController2;
  AnimationController animationController3;
  Animation animation1;
  Animation animation2;
  Animation animation3;
  Animation animation3pt1;
  Animation animation3pt2;
  Animation animationContainerTap1;
  Animation animationContainerTap2;
  Animation animationContainerTap3;
  Animation animationContainerTap4;
  Animation animationContainerDrag1;
  Animation animationContainerDrag2;
  Animation animationContainerDrag3;
  Animation animationContainerDrag4;

  AnimationMixinFields._(
    this.animationController,
    this.animationController2,
    this.animationController3,
    this.animation1,
    this.animation2,
    this.animation3,
    this.animation3pt1,
    this.animation3pt2,
    this.animationContainerTap1,
    this.animationContainerTap2,
    this.animationContainerTap3,
    this.animationContainerTap4,
    this.animationContainerDrag1,
    this.animationContainerDrag2,
    this.animationContainerDrag3,
    this.animationContainerDrag4,
  );

  factory AnimationMixinFields(
      AnimationController animationController,
      AnimationController animationController2,
      AnimationController animationController3) {
    final _animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(curve: Interval(0.0, 0.875), parent: animationController),
    );

    final _animationContainerDrag1 =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 0.875, curve: Curves.easeOut),
      ),
    );
    final _animationContainerDrag2 =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.05, 0.93, curve: Curves.easeOut),
      ),
    );
    final _animationContainerDrag3 =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.07, 0.96, curve: Curves.easeOut),
      ),
    );
    final _animationContainerDrag4 =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.1, 1.0, curve: Curves.easeOut),
      ),
    );

    final _animation2 = CurvedAnimation(
        curve: Curves.easeOutCubic, parent: animationController2);

    final _animation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.0, 0.8, curve: Curves.easeOut),
          parent: animationController3),
    );

    final _animation3pt1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.0, 0.375, curve: Curves.easeOut),
          parent: animationController3),
    );
    final _animation3pt2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.2, 0.75, curve: Curves.easeOut),
          parent: animationController3),
    );

    final _animationContainerTap1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.0, 0.75, curve: Curves.easeOut),
          parent: animationController3),
    );
    final _animationContainerTap2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.05, 0.8, curve: Curves.easeOut),
          parent: animationController3),
    );
    final _animationContainerTap3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.08, 0.9, curve: Curves.easeOut),
          parent: animationController3),
    );
    final _animationContainerTap4 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(0.12, 1, curve: Curves.easeOut),
          parent: animationController3),
    );

    return AnimationMixinFields._(
      animationController,
      animationController2,
      animationController3,
      _animation1,
      _animation2,
      _animation3,
      _animation3pt1,
      _animation3pt2,
      _animationContainerTap1,
      _animationContainerTap2,
      _animationContainerTap3,
      _animationContainerTap4,
      _animationContainerDrag1,
      _animationContainerDrag2,
      _animationContainerDrag3,
      _animationContainerDrag4,
    );
  }
}
