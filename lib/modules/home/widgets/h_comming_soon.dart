import 'package:flutter/material.dart';

import '../../../shared/utils/my_colors.dart';
import '../../../shared/utils/my_images.dart';
import '../../../shared/widgets/my_image.dart';
import '../../../shared/widgets/my_text.dart';

class HCommingSoon extends StatelessWidget {
  const HCommingSoon({
    super.key,
    required this.screenSize,
    required Animation<Color?> colorAnimation,
  }) : _colorAnimation = colorAnimation;

  final Size screenSize;
  final Animation<Color?> _colorAnimation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _colorAnimation,
            builder: (context, child) => ColorFiltered(
              colorFilter: ColorFilter.mode(
                _colorAnimation.value ?? Colors.white,
                BlendMode.modulate,
              ),
              child: child,
            ),
            child: MyImageAssets(assets: MyImages.imgNocvla),
          ),
          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 20, height: 1, color: MyColors.secondary),
              const MyText(text: "COMING SOON"),
              Container(width: 20, height: 1, color: MyColors.secondary),
            ],
          ),
        ],
      ),
    );
  }
}
