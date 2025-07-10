import 'package:flutter/material.dart';
import 'package:nocvla/utils/my_colors.dart';
import 'package:nocvla/views/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: MyColors.primary),
      home: DashboardPage(currentIndex: 0),
    );
  }
}
