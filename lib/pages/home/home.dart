import 'dart:io';

import 'package:demo/utils/computing.dart';
import 'package:flutter/material.dart';

import 'image_holder.dart';

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
      _showError(context);
    } else {
      _showAnswer(
          context, await ImageComparator.compare(_firstFile, _secondFile));
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
}
