import 'package:demo/extensions/image_apis.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class AlertService {
  void showErrorSnackBar(GlobalKey<ScaffoldState> contextKey, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    );
    contextKey.currentState.showSnackBar(snackBar);
  }

  void showResultDialog(BuildContext context,
      {@required img.Image image, String title}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? ''),
          content: image.asWidget(),
          actions: [
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
