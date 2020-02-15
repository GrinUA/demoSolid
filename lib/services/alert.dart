import 'package:flutter/material.dart';

class AlertService {
  void showErrorSnackBar(GlobalKey<ScaffoldState> contextKey, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    );
    contextKey.currentState.showSnackBar(snackBar);
  }

  void showAlertDialog(BuildContext context,
      {@required String message, String title}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? ''),
          content: Text('$message'),
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
