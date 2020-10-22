import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quote_and_joke/locator.dart' as locator;
import 'package:quote_and_joke/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  locator.setupLocator();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF6FD9E2),
        accentColor: Color(0xFFDBDFB8),
        fontFamily: 'Montserrat',
      ),
      title: 'Quotes & Jokes',
      home: Home(),
    );
  }
}
