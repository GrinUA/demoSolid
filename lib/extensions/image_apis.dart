import 'package:flutter/widgets.dart' as widgets;
import 'package:image/image.dart';

extension ImageProcessor on Image {
  widgets.MemoryImage toMemoryWidget() {
    return widgets.MemoryImage(encodePng(this));
  }

  bool isSameSize(Image second) {
    return this.height == second.height && this.width == second.width;
  }

  Image difference(Image second) {
    int differenceColor = 0xFF0000FF;
    Image result = Image.from(this);
    for (int y = 0; y < result.height; y++) {
      for (int x = 0; x < result.width; x++) {
        int pixelFirst = result.getPixel(x, y);
        int pixelSecond = second.getPixel(x, y);

        if (_getDifferenceByPixel(pixelFirst, pixelSecond) != 0) {
          result.setPixel(x, y, differenceColor);
        }
      }
    }
    return result;
  }

  int _getDifferenceByPixel(int first, int second) {
    return ((getRed(first) - getRed(second)).abs() +
        (getGreen(first) - getGreen(second)).abs() +
        (getBlue(first) - getBlue(second)).abs());
  }
}
