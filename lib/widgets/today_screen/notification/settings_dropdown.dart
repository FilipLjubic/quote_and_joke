import 'package:flutter/material.dart';
import 'package:quote_and_joke/utils/constants.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/today_screen/notification/frequency_dropdown.dart';

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
