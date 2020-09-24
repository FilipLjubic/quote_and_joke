import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quote_and_joke/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes & Jokes',
      home: Home(),
    );
  }
}
