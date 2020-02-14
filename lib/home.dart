import 'dart:io';

import 'package:demo/computing.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _firstImage;
  File _secondImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Solid Software'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _ImageHolder(
          file: _firstImage,
          onImagePick: (file) {
            setState(() {
              _firstImage = file;
            });
          },
        ),
        _ImageHolder(
            file: _secondImage,
            onImagePick: (file) {
              setState(() {
                _secondImage = file;
              });
            }),
        _compareButton()
      ],
    ));
  }

  Widget _compareButton() {
    return Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: RaisedButton(
          child: Text('Compare'),
          onPressed: () async {
            print(await ImageComparator.compare(_firstImage, _secondImage));
          },
        ));
  }
}

class _ImageHolder extends StatelessWidget {
  final File file;
  final Function(File) onImagePick;

  const _ImageHolder({Key key, @required this.file, @required this.onImagePick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 3,
        fit: FlexFit.loose,
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              child: file == null
                  ? Icon(
                Icons.photo_camera,
                color: Colors.grey,
                size: 80,
              )
                  : Image.file(file),
              onTap: () async {
                var image =
                await ImagePicker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  onImagePick(image);
                }
              },
            )));
  }
}
