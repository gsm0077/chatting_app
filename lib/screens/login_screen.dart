import 'package:chatty/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/similar.dart';
import '../constants.dart';
import 'chat_screen.dart';
import 'registration_screen.dart';

final _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  static String id = '/login';

  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  bool _status = false;
  dynamic error;
  dynamic errorPass;
  dynamic errorEmail2;
  bool errortype = false;
  bool eye = true;

  void checkUser(BuildContext content) async {
    setState(() {
      _status = true;
    });
    try {
      final dataofUser = await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      setState(() {
        _status = false;
      });
      Navigator.pushNamed(content, ChatScreen.id);
    } catch (e) {
      setState(() {
        _status = false;
        errortype = true;
      });
      error = e.toString().substring(15, 28);
      errorPass = e.toString().substring(15, 29);
      errorEmail2 = e.toString().substring(15, 28);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: _status,
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.7)),
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  // print(value);
                  setState(() {
                    email = value;
                  });
                },
                decoration: errortype == false
                    ? kButtonstyleDecoration.copyWith(
                        hintText: 'Enter Your Email')
                    : kButtonstyleDecorations.copyWith(
                        hintText: 'Enter Your Email'),
              ),
              error != null
                  ? Center(
                      child: Text(
                        error == kUsernotfound
                            ? '->Email does Not exits<-'
                            : errorEmail2 == kEmailInvalid
                                ? '->Enter a Valid Email<-'
                                : '',
                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                      ),
                    )
                  : SizedBox(
                      height: 8.0,
                    ),
              TextField(
                obscureText: eye,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  setState(() {
                    password = value;
                  });
                },
                decoration: errortype == false
                    ? kButtonstyleDecoration.copyWith(
                        hintText: 'Enter Your Passowrd',
                        suffixIcon: eye
                            ? GestureDetector(
                                child: Icon(Icons.visibility_off_sharp),
                                onTap: () {
                                  setState(() {
                                    eye = !eye;
                                  });
                                },
                              )
                            : GestureDetector(
                                child: Icon(Icons.visibility),
                                onTap: () {
                                  setState(() {
                                    eye = !eye;
                                  });
                                },
                              ))
                    : kButtonstyleDecorations.copyWith(
                        hintText: 'Enter Your Passowrd',
                        suffixIcon: eye
                            ? GestureDetector(
                                child: Icon(Icons.visibility_off_sharp),
                                onTap: () {
                                  setState(() {
                                    eye = !eye;
                                  });
                                },
                              )
                            : GestureDetector(
                                child: Icon(Icons.visibility),
                                onTap: () {
                                  setState(() {
                                    eye = !eye;
                                  });
                                },
                              )),
              ),
              errorPass == kPasswordWronge
                  ? const Center(
                      child: Column(
                        children: [
                          Text(
                            '->Incorrect Password<-',
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.black87),
                          ),
                          SizedBox(
                            height: 20.0,
                          )
                        ],
                      ),
                    )
                  : const SizedBox(
                      height: 24.0,
                    ),
              SimilarButton(
                  textofButton: 'Login',
                  colorOfbutton: Colors.lightBlueAccent,
                  onPressed: () {
                    checkUser(context);
                  }),
              Row(
                children: [
                  Expanded(
                    child: SimilarButton(
                        textofButton: 'Home Screen',
                        colorOfbutton: Colors.redAccent,
                        onPressed: () {
                          Navigator.pushNamed(context, WelcomeScreen.id);
                        }),
                  ),
                  Expanded(
                    child: SimilarButton(
                        textofButton: 'Register',
                        colorOfbutton: Colors.redAccent,
                        onPressed: () {
                          Navigator.pushNamed(context, RegistrationScreen.id);
                        }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
