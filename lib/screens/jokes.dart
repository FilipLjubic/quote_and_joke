import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/state/joke_index_notifier.dart';
import 'package:quote_and_joke/state/two_part_jokes_notifier.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'dart:math' as math;

import 'package:quote_and_joke/widgets/themed_circular_progress_indicator.dart';

// add Nunito font
// onTap pop outa joke

class Jokes extends HookWidget {
  @override
  Widget build(BuildContext context) {
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

    final twoPartJokes = useProvider(twoPartJokesNotifierProvider.state);
    final twoPartJokesIndex = useProvider(twoPartJokeIndexProvider.state);
    useEffect(() {
      containerAnimationController.repeat();
      containerAnimationController2.repeat();
      return () {};
    }, []);

    final showDelivery = useState(false);
    final deliveryAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    return GestureDetector(
      onTap: () => showDelivery.value = !showDelivery.value,
      behavior: HitTestBehavior.opaque,
      // Indexed stack kad budem koristio i single jokeove
      child: Stack(
        children: [
          WobblyContainer(
            animationController: containerAnimationController,
            opacity: 1,
            height: 0.6,
          ),
          WobblyContainer(
            animationController: containerAnimationController2,
            opacity: 0.3,
            height: 0.61,
          ),
          twoPartJokes.when(
            data: (twoPartJokes) => Positioned(
              left: SizeConfig.blockSizeHorizontal * 3,
              top: SizeConfig.screenHeight * 0.25,
              child: SizedBox(
                width: SizeConfig.screenWidth * 0.95,
                child: Text(
                  twoPartJokes[twoPartJokesIndex].setup,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.blockSizeHorizontal * 7.5),
                ),
              ),
            ),
            // TODO: handle error state
            error: (e, st) => Container(
              alignment: Alignment.center,
              child: Text("error!"),
            ),
            loading: () => const Center(
              child: const SizedBox(
                  height: 50,
                  width: 50,
                  child: ThemedCircularProgressIndicator()),
            ),
          ),
          twoPartJokes.when(
              data: (twoPartJokes) => Positioned(
                    bottom: SizeConfig.screenHeight * 0.25,
                    left: SizeConfig.blockSizeHorizontal * 3,
                    child: SizedBox(
                      width: SizeConfig.screenWidth * 0.95,
                      child: AnimatedOpacity(
                        opacity: showDelivery.value ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOutQuad,
                        child: Text(
                          twoPartJokes[twoPartJokesIndex].delivery,
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 7.5,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                  ),
              error: (e, st) => Container(),
              loading: () => Container()),
        ],
      ),
    );
  }
}

class WobblyContainer extends StatelessWidget {
  const WobblyContainer({
    @required this.animationController,
    this.opacity,
    @required this.height,
  });

  final AnimationController animationController;
  final double opacity;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: Opacity(
        opacity: opacity,
        child: Container(
          height: SizeConfig.screenHeight * height,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.8),
                  Theme.of(context).accentColor.withOpacity(0.8),
                ]),
          ),
        ),
      ),
      builder: (_, child) => ClipPath(
        clipper: DrawIdleClipper(animationController.value),
        child: child,
      ),
    );
  }
}

class DrawIdleClipper extends CustomClipper<Path> {
  DrawIdleClipper(this.value);
  var value;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.85);

    final ctrlPoint = Offset(
      size.width * 0.2 + (size.width * 0.07) * math.cos(value * math.pi),
      size.height + 10 * math.sin(value * math.pi),
    );

    path.quadraticBezierTo(
        ctrlPoint.dx, ctrlPoint.dy, size.width * 0.5, size.height * 0.92);

    final ctrlPoint2 = Offset(
      size.width * 0.9 - (size.width * 0.05) * math.cos(value * math.pi),
      size.height * 0.8 - 10 * math.sin(value * math.pi),
    );

    path.quadraticBezierTo(
        ctrlPoint2.dx, ctrlPoint2.dy, size.width, size.height * 0.87);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
