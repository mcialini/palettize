/*
Responsible for showing:
- list of PalettizeImage instances
- FloatingActionButtons to begin creation process
*/
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../models/palettized_image.dart';
import 'palettized_image_view.dart';


class PalettizedImageListView extends StatelessWidget {
  Future<File> getImageCamera() async {
    return await ImagePicker.pickImage(source: ImageSource.camera);
  }

  Future<File> getImageGallery() async {
    return await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Palettize'),
      ),
      // body: Center(
      //   child: _image == null
      //       ? Text('No image selected.')
      //       : Image.file(_image.rawImage),
      // ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'addPhoto',
            child: Icon(Icons.add_a_photo),
            onPressed: () async {
              File rawImage = await getImageCamera();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PalettizedImageView(rawImage)
                )
              );
            }
          ),
          FloatingActionButton(
            heroTag: 'choosePhoto',
            child: Icon(Icons.photo_library),
            onPressed: () async {
              File rawImage = await getImageGallery();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PalettizedImageView(rawImage)
                )
              );
            }
          )
        ]
      ),
    );
  }
}