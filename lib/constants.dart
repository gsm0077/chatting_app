import 'package:flutter/material.dart';

String kFirebaseUrl =
    'https://firebasestorage.googleapis.com/v0/b/chatify-548e8.appspot.com/o/';

String kEmailError = 'email-already-in-use';
String kEmailInvalid = 'invalid-email';
String kPasswordError = 'weak-password';
String kPasswordWronge = 'wrong-password';
String kUsernotfound = 'user-not-found';

const kSendButtonTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kDialoguebuttonStyle =
    ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red));

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.black87, width: 2.0),
  ),
);

//text style of Buttons

const kButtontextStyle =
    TextStyle(fontFamily: 'BricolageGrotesque', fontWeight: FontWeight.w900);

const kFieldtextStyle = TextStyle(fontFamily: 'BricolageGrotesque');

// Color colorofGrey = Colors.grey[800];

const colorizeColors = [
  Color.fromARGB(255, 0, 0, 0),
  Colors.red,
  Colors.blueAccent,
  Colors.redAccent,
  Colors.blue,
];

const kColorizeTextStyle = TextStyle(
    fontSize: 45.0,
    // fontWeight: FontWeight.w900,
    fontWeight: FontWeight.bold,
    fontFamily: "BricolageGrotesque");

//Button Text Filed for login and register

const kButtonstyleDecoration = InputDecoration(
  hintText: 'Enter data',
  hintStyle: kFieldtextStyle,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kButtonstyleDecorations = InputDecoration(
  hintText: 'Enter data',
  hintStyle: kFieldtextStyle,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 255, 0, 0), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 255, 0, 0), width: 2.00),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
