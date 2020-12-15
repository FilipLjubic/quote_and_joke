import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quote_and_joke/repositories/fake/fake_joke_repository.dart';
import 'package:quote_and_joke/repositories/fake/fake_quote_repository.dart';
import 'package:quote_and_joke/repositories/repository_providers.dart';
import 'package:quote_and_joke/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  return runApp(
    ProviderScope(
      //TODO: ADD JOKE REPOSITORY
      overrides: [
        quoteRepositoryProvider.overrideWithValue(FakeQuoteRepository()),
        jokeRepositoryProvider.overrideWithValue(FakeJokeRepository()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF6FD9E2),
        accentColor: const Color(0xFFDBDFB8),
        disabledColor: const Color(0xFFF2DDB2),
        iconTheme: IconThemeData(
          color: const Color(0xFF6FD9E2),
        ),
        fontFamily: 'Montserrat',
      ),
      title: 'Quotes & Jokes',
      home: Home(),
    );
  }
}
