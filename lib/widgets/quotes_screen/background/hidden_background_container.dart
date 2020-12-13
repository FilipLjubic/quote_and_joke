import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quote_and_joke/utils/mixins/quote_animation_mixin_fields.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class HiddenBackgroundContainer extends StatelessWidget {
  const HiddenBackgroundContainer({
    @required this.fields,
    @required this.isDrag,
    @required this.hideBecauseOverflow,
  });

  final QuoteAnimationMixinFields fields;
  final bool isDrag;
  final bool hideBecauseOverflow;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: fields.animationContainerDrag1,
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
        builder: (_, child) {
          double opacity = isDrag && fields.animationContainerDrag1.value >= 0.5
              ? fields.animationContainerDrag1.value * 0.6
              : 0;
          double angleOffset = math.pi / 5 - math.pi / 6.2;

          return Opacity(
            opacity: hideBecauseOverflow ? 0 : opacity,
            child: Transform.rotate(
              angle: -math.pi / 5 +
                  angleOffset * fields.animationContainerDrag1.value,
              child: Transform.translate(
                offset: Offset(SizeConfig.safeBlockHorizontal * 31,
                        SizeConfig.safeBlockVertical * 10) +
                    Offset(SizeConfig.safeBlockHorizontal * 1,
                            SizeConfig.safeBlockVertical * -4) *
                        fields.animationContainerDrag1.value,
                child: child,
              ),
            ),
          );
        });
  }
}
