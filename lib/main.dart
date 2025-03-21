import 'package:flutter/material.dart';
import 'package:chatty/screens/welcome_screen.dart';
import 'package:chatty/screens/login_screen.dart';
import 'package:chatty/screens/registration_screen.dart';
import 'package:chatty/screens/chat_screen.dart';
import 'screens/imageview_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark(),
      // home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        ImageViewFull.id: (context) => ImageViewFull(),
      },
    );
  }
}
