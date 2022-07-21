
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class UtilityImage {
  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }
}