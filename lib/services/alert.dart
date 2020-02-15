import 'package:flutter/material.dart';

class AlertService {
  void showErrorMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text('$message'),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
