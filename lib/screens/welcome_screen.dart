import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatty/screens/login_screen.dart';
import 'package:chatty/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../components/similar.dart';
import '../constants.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = '/Welcome-screen';

  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controllerLogo;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState

    _controllerLogo =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _controllerLogo.forward();

    // by using below line we had initialized the connection to the firebase
    Firebase.initializeApp();

    _controllerLogo.addListener(() {
      setState(() {});
      // print(animation.value);
    });

    animation =
        CurvedAnimation(parent: _controllerLogo, curve: Curves.decelerate);

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 6));

    _topAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.bottomRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 2),
    ]).animate(_controller);

    _bottomAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 2),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 2),
    ]).animate(_controller);

    _controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              height: screenheight,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue, Colors.red],
                      begin: _topAlignmentAnimation.value,
                      end: _bottomAlignmentAnimation.value)),
              padding: EdgeInsets.symmetric(
                  horizontal: 24.0, vertical: screenheight * 0.25),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                color: Colors.white.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Hero(
                            tag: 'logo',
                            child: SizedBox(
                              height: animation.value * 60,
                              child: Image.asset('images/logo.png'),
                            ),
                          ),
                          Flexible(
                            child: AnimatedTextKit(
                              animatedTexts: [
                                ColorizeAnimatedText(
                                  'Flash Chat',
                                  textStyle: kColorizeTextStyle,
                                  colors: colorizeColors,
                                )
                              ],
                              isRepeatingAnimation: true,
                            ),
                          ),
                          // Text(
                          //   'Flash Chat',
                          //   style: kColorizeTextStyle,
                          //   // (
                          //   //     fontSize: 45.0,
                          //   //     fontWeight: FontWeight.w900,
                          //   //     color: Colors.grey[800]),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                      SimilarButton(
                          textofButton: 'Log In',
                          colorOfbutton: Colors.lightBlueAccent,
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          }),
                      SimilarButton(
                          textofButton: 'Register',
                          colorOfbutton: Colors.redAccent,
                          onPressed: () {
                            Navigator.pushNamed(context, RegistrationScreen.id);
                          }),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
