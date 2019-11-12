import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class FacePage extends StatefulWidget {
  @override
  _FacePageState createState() => _FacePageState();
}

class _FacePageState extends State<FacePage> {
  File _imageFile;
  List<Face> _faces;

  void _getImageAndDetectFaces() async{
    final imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery
    );
    final visionImage = FirebaseVisionImage.fromFile(imageFile);
    final faceDetector = FirebaseVision.instance.faceDetector(
        FaceDetectorOptions(
            mode: FaceDetectorMode.accurate
        )
    );
    final faces = await faceDetector.processImage(visionImage);
    if (mounted) {
      setState(() {
        _imageFile = imageFile;
        _faces = faces;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Detection'),
        centerTitle: true,
      ),

      body: ImageAndFaces(),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _getImageAndDetectFaces,
        tooltip: 'Pick an Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

}

class ImageAndFaces extends StatelessWidget {

  ImageAndFaces({this.imageFile, this.faces});

  final File imageFile;
  final List<Face> faces;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Container(
            constraints: BoxConstraints.expand(),
            child: Image.file(
              imageFile,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: ListView(
            children: faces.map((face) => FaceCoordinates(face)).toList(),
          ),
        )
      ],
    );
  }
}

class FaceCoordinates extends StatelessWidget {
  FaceCoordinates(this.face);
  final Face face;

  @override
  Widget build(BuildContext context) {
    final pos = face.boundingBox;
    return ListTile(
      title: Text('(${pos.top}, ${pos.left}, ${pos.bottom}, ${pos.right})'),
    );
  }
}



