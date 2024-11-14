import 'dart:typed_data';
import 'package:image/image.dart' as img;

class ImageUtils {
  static img.Image covertToImage(Uint8List image) {
    return img.decodeImage(image)!;
  }

  static img.Image resize(img.Image image, int width, int height) {
    img.Image copyImage = img.copyResize(image, width: width, height: height);
    return copyImage;
  }

  static img.Image toGray(img.Image image) {
    return img.grayscale(image);
  }

  static int getWidth(Uint8List image) {
    return img.decodeImage(image)!.width;
  }

  static int getHeight(Uint8List image) {
    return img.decodeImage(image)!.height;
  }
}
