import 'package:flutter/material.dart';

class EHexColor extends Color {
  static int toHexColor(String hexColor) {
    hexColor = hexColor.toLowerCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  EHexColor(final String hexColor) : super(toHexColor(hexColor));
}
