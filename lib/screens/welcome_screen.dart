import 'package:environment_app/screens/login_page.dart';
import 'package:environment_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;
  Animation? curve;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = ColorTween(begin: Colors.black54, end: Colors.white)
        .animate(controller!);
    curve = CurvedAnimation(parent: controller!, curve: Curves.easeIn);
    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation!.value,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/Ennvlogo.png'),
                    height: curve!.value * 50,
                  ),
                ),
                AnimatedTextKit(animatedTexts: [
                  TypewriterAnimatedText('EnvHub',
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.w800))
                ])
              ],
            ),
            SizedBox(
              height: 48,
            ),
            RoundedButton(
              color: Colors.black54,
              text: 'Log in',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
            RoundedButton(
              color: Colors.black54,
              text: 'Register',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrationScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  Color color;
  String text;
  VoidCallback onPressed;
  RoundedButton(
      {super.key,
      required this.color,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
