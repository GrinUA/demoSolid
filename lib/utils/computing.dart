import 'dart:io';

import 'package:image/image.dart';

class ImageComparator {
  static Future<String> compare(File firstFile, File secondFile) async {
    Image first = decodeImage(firstFile.readAsBytesSync());
    Image second = decodeImage(secondFile.readAsBytesSync());

    if (first.width != second.width || first.height != second.height) {
      return 'Images must be the same height and width';
    } else {
      num difference = 0;
      for (int y = 0; y < first.height; y++) {
        for (int x = 0; x < first.width; x++) {
          int pixelFirst = first.getPixel(x, y);
          int pixelSecond = second.getPixel(x, y);
          difference += _getDifferenceByPixel(pixelFirst, pixelSecond);
        }
      }

      double percentage = _getDifferencePercentage(
          width: first.width, height: first.height, difference: difference);
      return 'Difference is: ${percentage.floor()}%';
    }
  }

  static int _getDifferenceByPixel(int first, int second) {
    return ((getRed(first) - getRed(second)).abs() +
        (getGreen(first) - getGreen(second)).abs() +
        (getBlue(first) - getBlue(second)).abs());
  }

  static double _getDifferencePercentage(
      {int width, int height, int difference}) {
    int totalPixels = width * height * 3;
    double avgDifferentPixels = difference / totalPixels;
    return (avgDifferentPixels / 255) * 100;
  }
}
