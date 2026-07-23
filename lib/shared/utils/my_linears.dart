import 'package:flutter/material.dart';

import 'my_colors.dart';

class MyLinears {
  static LinearGradient linear1 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0, 0.29, 0.53],
    colors: [
      MyColors.black,
      MyColors.black.withValues(alpha: 0.8),
      MyColors.black.withValues(alpha: 0),
    ],
  );
}
