import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/state/joke_index_notifier.dart';
import 'package:quote_and_joke/state/two_part_jokes_notifier.dart';
import 'package:quote_and_joke/utils/mixins/joke/joke_animation_mixin.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/jokes_screen/wobbly_container.dart';
import 'package:quote_and_joke/widgets/refresh_button.dart';

import 'package:quote_and_joke/widgets/themed_circular_progress_indicator.dart';

final showDeliveryProvider = StateProvider<bool>((ref) => false);

// ignore: must_be_immutable
class Jokes extends HookWidget with JokeAnimationMixin {
  @override
  Widget build(BuildContext context) {
    initializeControllers();

    final inAnimation = useProvider(jokeInAnimationProvider);
    useEffect(() {
      fields.containerAnimationController.repeat();
      fields.containerAnimationController2.repeat();

      fields.deliveryAnimationController.addStatusListener((status) {
        if (status != AnimationStatus.forward &&
            status != AnimationStatus.reverse) {
          inAnimation.state = false;
        }
      });
      return () {};
    }, []);

    final showDelivery = useProvider(showDeliveryProvider).state;

    final twoPartJokes = useProvider(twoPartJokesNotifierProvider.state);
    final twoPartJokesIndex = useProvider(twoPartJokeIndexProvider.state);

    return GestureDetector(
      onTap: () => onTap(context),
      behavior: HitTestBehavior.opaque,
      // Indexed stack kad budem koristio i single jokeove
      child: Stack(
        children: [
          WobblyContainer(
              animationController: fields.containerAnimationController2,
              opacity: 0.4,
              height: 0.61,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          WobblyContainer(
              animationController: fields.containerAnimationController,
              opacity: 1,
              height: 0.6,
              begin: Alignment.bottomLeft,
              end: Alignment.topCenter),
          twoPartJokes.when(
            data: (twoPartJokes) => CarouselSlider.builder(
              itemCount: twoPartJokes.length,
              itemBuilder: (context, index) => Stack(
                children: [
                  Positioned(
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
                  Positioned(
                    bottom: SizeConfig.screenHeight * 0.25,
                    left: SizeConfig.blockSizeHorizontal * 3,
                    child: SizedBox(
                      width: SizeConfig.screenWidth * 0.95,
                      child: AnimatedBuilder(
                        animation: fields.deliveryAnimationController,
                        builder: (context, child) => Transform.scale(
                          scale: fields.deliveryAnimation.value,
                          child: child,
                        ),
                        child: AnimatedOpacity(
                          opacity: showDelivery ? 1 : 0,
                          duration: const Duration(milliseconds: 450),
                          curve: Curves.elasticInOut,
                          child: Text(
                            twoPartJokes[twoPartJokesIndex].delivery,
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 7.5,
                                color: Colors.black87),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              options: CarouselOptions(
                initialPage: twoPartJokesIndex,
                height: SizeConfig.screenHeight,
                enableInfiniteScroll: false,
                disableCenter: true,
                viewportFraction: 1.0,
                onScrolled: (_) => refreshScreen(context),
                onPageChanged: (index, reason) async {
                  final jokes = context.read(twoPartJokesNotifierProvider);
                  final jokesIndex = context.read(twoPartJokeIndexProvider);

                  if (index == 9) {
                    await jokes.getTwoPartJokes();
                    jokesIndex.resetIndex();
                  } else {
                    jokesIndex.changeIndex(index);
                  }
                },
              ),
            ),
            error: (e, st) => Container(
              alignment: Alignment.center,
              child: Text("error!"),
            ),
            loading: () => const Center(
              child: const ThemedCircularProgressIndicator(50.0),
            ),
          ),
          RefreshButton(
            onPressed: () {
              refreshScreen(context);
              context.read(twoPartJokesNotifierProvider).getTwoPartJokes();
            },
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
          ),
          Positioned(
            top: 32,
            left: 100,
            child: SizedBox(
              height: 36,
              width: 80,
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0),
                ),
                padding: const EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.topRight,
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(0.8),
                          Theme.of(context).accentColor.withOpacity(0.8),
                        ]),
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(
                        minWidth: 88.0,
                        minHeight: 36.0), // min sizes for Material buttons
                    alignment: Alignment.center,
                    child: const Text(
                      'Two Part',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
