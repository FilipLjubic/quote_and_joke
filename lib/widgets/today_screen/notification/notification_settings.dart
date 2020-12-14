import 'package:flutter/material.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/today_screen/notification/settings_dropdown.dart';

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
