import 'package:flutter/material.dart';

import '../utils/my_colors.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
    this.height = 1,
    this.color = MyColors.white,
    this.topGap = 0,
    this.bottomGap = 0,
  });

  final double height;
  final Color color;
  final double topGap, bottomGap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: .only(top: topGap, bottom: bottomGap),
      width: .infinity,
      height: height,
      color: color.withValues(alpha: 0.1),
    );
  }
}

class MyDashDivider extends StatelessWidget {
  const MyDashDivider({
    super.key,
    this.height = 1,
    this.color = MyColors.white,
  });

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 8.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: .spaceBetween,
          direction: Axis.horizontal,
          children: .generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            );
          }),
        );
      },
    );
  }
}
