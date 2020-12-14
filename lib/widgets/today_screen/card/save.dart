import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class LikeButtonState {
  LikeButtonState({this.state});

  bool state;

  Future<bool> changeState() async {
    Future.delayed(const Duration(seconds: 0));
    state = !state;
    return state;
  }
}

final _likeButtonStateProvider =
    Provider((ref) => LikeButtonState(state: false));

class Save extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isLiked = useProvider(_likeButtonStateProvider);

    return Container(
      margin: EdgeInsets.only(
          bottom: SizeConfig.safeBlockVertical * 2,
          left: SizeConfig.safeBlockHorizontal * 1.5),
      child: Row(
        children: [
          LikeButton(
            size: SizeConfig.blockSizeVertical * 3.5,
            bubblesColor: BubblesColor(
              dotPrimaryColor: Theme.of(context).accentColor,
              dotSecondaryColor: Theme.of(context).primaryColor,
              dotThirdColor: Theme.of(context).disabledColor,
            ),
            circleColor: CircleColor(
              start: Theme.of(context).accentColor,
              end: Theme.of(context).primaryColor,
            ),
            likeBuilder: (bool liked) {
              return isLiked.state
                  ? Icon(Icons.favorite, color: Theme.of(context).primaryColor)
                  : Icon(Icons.favorite_border,
                      color: Theme.of(context).accentColor);
            },
            onTap: (_) async => isLiked.changeState(),
            isLiked: isLiked.state,
          ),
          Text(
            "SAVE",
            style: TextStyle(
                color: Colors.black45,
                fontSize: SizeConfig.safeBlockHorizontal * 3.2,
                letterSpacing: SizeConfig.safeBlockHorizontal * 0.15),
          )
        ],
      ),
    );
  }
}
