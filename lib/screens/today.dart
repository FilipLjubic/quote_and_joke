import 'package:flutter/material.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

class Today extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
              child: Text(
                "Today",
                style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 8,
                    color: Colors.black87),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: TodayCard(),
          ),
          Expanded(
            flex: 3,
            child: Text("Notification"),
          )
        ],
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
        elevation: 8.0,
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
                child: Text(
                  "Today's quote",
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
                child: Text(
                  "Today's quote",
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
      color: Colors.orange.withOpacity(0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuoteText(),
          Save(),
        ],
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
            "save",
            style: TextStyle(
                color: Colors.black38,
                fontSize: SizeConfig.safeBlockHorizontal * 3),
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
          Text(
            "\"Always aim for the moon, even if you miss, you'll land among the stars\"",
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 6,
                color: Colors.black87),
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
                "W. Clement Stone",
                style: TextStyle(color: Colors.black45),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
