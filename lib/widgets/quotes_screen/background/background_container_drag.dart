import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/services/visibility_helper.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class BackgroundContainerDrag extends HookWidget {
  const BackgroundContainerDrag({
    @required this.animationController,
    @required this.angle,
    @required this.angleEnd,
    @required this.opacity,
    @required this.opacityReduction,
    @required this.offset,
    @required this.translation,
  });

  final Animation animationController;
  final double angle;
  final double angleEnd;
  final double opacity;
  final double opacityReduction;
  final Offset offset;
  final Offset translation;

  @override
  Widget build(BuildContext context) {
    final angleOffset = useMemoized(() => -angle + angleEnd);
    final hideBecauseOverflow = useProvider(hideScreenProvider).state;

    return AnimatedBuilder(
      animation: animationController,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xFF6FD9E2), Color(0xFFDBDFB8)],
          ),
        ),
        height: SizeConfig.screenHeight / 1.3,
        width: SizeConfig.screenWidth * 2,
      ),
      builder: (_, child) => Opacity(
        opacity: hideBecauseOverflow
            ? 0
            : opacity - opacityReduction * animationController.value,
        child: Transform.rotate(
          angle: angle + angleOffset * animationController.value,
          child: Transform.translate(
            offset: offset + translation * animationController.value,
            child: child,
          ),
        ),
      ),
    );
  }
}
