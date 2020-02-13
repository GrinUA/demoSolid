import 'package:image/image.dart';

abstract class ImageComparator {
  static String compare(Image first, Image second) {
    int sWidth = first.width;
    int sHeight = first.height;
    int fWidth = first.width;
    int fHeight = first.height;
    if (sWidth != fWidth || sHeight != fHeight) {
      return 'Not mached';
    } else {
      num difference = 0;
      for (int y = 0; y < fHeight; y++) {
        for (int x = 0; x < fHeight; x++) {
          int rgbFirst = first.getPixel(x, y);
          print(rgbFirst);
          int rgbSecond = second.getPixel(x, y);
          print(rgbSecond);
          difference += (rgbFirst - rgbSecond);
          print(difference);
        }
      }
    }
  }
}
