import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class Camera extends StatefulWidget {
  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<Camera> {
  PickedFile _pickedImage;
  bool _isImageLoaded = false;
  bool _isTextLoaded = false;
  String _text = "";

  Future pickImage() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = tempStore;
      _isImageLoaded = true;
    });
  }

  Future readText() async {
    FirebaseVisionImage ourImage =
        FirebaseVisionImage.fromFile(File(_pickedImage.path));
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    _text = readText.text;

    setState(() {
      _isTextLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _isImageLoaded
            ? Center(
                child: Container(
                  height: 500.0,
                  width: 400.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(File(_pickedImage.path)),
                        fit: BoxFit.scaleDown),
                  ),
                ),
              )
            : Container(),
        _isTextLoaded ? Center(child: Text(_text)) : Container(),
        SizedBox(
          height: 10.0,
        ),
        RaisedButton(
          child: Text('Choose an image'),
          onPressed: pickImage,
        ),
        SizedBox(
          height: 10.0,
        ),
        RaisedButton(
          child: Text('Read Text'),
          onPressed: readText,
        ),
      ],
    );
  }
}
