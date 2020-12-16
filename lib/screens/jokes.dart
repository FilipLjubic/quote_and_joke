import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/state/joke_index_notifier.dart';
import 'package:quote_and_joke/state/two_part_jokes_notifier.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/jokes_screen/wobbly_container.dart';

import 'package:quote_and_joke/widgets/themed_circular_progress_indicator.dart';

// add Nunito font

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

    final deliveryAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 450),
      lowerBound: 0.0,
    );

    final animationValue = useAnimation(
      CurvedAnimation(
          curve: Curves.elasticOut,
          parent: deliveryAnimationController,
          reverseCurve: Curves.linear),
    );

    return GestureDetector(
      onTap: () => deliveryAnimationController.isCompleted
          ? deliveryAnimationController.reverse()
          : deliveryAnimationController.forward(),
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
                child: AnimatedBuilder(
                  animation: deliveryAnimationController,
                  builder: (context, child) => Transform.scale(
                    scale: 0.75 + 0.25 * animationValue,
                    child: Opacity(
                      opacity: deliveryAnimationController.value,
                      child: child,
                    ),
                  ),
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
            loading: () => Container(),
          ),
        ],
      ),
    );
  }
}
