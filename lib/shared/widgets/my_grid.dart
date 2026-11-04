import 'package:flutter/material.dart';

class MyGrid extends StatelessWidget {
  const MyGrid({
    super.key,
    required this.crossAxisCount,
    required this.children,
    this.spacing = 16,
  });

  final int crossAxisCount;
  final double spacing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            ((constraints.maxWidth - spacing * (crossAxisCount - 1)) /
                    crossAxisCount)
                .floorToDouble();

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final child in children) SizedBox(width: width, child: child),
          ],
        );
      },
    );
  }
}
