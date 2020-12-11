import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quote_and_joke/utils/constants.dart';
import 'package:quote_and_joke/utils/mixins/quote_animation_mixin_fields.dart';
import 'package:quote_and_joke/services/quote_service.dart';
import 'package:quote_and_joke/services/visibility_helper.dart';
import 'package:hooks_riverpod/all.dart';

// Needed so that you can't trigger another animation while one is running
final inAnimationProvider = StateProvider<bool>((ref) => false);

final isDragProvider = StateProvider<bool>((ref) => false);

mixin QuoteAnimationMixin {
  QuoteAnimationMixinFields fields;
  bool _leftDrag = false;
  bool _isSwipe = false;

  void onTap() {
    final context = useContext();
    final inAnimation = context.read(inAnimationProvider);
    final isDrag = context.read(isDragProvider);

    if (inAnimation.state == false) {
      inAnimation.state = true;
      fields.animationController3.forward();

      isDrag.state = false;
    }
  }

  void nextPage() {
    final context = useContext();
    final refetchQuotes = context.read(refetchQuotesProvider);
    final inAnimation = context.read(inAnimationProvider);
    final quoteIndex = context.read(quoteIndexProvider);

    quoteIndex.increaseIndex();

    fields.animationController.value = 0;
    fields.animationController2.value = 0;
    fields.animationController3.value = 0;
    // there are always 50 quotes fetched
    if (quoteIndex.currentIndex + 1 == 50) {
      refetchQuotes();
      quoteIndex.resetIndex();
    }
    inAnimation.state = false;
  }

  void onDragStart(DragStartDetails details) {
    final context = useContext();
    final inAnimation = context.read(inAnimationProvider).state;
    final isDrag = context.read(isDragProvider);
    if (!inAnimation) {
      _leftDrag = fields.animationController.isDismissed &&
          details.globalPosition.dx > 200;
      isDrag.state = true;
    }
  }

  void onDragUpdate(DragUpdateDetails details) {
    final context = useContext();
    final inAnimation = context.read(inAnimationProvider).state;
    if (_leftDrag && !inAnimation) {
      if (details.primaryDelta < -11) {
        _isSwipe = true;
      } else {
        _isSwipe = false;
      }
      // makes dragging smooth instead of linear and awkward
      double delta = -details.primaryDelta /
          (MAX_MAIN_SLIDE * 1.5 * math.log(MAX_MAIN_SLIDE));
      fields.animationController.value += delta;
    }
  }

  void onDragEnd(DragEndDetails details) {
    final context = useContext();
    final inAnimation = context.read(inAnimationProvider);
    if (fields.animationController.isDismissed ||
        fields.animationController.isCompleted) {
      return;
    }
    // if quote is over "half" of screen
    bool isDismissedOrSwiped =
        fields.animationController.value > 0.25 || _isSwipe;
    if (!isDismissedOrSwiped) {
      fields.animationController.reverse();
    } else {
      inAnimation.state = true;
      fields.animationController.forward();
      fields.animationController2.forward();
      _isSwipe = false;
    }
  }
}
