import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

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
