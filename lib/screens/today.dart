import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

// TODO: MAKE RESPONSIVE COLORS OF TEXT AND BUTTONS, AND ICON
//       REFACTOR

class Today extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
            )
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
            color: Colors.orange,
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
            items: ['Everyday', 'Every monday', 'Never'],
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
            color: Colors.orange,
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
            Expanded(flex: 1, child: TodayChoice()),
          ],
        ),
      ),
    );
  }
}

class TodayChoice extends StatelessWidget {
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
                // change to orange[200] if not selected
                color: Colors.orange,
                elevation: 1.0,
                child: Text(
                  "Today's Quote",
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                  ),
                ),
                onPressed: () => print("todays quote")),
          ),
          SizedBox(
            width: SizeConfig.safeBlockHorizontal,
          ),
          Expanded(
            child: RaisedButton(
                // change to orange if selected
                color: Colors.orange[200],
                elevation: 1.0,
                child: Text(
                  "Today's Joke",
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                  ),
                ),
                onPressed: () => print("todays joke")),
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
            QuoteText(
              author: "W. Clement Stone",
              quote:
                  "\"Always aim for the moon, even if you miss, you'll land among the stars.\"",
            ),
            Save(),
          ],
        ),
      ),
    );
  }
}

class Save extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: SizeConfig.safeBlockVertical,
          left: SizeConfig.safeBlockHorizontal),
      child: Row(
        children: [
          Icon(
            // if is clicked change to bookmark
            Icons.favorite_border,
            size: SizeConfig.blockSizeVertical * 3.5,
            color: Colors.orange,
          ),
          SizedBox(
            width: SizeConfig.safeBlockHorizontal,
          ),
          Text(
            "SAVE",
            style: TextStyle(
                color: Colors.black45,
                fontSize: SizeConfig.safeBlockHorizontal * 3,
                letterSpacing: SizeConfig.safeBlockHorizontal * 0.15),
          )
        ],
      ),
    );
  }
}

class QuoteText extends StatelessWidget {
  QuoteText({this.quote, this.author});

  final String quote;
  final String author;

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
            quote,
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 6,
                color: Colors.black87),
            maxLines: 4,
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 2,
          ),
          Row(
            children: [
              CircleAvatar(),
              SizedBox(
                width: SizeConfig.safeBlockVertical,
              ),
              Text(
                author,
                style: TextStyle(color: Colors.black45),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
