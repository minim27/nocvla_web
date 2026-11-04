import 'package:flutter/material.dart';

import '../utils/my_colors.dart';

class MyPanel extends StatelessWidget {
  const MyPanel({
    super.key,
    required this.child,
    this.padding = const .all(24),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: MyColors.black2,
        border: .all(color: MyColors.line),
      ),
      child: child,
    );
  }
}
