import 'package:flutter/material.dart';
import '../constants.dart';

class SimilarButton extends StatelessWidget {
  const SimilarButton(
      {super.key,
      required this.textofButton,
      required this.colorOfbutton,
      required this.onPressed});

  final String textofButton;
  final Function onPressed;
  final Color colorOfbutton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 5.0,
        color: colorOfbutton,
        borderRadius: BorderRadius.circular(20.0),
        child: MaterialButton(
          onPressed: () {
            onPressed();
          },
          minWidth: 100.0,
          height: 42.0,
          child: Text(textofButton, style: kButtontextStyle),
        ),
      ),
    );
  }
}
