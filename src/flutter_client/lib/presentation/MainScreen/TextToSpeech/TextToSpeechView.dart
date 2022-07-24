import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:text_to_speech/text_to_speech.dart';

import '../../../session/chatSession/authenticated_session_cubit.dart';

class TextToSpeechView extends StatefulWidget {
  const TextToSpeechView({Key? key}) : super(key: key);

  @override
  State<TextToSpeechView> createState() => _TextToSpeechViewState();
}

class _TextToSpeechViewState extends State<TextToSpeechView> {
  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomNavigation(),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (textScanning) const CircularProgressIndicator(),
              if (!textScanning && imageFile == null)
                Container(
                  width: 300,
                  height: 300,
                  color: Colors.grey[300]!,
                ),
              if (imageFile != null)
                Image.file(File(imageFile!.path)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.orange.shade400,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 50,
                                ),
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orange.shade400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Container(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.orange.shade400,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.camera);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orange.shade400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  scannedText,
                  style: TextStyle(fontSize: 40),
                ),
              )
            ],
          )),
        ));
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognizedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognizedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognisedText =
        await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    TextToSpeech tts = TextToSpeech();
    String text = scannedText;
    tts.speak(text);
    textScanning = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _bottomNavigation() {
    return Container(
        height: 95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red.shade200,
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                    color: Colors.black,
                    iconSize: 75,
                    onPressed: () {
                      context
                          .read<AuthenticatedSessionCubit>()
                          .lastState();
                    },
                    icon: Icon(Icons.arrow_back_rounded)),
              ),
            ),
          ],
        ));
  }
}
