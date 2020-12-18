import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/state/today/jod_notifier.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';
import 'package:quote_and_joke/widgets/themed_circular_progress_indicator.dart';

class JokeText extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final jod = useProvider(jodNotifierProvider.state);

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
              fontSize: SizeConfig.safeBlockHorizontal * 6.5,
              color: Colors.black87),
          maxLines: 10,
        ),
      ),
      loading: () => ThemedCircularProgressIndicator(),
      error: (s, t) => Container(
        padding: EdgeInsets.fromLTRB(
            SizeConfig.safeBlockVertical * 5,
            SizeConfig.safeBlockVertical * 5,
            SizeConfig.safeBlockVertical * 5,
            0),
        child: AutoSizeText(
          "There seems to be a problem with your connection",
          style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 5.7,
              color: Colors.black87),
          maxLines: 10,
        ),
      ),
    );
  }
}
