import 'package:flutter/material.dart';

class MyColors {
  static const Color black = Color(0xFF0B0A0B);
  static const Color black2 = Color(0xFF100E10);
  static const Color black3 = Color(0xFF0B0A0B);
  static const Color black4 = Color(0xFF100E10);
  static const Color black6 = Color(0xFF080708);
  static const Color black5 = Color(0xFF141314);

  static const Color nativeBlack = Color(0xFF000000);

  static const Color white = Color(0xFFEDE8E3);
  static const Color white2 = Color(0xFFA29A94);
  static const Color white3 = Color(0xFFC8C0BA);
  static const Color white4 = Color(0xFF87807B);
  static const Color placeholder = Color(0xFF757575);

  static const Color nativeWhite = Color(0xFFFFFFFF);

  static const Color line = Color(0xFF2A2528);
  static const Color line2 = Color(0xFF2A2528);
  static const Color line3 = Color(0xFF1F1B1E);
  static const Color swatchBorder = Color(0xFF4A4245);

  static const Color red = Color(0xFFC8302A);
  static const Color redText = Color(0xFFE5574C);

  static const Color green = Color(0xFF8FC9A0);
  static const Color orange = Color(0xFFF0A35E);

  static Color hex(String? value) {
    final parsed = int.tryParse(
      "${value ?? ""}".replaceAll("#", ""),
      radix: 16,
    );

    return parsed == null ? swatchBorder : Color(0xFF000000 | parsed);
  }

  static const Color whatsApp = Color(0xFF1fbd6a);
  static const Color instagram = Color(0xFFfd2d4e);
}
