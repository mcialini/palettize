import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'palettized_image.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Text('Image Picker Example'),
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

/*
PalettizedImage
  Image image
  Palette palette 

Palette
  Color[] colors

Color
  r
  g
  b
*/