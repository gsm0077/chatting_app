import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chatty/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'imageview_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';

User? loggedinUser;
final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
Reference firebaseStorageref = FirebaseStorage.instance.ref();

String? message;
String? imageUrl;
String? audioUrl;

class ChatScreen extends StatefulWidget {
  static String id = 'chatscreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messageData = [];

  final messageSettingController = TextEditingController();

  @override
  void initState() {
    currentUser();
    super.initState();
  }

  void currentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
        // print(loggedinUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   _firestore.collection("messages").get().then(
  //     (querySnapshot) {
  //       // print("Successfully completed");
  //       for (var docSnapshot in querySnapshot.docs) {
  //         print('${docSnapshot.id} => ${docSnapshot.data()}');
  //       }
  //     },
  //     onError: (e) => print("Error completing: $e"),
  //   );
  // }

  // void getmessageStreams() async {
  //   _firestore.collection("messages").snapshots().listen((event) {
  //     for (var change in event.docChanges) {
  //       print(change.doc.data());
  //       setState(() {
  //         messageData.add(change.doc.data()!['mes']);
  //       });
  //       // switch (change.type) {
  //       //   case DocumentChangeType.added:
  //       //     print("New City: ${change.doc.data()}");
  //       //     break;
  //       //   case DocumentChangeType.modified:
  //       //     print("Modified City: ${change.doc.data()}");
  //       //     break;
  //       //   case DocumentChangeType.removed:
  //       //     print("Removed City: ${change.doc.data()}");
  //       //     break;
  //       // }
  //     }
  //   });
  // }

  // Expanded DialoguButton(Function onpressed, String textofbutton) {
  //   return Expanded(
  //       child: Padding(
  //     padding: EdgeInsets.all(8.0),
  //     child: TextButton(
  //         style: kDialoguebuttonStyle,
  //         onPressed: onpressed(),
  //         child: Text(
  //           textofbutton,
  //           style: TextStyle(color: Colors.white),
  //         )),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // getmessageStreams();
                //Implement logout functionality+
                _auth.signOut();
                Navigator.pushNamed(context, LoginScreen.id);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const StreamSetter(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageSettingController,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration.copyWith(
                          prefixIcon: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: Container(
                                  color: Colors.transparent,
                                  // width: 200,
                                  height: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextButton(
                                              style: kDialoguebuttonStyle,
                                              onPressed: () {
                                                takeImageandUpload();
                                              },
                                              child: Text(
                                                'camera',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
                                      // DialoguButton(() {
                                      //   takeImageFromgallery();
                                      // }, "gallery"),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextButton(
                                              style: kDialoguebuttonStyle,
                                              onPressed: () {
                                                takeImageFromgallery();
                                              },
                                              child: Text(
                                                'gallery',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextButton(
                                              style: kDialoguebuttonStyle,
                                              onPressed: () {
                                                pickFilesfromPhone();
                                              },
                                              child: Text(
                                                'files',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
                                      // pickFilesfromPhone
                                      // DialogueButton(
                                      //     onPressFunction: () {
                                      //       takeImageFromgallery();
                                      //     },
                                      //     textofbutton: "back"),
                                    ],
                                  ),
                                )),
                          );
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => OnScreenPopup()));
                        },
                        child: Icon(
                          Icons.image,
                          color: Colors.black,
                        ),
                      )),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageSettingController.clear();
                      String messageData = message!;
                      message = "";
                      if (messageData != "") {
                        _firestore.collection('messages').add({
                          'mes': messageData,
                          'sender': _auth.currentUser!.email,
                          'time': FieldValue.serverTimestamp()
                        });
                      }
                      // getMessages();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void pickFilesfromPhone() async {
  print('Entered');

  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    File file = File(result.files.single.path!);
    final dataArray = file.toString().split('.');
    print(dataArray[dataArray.length - 1]);

    String unquieIdreference = DateTime.now().microsecondsSinceEpoch.toString();

    Reference refDirAduios = firebaseStorageref.child('audios');

    Reference refaudiotoBEstored = refDirAduios.child(unquieIdreference);

    try {
      print('trying');
      if (file.existsSync()) {
        await refaudiotoBEstored.putFile(file);

        audioUrl = await refaudiotoBEstored.getDownloadURL();

        _firestore.collection('messages').add({
          'mes': audioUrl,
          'sender': _auth.currentUser!.email,
          'time': FieldValue.serverTimestamp()
        });

        print('line 277 =====================================');
      } else {
        print('file Does not exists');
      }
    } catch (e) {
      print(e);
    }
  } else {
    // User canceled the picker
    print('User Cancled the picker');
  }
}

void takeImageFromgallery() async {
  ImagePicker content = ImagePicker();
  XFile? file = await content.pickImage(source: ImageSource.gallery);
  print(file!.path);

  if (file.path == null) return;

  String unquieIdreference = DateTime.now().microsecondsSinceEpoch.toString();

  Reference refDirImages = firebaseStorageref.child('images');

  Reference refimagetoBEstored = refDirImages.child(unquieIdreference);

  try {
    await refimagetoBEstored.putFile(File(file!.path));

    imageUrl = await refimagetoBEstored.getDownloadURL();

    _firestore.collection('messages').add({
      'mes': imageUrl,
      'sender': _auth.currentUser!.email,
      'time': FieldValue.serverTimestamp()
    });
    print('line 173 =====================================');
  } catch (e) {
    print(e);
  }
}

void takeImageandUpload() async {
  ImagePicker content = ImagePicker();

  XFile? file = await content.pickImage(source: ImageSource.camera);

  print(file!.path);

  if (file!.path == null) return;

  String unquieIdreference = DateTime.now().microsecondsSinceEpoch.toString();

  Reference refDirImages = firebaseStorageref.child('images');

  Reference refimagetoBEstored = refDirImages.child(unquieIdreference);

  try {
    await refimagetoBEstored.putFile(File(file!.path));

    imageUrl = await refimagetoBEstored.getDownloadURL();

    _firestore.collection('messages').add({
      'mes': imageUrl,
      'sender': _auth.currentUser!.email,
      'time': FieldValue.serverTimestamp()
    });

    print('line 212 =====================================');
  } catch (e) {
    print(e);
  }
}

class StreamSetter extends StatelessWidget {
  const StreamSetter({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection("messages").orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs.reversed;
          List<messageBubble> widgetMessages = [];
          for (var message in messages) {
            final messageText = message.data()['mes'];
            final messageSender = message.data()['sender'];
            final messageTime = message.get('time');
            final senderEmail = loggedinUser!.email;
            final urlTxt;
            messageText.toString().split('%')[0] == "${kFirebaseUrl}images"
                ? urlTxt = 'images'
                : messageText.toString().split('%')[0] ==
                        "${kFirebaseUrl}audios"
                    ? urlTxt = 'audios'
                    : urlTxt = "text";

            bool isIMAGE = false;
            bool isAUDIO = false;

            if (urlTxt == 'images') isIMAGE = true;
            if (urlTxt == 'audios') isAUDIO = true;

            final widgetMessage = messageBubble(
                message: messageText,
                sender: messageSender,
                isME: messageSender == senderEmail,
                isImage: isIMAGE,
                isAUDIO: isAUDIO);
            widgetMessages.add(widgetMessage);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: widgetMessages,
            ),
          );
        } else {
          return Expanded(child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}

class messageBubble extends StatefulWidget {
  messageBubble(
      {required this.message,
      required this.sender,
      required this.isME,
      required this.isImage,
      required this.isAUDIO});

  String sender;
  String message;
  bool isImage;
  bool isME;
  bool isAUDIO;

  @override
  State<messageBubble> createState() => _messageBubbleState();
}

class _messageBubbleState extends State<messageBubble> {
  final player = AudioPlayer();
  var height = 0.00;

  bool play = false;

  @override
  void dispose() {
    // TODO: implement dispose
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            widget.isME ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            widget.sender,
            style: TextStyle(fontSize: 12.0, color: Colors.black),
          ),
          widget.isImage
              ? Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  // color: Colors.green2
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageViewFull(
                                    value: widget.message,
                                  )));
                      // Navigator.pushNamed(context, value: ImageViewFull.id);
                    },
                    child: Hero(
                      tag: 'imagesmall',
                      child: Image.network(
                        widget.message,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : widget.isAUDIO
                  ? Container(
                      width: 60,
                      height: 40,
                      // color: Colors.pink,
                      decoration: BoxDecoration(
                          color: widget.isME
                              ? Colors.lightBlueAccent
                              : Colors.redAccent,
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () async {
                                if (play == false) {
                                  await player.play(UrlSource(widget.message));
                                  player.getCurrentPosition().then(
                                    (value) {
                                      setState(() {
                                        print('496===============');
                                        height = value!.inSeconds.toDouble();
                                      });
                                    },
                                  );
                                } else {
                                  await player.pause();
                                }
                                setState(() {
                                  play = !play;
                                });
                              },
                              child: play
                                  ? Icon(Icons.pause)
                                  : Icon(Icons.play_arrow),
                            ),
                          ),
                          // Expanded(
                          //   flex: 3,
                          //   child: Text('Time:${height}'),
                          //   //  Slider(
                          //   //     value: 0.0,
                          //   //     min: 0.0,
                          //   //     max: 200.0,
                          //   //     onChanged: (value) {
                          //   //       setState(() {
                          //   //         height = value.toInt();
                          //   //       });
                          //   //     }),
                          // )
                        ],
                      ),
                    )
                  : Material(
                      elevation: 5.0,
                      color: widget.isME
                          ? Colors.lightBlueAccent
                          : Colors.redAccent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomLeft: Radius.circular(widget.isME ? 15.0 : 0.0),
                          bottomRight:
                              Radius.circular(widget.isME ? 0.0 : 15.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          widget.message,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
