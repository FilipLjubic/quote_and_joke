import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/screens/home.dart';
import 'package:quote_and_joke/services/joke_service.dart';
import 'package:quote_and_joke/services/quote_service.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

//TODO: Change dadJokeProvider to jodProvider
//TODO: stavit state provider koji ce trigerat ova 3 providera
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quotes = useProvider(quoteProvider);
    final qod = useProvider(qodProvider);
    final jod = useProvider(dadJokeProvider);
    SizeConfig().init(context);

    if (quotes.data?.value != null &&
        qod.data?.value != null &&
        jod.data?.value != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
    }

    return Container(
      child: Center(
        child: quotes.when(
          data: (_) => CircularProgressIndicator(),
          loading: () => CircularProgressIndicator(),
          error: (s, t) => Text(
            "Check your internet!",
            style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 15),
          ),
        ),
      ),
    );
  }
}
