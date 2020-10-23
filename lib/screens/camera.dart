import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:quote_and_joke/utils/screen_size_config.dart';

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
    if (tempStore != null && mounted)
      setState(() {
        _pickedImage = tempStore;
        _isImageLoaded = true;
      });
  }

  Future makeImage() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.camera);
    if (tempStore != null && mounted)
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Add a quote from an image",
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 5,
                  color: Colors.black54,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Transform.rotate(
                  angle: -math.pi * 9 / 4,
                  child: IconButton(
                    icon: Icon(
                      Icons.attach_file,
                      size: SizeConfig.safeBlockHorizontal * 8,
                    ),
                    onPressed: pickImage,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    size: SizeConfig.safeBlockHorizontal * 8,
                  ),
                  onPressed: makeImage,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
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
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              child: Text('Read Text'),
              onPressed: readText,
            ),
            _isTextLoaded ? Center(child: Text(_text)) : Container(),
          ],
        ),
      ),
    );
  }
}
