import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:environment_app/utils/constants.dart';
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
      appBar: AppBar(
        title: Text('EnvHub'),
        backgroundColor: Colors.black54,
        centerTitle: true,
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.refresh)),
          IconButton(onPressed: null, icon: Icon(Icons.chat))
        ],
      ),
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
                onChanged: (value){
                  email = value;
                },
                decoration: kTextInputStyleDecoration.copyWith(
                  hintText: 'Enter email'
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value){
                  password = value;
                },
                decoration: kTextInputStyleDecoration.copyWith(
                    hintText: 'Enter password'
                ),
              ),
              SizedBox(
                height: 24,
              ),
              RoundedButton(color: Colors.black54, text: 'Register', onPressed: (){
                final progress = ProgressHUD.of(context);
                progress!.showWithText('Please Wait...');
                try{
                  final newUser = _auth.signInWithEmailAndPassword(email: email!, password: password!);
                  if(newUser != null){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully Registered')))
                  }
                  progress.dismiss();
                }catch(e){
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
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
