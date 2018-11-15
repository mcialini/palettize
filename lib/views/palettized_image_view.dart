/*
Responsible for showing:
- the image
- the palette
- two text fields
  - tolerance
  - palette size
- a close icon
- a save icon
*/
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../models/palettized_image.dart';


class PalettizedImageView extends StatelessWidget {
  final File rawImage;

  PalettizedImageView(this.rawImage);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: Icon(Icons.close),
          tooltip: 'Cancel',
          onPressed: () {
            print('CANCELLED');
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            tooltip: 'Save',
            onPressed: () {
              print('SAVED');
              Navigator.pop(context);
            },
          )
        ]
      ),
      body: Center(
        child: this.rawImage == null
            ? Text('No image selected.')
            : Image.file(rawImage),
      ),
    );
  }
}