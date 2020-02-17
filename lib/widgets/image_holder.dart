import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageHolder extends StatelessWidget {
  final File file;
  final Function(File) onImageTap;

  const ImageHolder({Key key, @required this.file, @required this.onImageTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
          child: file == null
              ? Icon(
                  Icons.photo_camera,
                  color: Colors.grey,
                  size: 80,
                )
              : Image.file(file),
          onTap: () => _requestPicture()),
    );
  }

  Future<void> _requestPicture() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      onImageTap(image);
    }
  }
}
