import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/utils/my_colors.dart';
import 'package:nocvla/views/intro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: MyColors.primary),
      home: IntroPage(),
    );
  }
}
