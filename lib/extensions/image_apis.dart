import 'package:image/image.dart';

extension ImageComparator on Image {
  Future<String> compare(Image second) async {
    if (this.width != second.width || this.height != second.height) {
      return 'For images that do not match in sizes difference is: 100%';
    }
    num difference = 0;
    for (int y = 0; y < this.height; y++) {
      for (int x = 0; x < this.width; x++) {
        int pixelFirst = this.getPixel(x, y);
        int pixelSecond = second.getPixel(x, y);
        difference += _getDifferenceByPixel(pixelFirst, pixelSecond);
      }
    }

    double percentage = _getDifferencePercentage(
        width: this.width, height: this.height, difference: difference);
    return 'Difference is: ${percentage.floor()}%';
  }

  int _getDifferenceByPixel(int first, int second) {
    return ((getRed(first) - getRed(second)).abs() +
        (getGreen(first) - getGreen(second)).abs() +
        (getBlue(first) - getBlue(second)).abs());
  }

  double _getDifferencePercentage({int width, int height, int difference}) {
    int totalPixels = width * height * 3;
    double avgDifferentPixels = difference / totalPixels;
    return (avgDifferentPixels / 255) * 100;
  }
}
