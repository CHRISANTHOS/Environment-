import 'package:flutter/material.dart';
import 'package:environment_app/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Environment Chat',
      home: WelcomeScreen(),
    );
  }
}
