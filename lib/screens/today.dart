import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:quote_and_joke/services/joke_service.dart';
import 'package:quote_and_joke/services/quote_service.dart';
import 'package:quote_and_joke/utils/constants.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/themed_circular_progress_indicator.dart';

//TODO: Change all StateProviders to StateNotifierProviders
//TODO: Change final fields to useMemoized(() => Field)

class Today extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -SizeConfig.blockSizeVertical * 13,
            right: -SizeConfig.blockSizeHorizontal * 30,
            child: BackgroundBlob(
              height: SizeConfig.blockSizeVertical * 50,
              width: SizeConfig.blockSizeHorizontal * 70,
            ),
          ),
          Positioned(
            left: -SizeConfig.blockSizeHorizontal * 25,
            bottom: SizeConfig.blockSizeHorizontal * 20,
            child: BackgroundBlob(
              height: SizeConfig.blockSizeVertical * 25,
              width: SizeConfig.blockSizeHorizontal * 70,
            ),
          ),
          Positioned(
            right: -SizeConfig.blockSizeHorizontal * 5,
            bottom: SizeConfig.blockSizeHorizontal * 20,
            child: BackgroundBlob(
              height: SizeConfig.blockSizeVertical * 25,
              width: SizeConfig.blockSizeHorizontal * 35,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Quote & Joke",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: SizeConfig.safeBlockHorizontal * 5),
                  ),
                ),
              ),
              Expanded(
                child: TodayHeadline(),
              ),
              Expanded(
                flex: 8,
                child: TodayCard(),
              ),
              Expanded(
                flex: 3,
                child: NotificationSettings(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BackgroundBlob extends StatelessWidget {
  const BackgroundBlob({
    @required this.height,
    @required this.width,
  });

  final height;
  final width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.8),
            Theme.of(context).accentColor.withOpacity(0.8),
          ],
        ),
      ),
    );
  }
}

class NotificationSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.notifications_active,
            size: SizeConfig.safeBlockHorizontal * 6,
          ),
          Text(
            "YOUR NOTIFICATION SETTINGS",
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 2.5,
                color: Colors.black54,
                letterSpacing: SizeConfig.safeBlockHorizontal * 0.15,
                fontWeight: FontWeight.bold),
          ),
          SettingsDropdowns()
        ],
      ),
    );
  }
}

class SettingsDropdowns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 5,
          vertical: SizeConfig.safeBlockVertical * 2),
      child: Row(
        children: [
          FrequencyDropdown(items: FREQUENCY_DROPDOWN_DAYS),
          FrequencyDropdown(items: FREQUENCY_DROPDOWN_TIMES),
        ],
      ),
    );
  }
}

class FrequencyDropdown extends HookWidget {
  FrequencyDropdown({this.items});
  final items;

  @override
  Widget build(BuildContext context) {
    final current = useState(items[0]);

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.safeBlockHorizontal * 2),
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.black12),
            borderRadius: BorderRadius.circular(3.0)),
        child: DropdownButton(
          value: current.value,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).accentColor,
          ),
          underline: Container(
            height: 2.0,
            color: Colors.grey[50],
          ),
          style: TextStyle(color: Colors.grey),
          isExpanded: true,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) => current.value = newValue,
        ),
      ),
    );
  }
}

class TodayHeadline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 3,
          top: SizeConfig.safeBlockVertical * 3),
      child: Text(
        "Today's",
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 7,
          color: Colors.black87,
          letterSpacing: SizeConfig.safeBlockHorizontal * 0.2,
        ),
      ),
    );
  }
}

class TodayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 5,
          vertical: SizeConfig.safeBlockVertical * 3),
      child: Material(
        elevation: 5.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 5, child: TodayQuote()),
            Expanded(flex: 1, child: TodayButtons()),
          ],
        ),
      ),
    );
  }
}

final _showQodProvider = StateProvider<bool>((ref) => true);

class TodayButtons extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final showQod = useProvider(_showQodProvider).state;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 2,
          vertical: SizeConfig.safeBlockVertical),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: XOfDayButton(showQod: showQod, text: "Today's Quote"),
          ),
          SizedBox(
            width: SizeConfig.safeBlockHorizontal,
          ),
          Expanded(
              child: XOfDayButton(showQod: !showQod, text: "Today's Joke")),
        ],
      ),
    );
  }
}

class XOfDayButton extends StatelessWidget {
  const XOfDayButton({@required this.showQod, @required this.text});

  final bool showQod;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: showQod
            ? Theme.of(context).primaryColor
            : Theme.of(context).accentColor,
        elevation: 1.0,
        child: Text(
          text,
          style: TextStyle(
            color: showQod ? Colors.white : Colors.black54,
            fontSize: SizeConfig.safeBlockHorizontal * 4,
          ),
        ),
        onPressed: () {
          final showQod = context.read(_showQodProvider);
          if (showQod.state == false) showQod.state = true;
        });
  }
}

class TodayQuote extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final showQod = useProvider(_showQodProvider).state;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 2,
          vertical: SizeConfig.safeBlockVertical),
      child: Material(
        elevation: 1.0,
        child: AnimatedCrossFade(
          firstChild: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuoteText(),
              Save(),
            ],
          ),
          secondChild: JokeText(),
          crossFadeState:
              showQod ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 150),
          firstCurve: Curves.ease,
          secondCurve: Curves.ease,
        ),
      ),
    );
  }
}

final _qodIsLikedProvider = StateProvider<bool>((ref) => false);

class Save extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final qodIsLiked = useProvider(_qodIsLikedProvider).state;

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
            likeBuilder: (bool isLiked) {
              return qodIsLiked
                  ? Icon(Icons.favorite, color: Theme.of(context).primaryColor)
                  : Icon(Icons.favorite_border,
                      color: Theme.of(context).accentColor);
            },
            onTap: (_) => Future.delayed(const Duration(milliseconds: 0), () {
              final qodIsLiked = context.read(_qodIsLikedProvider);

              qodIsLiked.state = !qodIsLiked.state;

              //TODO: dodati ili obrisati iz databaze quote
              return qodIsLiked.state;
            }),
            isLiked: qodIsLiked,
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

class QuoteText extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final qod = useProvider(qodProvider);
    return Container(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.safeBlockVertical * 5,
          SizeConfig.safeBlockVertical * 5,
          SizeConfig.safeBlockVertical * 5,
          0),
      child: qod.when(
        data: (qod) => Column(
          children: [
            AutoSizeText(
              qod.quote,
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 5.7,
                  color: Colors.black87),
              maxLines: 7,
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            Text(
              qod.author,
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
        loading: () => ThemedCircularProgressIndicator(),
        error: (s, t) => Center(
          child: Text(
            "There seems to be a problem with your connection",
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 5.7,
                color: Colors.black87),
          ),
        ),
      ),
    );
  }
}

class JokeText extends HookWidget {
  @override
  Widget build(BuildContext context) {
    //TODO: Change to jodProvider
    final jod = useProvider(dadJokeProvider);
    return jod.when(
      data: (jod) => Container(
        padding: EdgeInsets.fromLTRB(
            SizeConfig.safeBlockVertical * 5,
            SizeConfig.safeBlockVertical * 5,
            SizeConfig.safeBlockVertical * 5,
            0),
        child: AutoSizeText(
          jod.text,
          style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 5.7,
              color: Colors.black87),
          maxLines: 10,
        ),
      ),
      loading: () => ThemedCircularProgressIndicator(),
      error: (s, t) => Center(
        child: Text(
          "There seems to be a problem with your connection",
          style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 5.7,
              color: Colors.black87),
        ),
      ),
    );
  }
}
