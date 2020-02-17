import 'dart:io';

import 'package:demo/extensions/file_apis.dart';
import 'package:demo/extensions/image_apis.dart';
import 'package:demo/services/alert.dart';
import 'package:demo/widgets/image_holder.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class HomePage extends StatefulWidget {
  final AlertService alertService;

  const HomePage({Key key, this.alertService = const AlertService()})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(alertService: alertService);
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final AlertService alertService;
  File firstFile;
  File secondFile;

  _HomePageState({@required this.alertService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .backgroundColor,
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
          color: Theme
              .of(context)
              .buttonColor,
          child: Text(
            'Compare',
          ),
          onPressed: () => _compareImages(),
        ));
  }

  Future<void> _compareImages() async {
    if (firstFile == null || secondFile == null) {
      alertService.showErrorSnackBar(_key, 'Please choose two image');
    } else {
      final img.Image firstImage = firstFile.asImage();
      final img.Image secondImage = secondFile.asImage();
      if (!firstImage.isSameSize(secondImage)) {
        alertService.showErrorSnackBar(
            _key, 'Please provide images with the same width and height');
      } else {
        final img.Image result = firstImage.difference(secondImage);
        alertService.showResultDialog(context, image: result, title: 'Result');
      }
    }
  }
}
