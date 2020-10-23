import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:quote_and_joke/locator.dart';
import 'package:quote_and_joke/services/joke_service.dart';
import 'package:quote_and_joke/services/quote_service.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class Today extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -SizeConfig.blockSizeVertical * 13,
              right: -SizeConfig.blockSizeHorizontal * 30,
              child: Container(
                height: SizeConfig.blockSizeVertical * 50,
                width: SizeConfig.blockSizeHorizontal * 70,
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
              ),
            ),
            Positioned(
              left: -SizeConfig.blockSizeHorizontal * 25,
              bottom: SizeConfig.blockSizeHorizontal * 20,
              child: Container(
                height: SizeConfig.blockSizeVertical * 25,
                width: SizeConfig.blockSizeHorizontal * 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.8),
                      Theme.of(context).accentColor.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: -SizeConfig.blockSizeHorizontal * 5,
              bottom: SizeConfig.blockSizeHorizontal * 20,
              child: Container(
                height: SizeConfig.blockSizeVertical * 25,
                width: SizeConfig.blockSizeHorizontal * 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topRight,
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.8),
                      Theme.of(context).accentColor.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  flex: 1,
                  child: TodayHeadline(),
                ),
                Expanded(
                  flex: 7,
                  child: TodayCard(),
                ),
                Expanded(
                  flex: 2,
                  child: NotificationSettings(),
                ),
              ],
            ),
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
          FrequencyDropdown(
            items: ['Every day', 'Every monday', 'Never'],
          ),
          FrequencyDropdown(items: [
            '8:00 AM',
            '8:30 AM',
            '9:00 AM',
            '9:30 AM',
            '10:00 AM',
            '8:00 PM',
            '8:30 PM',
            '9:00 PM',
            '9:30 PM',
            '10:00 PM'
          ]),
        ],
      ),
    );
  }
}

class FrequencyDropdown extends StatefulWidget {
  final List<String> items;
  FrequencyDropdown({this.items});

  @override
  _FrequencyDropdownState createState() => _FrequencyDropdownState();
}

class _FrequencyDropdownState extends State<FrequencyDropdown> {
  String _value;

  @override
  void initState() {
    super.initState();
    _value = widget.items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.safeBlockHorizontal * 2),
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.black12),
            borderRadius: BorderRadius.circular(3.0)),
        child: DropdownButton(
          value: _value,
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
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String newValue) {
            setState(() {
              _value = newValue;
            });
          },
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

class TodayButtons extends StatefulWidget {
  @override
  _TodayButtonsState createState() => _TodayButtonsState();
}

class _TodayButtonsState extends State<TodayButtons> {
  bool _isFirstSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 2,
          vertical: SizeConfig.safeBlockVertical),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: RaisedButton(
                color: _isFirstSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).accentColor,
                elevation: 1.0,
                child: Text(
                  "Today's Quote",
                  style: TextStyle(
                    color: _isFirstSelected ? Colors.white : Colors.black54,
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isFirstSelected = !_isFirstSelected;
                  });
                }),
          ),
          SizedBox(
            width: SizeConfig.safeBlockHorizontal,
          ),
          Expanded(
            child: RaisedButton(
                color: !_isFirstSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).accentColor,
                elevation: 1.0,
                child: Text(
                  "Today's Joke",
                  style: TextStyle(
                    color: !_isFirstSelected ? Colors.white : Colors.black54,
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isFirstSelected = !_isFirstSelected;
                  });
                }),
          ),
        ],
      ),
    );
  }
}

class TodayQuote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 2,
          vertical: SizeConfig.safeBlockVertical),
      child: Material(
        elevation: 1.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            QuoteText(),
            Save(),
            JokeText(),
          ],
        ),
      ),
    );
  }
}

class Save extends StatefulWidget {
  @override
  _SaveState createState() => _SaveState();
}

class _SaveState extends State<Save> {
  @override
  Widget build(BuildContext context) {
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
              return isLiked
                  ? Icon(Icons.favorite, color: Theme.of(context).primaryColor)
                  : Icon(Icons.favorite_border,
                      color: Theme.of(context).accentColor);
            },
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

class QuoteText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.safeBlockVertical * 5,
          SizeConfig.safeBlockVertical * 5,
          SizeConfig.safeBlockVertical * 5,
          0),
      child: Column(
        children: [
          AutoSizeText(
            getIt<QuoteService>().qod.quote,
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 5.7,
                color: Colors.black87),
            maxLines: 7,
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 2,
          ),
          Text(
            getIt<QuoteService>().qod.author,
            style: TextStyle(color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

class JokeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.safeBlockVertical * 5,
          SizeConfig.safeBlockVertical * 5,
          SizeConfig.safeBlockVertical * 5,
          0),
      child: AutoSizeText(
        getIt<JokeService>().jod,
        style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 5.7,
            color: Colors.black87),
        maxLines: 10,
      ),
    );
  }
}
