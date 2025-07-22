import 'package:flutter/material.dart';

import 'my_image.dart';

class MyProduct extends StatelessWidget {
  const MyProduct({super.key, required this.image, required this.onTap});

  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MyImage(image: image, alignment: Alignment.topCenter),
    );
  }
}
