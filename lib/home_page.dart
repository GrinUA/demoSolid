import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _firstImage;
  File _secondImage;

  Future getImage() async {
    var newImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _firstImage = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Solid'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getImage(),
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  _body() {
    return Center(
        child: Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _firstImage == null
              ? Text('No image selected.')
              : Image.file(_firstImage),
        ),
        Expanded(
          flex: 1,
          child: _secondImage == null
              ? Text(
                  'No image selected.',
                )
              : Image.file(_firstImage),
        )
      ],
    ));
  }
}
