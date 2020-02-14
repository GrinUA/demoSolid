import 'dart:io';

import 'package:demo/computing.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        _ImageHolder(
          file: _firstFile,
          onImageTap: (file) {
            setState(() {
              _firstFile = file;
            });
          },
        ),
        _ImageHolder(
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
      _showError(context);
    } else {
      _showAnswer(
          context, await ImageComparator.compare(_firstFile, _secondFile));
    }
  }
}

class _ImageHolder extends StatelessWidget {
  final File file;
  final Function(File) onImageTap;

  const _ImageHolder({Key key, @required this.file, @required this.onImageTap})
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
              onTap: () => _getPicture()),
        ));
  }

  _getPicture() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      onImageTap(image);
    }
  }
}

void _showAnswer(BuildContext context, String result) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Done'),
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

void _showError(BuildContext context) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text('Please choose 2 images'),
    ),
  );
}
