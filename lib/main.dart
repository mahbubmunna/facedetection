import 'package:facedetection/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(FaceDetector());

class FaceDetector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Face Detector',
      theme: ThemeData(
        primarySwatch: Colors.yellow
      ),
      home: FacePage(),
    );
  }
}


