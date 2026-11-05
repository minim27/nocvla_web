import 'package:flutter/material.dart';

class MyMaxWidth extends StatelessWidget {
  const MyMaxWidth({super.key, required this.child});

  static const double contentWidth = 1320, padding = 48;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: contentWidth + padding * 2),
        child: Padding(
          padding: .symmetric(horizontal: padding),
          child: SizedBox(width: .infinity, child: child),
        ),
      ),
    );
  }
}
