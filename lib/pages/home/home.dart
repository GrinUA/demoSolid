import 'dart:io';

import 'package:demo/services/alert.dart';
import 'package:demo/services/image.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

import 'image_holder.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _alertService = AlertService();
  final _imageService = ImageService();
  File _firstFile;
  File _secondFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Demo Solid Software'),
        ),
        body: _body());
  }

  _body() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ImageHolder(
          file: _firstFile,
          onImageTap: (file) {
            setState(() {
              _firstFile = file;
            });
          },
        ),
        ImageHolder(
            file: _secondFile,
            onImageTap: (file) {
              setState(() {
                _secondFile = file;
              });
            }),
        _compareButton()
      ],
    ));
  }

  Widget _compareButton() {
    return Builder(builder: (context) {
      return Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: RaisedButton(
            child: Text('Compare'),
            onPressed: () => _compareImages(context),
          ));
    });
  }

  _compareImages(BuildContext context) async {
    if (_firstFile == null || _secondFile == null) {
      _alertService.showErrorMessage(context, 'Please choose two image');
    } else {
      img.Image firstImage = img.decodeImage(_firstFile.readAsBytesSync());
      img.Image secondImage = img.decodeImage(_secondFile.readAsBytesSync());

      if (firstImage.width != secondImage.width ||
          firstImage.height != secondImage.height) {
        _alertService.showErrorMessage(
            context, 'Images must match in height and width');
      } else {
        _showAnswer(
            context, await _imageService.compare(firstImage, secondImage));
      }
    }
  }
}

void _showAnswer(BuildContext context, String result) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Result'),
        content: Text('$result'),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}
