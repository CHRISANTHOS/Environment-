import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen())));
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Hero(
            tag: 'logo',
            child: Container(
              child: Image.asset('images/Ennvlogo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
