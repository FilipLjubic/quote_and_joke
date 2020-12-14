import 'package:flutter/material.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/today_screen/const/background_blob.dart';
import 'package:quote_and_joke/widgets/today_screen/const/today_headline.dart';
import 'package:quote_and_joke/widgets/today_screen/const/today_title.dart';
import 'package:quote_and_joke/widgets/today_screen/notification/notification_settings.dart';
import 'package:quote_and_joke/widgets/today_screen/card/today_card.dart';

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
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          Positioned(
            left: -SizeConfig.blockSizeHorizontal * 25,
            bottom: SizeConfig.blockSizeHorizontal * 20,
            child: BackgroundBlob(
              height: SizeConfig.blockSizeVertical * 25,
              width: SizeConfig.blockSizeHorizontal * 70,
              begin: Alignment.bottomLeft,
              end: Alignment.topCenter,
            ),
          ),
          Positioned(
            right: -SizeConfig.blockSizeHorizontal * 5,
            bottom: SizeConfig.blockSizeHorizontal * 20,
            child: BackgroundBlob(
              height: SizeConfig.blockSizeVertical * 25,
              width: SizeConfig.blockSizeHorizontal * 35,
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Expanded(
                child: const TodayTitle(),
              ),
              Expanded(
                child: const TodayHeadline(),
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
