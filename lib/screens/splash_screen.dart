import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome_screen.dart';
import 'environment_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if(firebaseAuth.currentUser == null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      }else{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => EnvironmentScreen()), (route) => false);
      }
    });
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
