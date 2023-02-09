import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:environment_app/screens/welcome_screen.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:environment_app/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Environment Chat',
      home: SplashScreen(),
    );
  }
}
