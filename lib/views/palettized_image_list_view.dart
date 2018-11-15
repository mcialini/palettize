/*
Responsible for showing:
- list of PalettizeImage instances
- FloatingActionButtons to begin creation process
*/
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../models/palettized_image.dart';


class PalettizedImageListView extends StatefulWidget {
  @override
  _PalettizedImageListViewState createState() => _PalettizedImageListViewState();
}

class _PalettizedImageListViewState extends State<PalettizedImageListView> {
  PalettizedImage _image;

  Future getImageCamera() async {
    var rawImage = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = new PalettizedImage(rawImage);
    });
  }

  Future getImageGallery() async {
    var rawImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = new PalettizedImage(rawImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Palettize'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image.rawImage),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.add_a_photo),
            onPressed: getImageCamera
          ),
          FloatingActionButton(
            child: Icon(Icons.photo_library),
            onPressed: getImageGallery
          )
        ]
      ),
    );
  }
}