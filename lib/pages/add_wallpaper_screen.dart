import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddWallpaperScreen extends StatefulWidget {
  @override
  _AddWallpaperScreenState createState() => _AddWallpaperScreenState();
}

class _AddWallpaperScreenState extends State<AddWallpaperScreen> {
  File _image;

  final picker = ImagePicker();
  final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();

  @override
  void dispose() {
    labeler.close() ;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              InkWell(
                onTap: _loadImageFromGallery,
                  child: _image != null
                      ? Image.file(_image)
                      : Image(
                          image: AssetImage('assets/placeholder.png'),
                        )
              ),
              Text('Click on image to upload wallpaper'),
            ],
          ),
        ),
      ),
    );
  }

  void _loadImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(File(pickedFile.path));
    List<ImageLabel> labels = await labeler.processImage(visionImage);
    for( var label in labels){
      print('${label.text}  [${label.confidence}]');
    }
    
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  } // end _loadImageFromGallery()
}
