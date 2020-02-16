import 'package:flutter/material.dart' as material;
import 'package:image/image.dart';

extension ImageComparator on Image {
  material.Widget asWidget() {
    return material.Image(image: material.MemoryImage(encodePng(this)));
  }

  bool equalSize(Image second) {
    return this.height == second.height && this.width == second.width;
  }

  Future<Image> difference(Image second) async {
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
