import 'dart:io';

import 'package:image/image.dart';

extension FileParsing on File {
  Image asImage() {
    return decodeImage(this.readAsBytesSync());
  }
}
