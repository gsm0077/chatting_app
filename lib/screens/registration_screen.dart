import 'package:flutter/material.dart';
import '../components/similar.dart';
import '../constants.dart';
import 'login_screen.dart';
import 'chat_screen.dart';
import 'welcome_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = '/register';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? email;
  String? password;
  bool _status = false;
  dynamic error;
  dynamic error1;
  dynamic errorEmail;
  bool eye = true;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: ModalProgressHUD(
        inAsyncCall: _status,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
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
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kButtonstyleDecoration.copyWith(
                    hintText: 'Enter Your Email'),
              ),
              error != null
                  ? Center(
                      child: Text(
                        error == kEmailError
                            ? '->Email already exits<-'
                            : errorEmail == kEmailInvalid
                                ? '->Enter a Valid Email<-'
                                : '',
                        style:
                            TextStyle(fontSize: 15.0, color: Colors.redAccent),
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
                  password = value;
                },
                decoration: kButtonstyleDecoration.copyWith(
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
              error1 == kPasswordError
                  ? Center(
                      child: Column(
                        children: [
                          Text(
                            '->Password not strong enough<-',
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.redAccent),
                          ),
                          SizedBox(
                            height: 20.0,
                          )
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 24.0,
                    ),
              SimilarButton(
                  textofButton: 'Register',
                  colorOfbutton: Colors.lightBlueAccent,
                  onPressed: () async {
                    setState(() {
                      _status = true;
                    });
                    try {
                      //created new user in
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email!, password: password!);
                      if (newUser != null) {
                        setState(() {
                          _status = false;
                        });
                        Navigator.pushNamed(context, ChatScreen.id);
                      } else {
                        print('not connected');
                      }
                    } catch (e) {
                      setState(() {
                        _status = false;
                      });
                      print('line 39==============');
                      print(e);
                      error = e.toString().substring(15, 35);
                      error1 = e.toString().substring(15, 28);
                      errorEmail = e.toString().substring(15, 28);
                      print('line 41=============');
                      print(error);
                      print(error1);
                      print('====================');
                    }
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
                        textofButton: 'Login',
                        colorOfbutton: Colors.redAccent,
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.id);
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
