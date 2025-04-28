import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:typed_data';

class Authorization {
  static String? username;
  static String? password;
}

Image imageFromBase64String(String base64Image) {
  //return Image.memory(base64Decode(base64Image));
  Uint8List bytes = base64Decode(base64Image);

  // You can specify the desired width and height for the image
  double desiredWidth = 600; // Change this to your desired width
  double desiredHeight = 300; // Change this to your desired height

  // Use the Image.memory constructor and set the width and height to desired values
  return Image.memory(
    bytes,
    width: desiredWidth,
    height: desiredHeight,
    fit: BoxFit
        .cover, // You can use BoxFit.fill, BoxFit.contain, or any other BoxFit as needed
  );
}
