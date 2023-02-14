import 'package:environment_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:environment_app/utils/constants.dart';
import 'welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'buttomnav.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProgressHUD(child: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200,
                    child: Image.asset('images/Ennvlogo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextInputStyleDecoration.copyWith(hintText: 'Enter email'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextInputStyleDecoration.copyWith(
                    hintText: 'Enter password'),
              ),
              SizedBox(
                height: 24,
              ),
              RoundedButton(
                  color: Colors.black54,
                  text: 'Log in',
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final progress = ProgressHUD.of(context);
                    progress!.showWithText('Please wait...');
                    final existingUser = _auth.signInWithEmailAndPassword(
                        email: email!, password: password!);
                    try {
                      if (existingUser != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Logged In')));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ButtomNav()));
                      }
                      progress.dismiss();
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Fill in details',
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      );
                      progress.dismiss();
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ?',
                    style: TextStyle(fontSize: 10),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                      );
                    },
                    child: Text('create'),
                  )
                ],
              )
            ],
          ),
        );
      })),
    );
  }
}
