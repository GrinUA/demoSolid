import 'dart:io';

import 'package:image/image.dart' as image;

abstract class ImageComparator {
  static Future<String> compare(File firstFile, File secondFile) async {
    image.Image first = image.decodeImage(firstFile.readAsBytesSync());
    image.Image second = image.decodeImage(secondFile.readAsBytesSync());
    int fWidth = first.width;
    int fHeight = first.height;
    int sWidth = second.width;
    int sHeight = second.height;
    if (sWidth != fWidth || sHeight != fHeight) {
      return 'Not mached';
    } else {
      num difference = 0;
      for (int y = 0; y < fHeight; y++) {
        for (int x = 0; x < fWidth; x++) {
          int rgbFirst = first.getPixel(x, y);
          int redFirst = image.getRed(rgbFirst);
          int greenFirst = image.getGreen(rgbFirst);
          int blueFirst = image.getBlue(rgbFirst);

          int rgbSecond = second.getPixel(x, y);

          int redSecond = image.getRed(rgbSecond);
          int greenSecond = image.getGreen(rgbSecond);
          int blueSecond = image.getBlue(rgbSecond);

          difference += (redFirst - redSecond).abs();
          difference += (greenFirst - greenSecond).abs();
          difference += (blueFirst - blueSecond).abs();


        }
      }
      int totalPixels = fWidth * fHeight * 3;

      double avgDifferentPixels = difference / totalPixels;

      double percentage = (avgDifferentPixels / 255) * 100;

      return 'Difference is: ${percentage.floor()}%';
    }
  }
}
