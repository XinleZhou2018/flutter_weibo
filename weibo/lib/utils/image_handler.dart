import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

class ImageHandler {
  /// Image File 转 base64
  static String? imageFileToBase64(File imageFile) {
    Uint8List uint8list = imageFile.readAsBytesSync();
    String imageBase64String = base64Encode(uint8list);
    return imageBase64String;
  }
}
