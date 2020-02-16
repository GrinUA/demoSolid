import 'dart:io';

import 'package:demo/extensions/file_apis.dart';
import 'package:demo/extensions/image_apis.dart';
import 'package:demo/services/alert.dart';
import 'package:demo/widgets/image_holder.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final AlertService alertService = AlertService();
  File firstFile;
  File secondFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text('Demo Solid Software'),
        ),
        body: _body());
  }

  Widget _body() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
            flex: 3,
            fit: FlexFit.loose,
            child: ImageHolder(
              file: firstFile,
              onImageTap: (file) {
                setState(() {
                  firstFile = file;
                });
              },
            )),
        Flexible(
            flex: 3,
            fit: FlexFit.loose,
            child: ImageHolder(
                file: secondFile,
                onImageTap: (file) {
                  setState(() {
                    secondFile = file;
                  });
                })),
        _compareButton()
      ],
    ));
  }

  Widget _compareButton() {
    return Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: RaisedButton(
          child: Text('Compare'),
          onPressed: () => _compareImages(context),
        ));
  }

  Future<void> _compareImages(BuildContext context) async {
    if (firstFile == null || secondFile == null) {
      alertService.showErrorSnackBar(_key, 'Please choose two image');
    } else {
      final String result =
          await firstFile.asImage().compare(secondFile.asImage());
      alertService.showAlertDialog(context, message: result, title: 'Result');
    }
  }
}
