import 'package:flutter/material.dart';

import '../utils/my_colors.dart';

class MyDashBorder extends StatelessWidget {
  const MyDashBorder({
    super.key,
    required this.child,
    this.color = MyColors.swatchBorder,
  });

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _DashPainter(color), child: child);
  }
}

class _DashPainter extends CustomPainter {
  const _DashPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const dash = 3.0, gap = 2.0;
    final paint = Paint()..color = color;

    for (double x = 0; x < size.width; x += dash + gap) {
      canvas.drawRect(Rect.fromLTWH(x, 0, dash, 1), paint);
      canvas.drawRect(Rect.fromLTWH(x, size.height - 1, dash, 1), paint);
    }
    for (double y = 0; y < size.height; y += dash + gap) {
      canvas.drawRect(Rect.fromLTWH(0, y, 1, dash), paint);
      canvas.drawRect(Rect.fromLTWH(size.width - 1, y, 1, dash), paint);
    }
  }

  @override
  bool shouldRepaint(_DashPainter oldDelegate) => oldDelegate.color != color;
}
