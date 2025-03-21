import 'package:flutter/material.dart';

class ImageViewFull extends StatefulWidget {
  String? value;

  ImageViewFull({super.key, this.value});

  static String id = 'Imageurl';

  @override
  State<ImageViewFull> createState() => _ImageViewFullState();
}

class _ImageViewFullState extends State<ImageViewFull> {
  @override
  void initState() {
    // TODO: implement initState
    print(widget.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: width,
                height: height * 0.85,
                child: Hero(
                  tag: 'imagesmall',
                  child: Image.network(
                    widget.value!,
                    fit: BoxFit.cover,
                  ),
                )),
            Expanded(
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.orange)),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

// class DialogueButton extends StatefulWidget {
//   DialogueButton({required this.textofbutton, required this.onPressFunction});

//   String textofbutton;
//   Function onPressFunction;

//   @override
//   State<DialogueButton> createState() => _DialogueButtonState();
// }

// class _DialogueButtonState extends State<DialogueButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: EdgeInsets.all(8.0),
//         child: TextButton(
//             style: kDialoguebuttonStyle,
//             onPressed: widget.onPressFunction(),
//             child: Text(
//               widget.textofbutton,
//               style: TextStyle(color: Colors.white),
//             )),
//       ),
//     );
//   }
// }
