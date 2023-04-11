import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:environment_app/utils/constants.dart';
import 'login_page.dart';
import 'welcome_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

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
                style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value){
                  email = value;
                },
                decoration: kTextInputStyleDecoration.copyWith(
                  hintText: 'Enter email'
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value){
                  password = value;
                },
                decoration: kTextInputStyleDecoration.copyWith(
                    hintText: 'Enter password'
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              RoundedButton(color: Colors.black54, text: 'Register', onPressed: (){
                final progress = ProgressHUD.of(context);
                progress!.showWithText('Please Wait...');
                try{
                  final newUser = _auth.createUserWithEmailAndPassword(email: email!, password: password!);
                  if(newUser != null){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully Registered')));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                  progress.dismiss();
                }catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fill in details', style: TextStyle(fontSize: 15.0),),
                    ),
                  );
                  progress.dismiss();
                }
              })
            ],
          ),
        );
      })),
    );
  }
}
