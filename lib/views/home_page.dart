import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/controllers/controller/home_controller.dart';
import 'package:nocvla/utils/my_colors.dart';
import 'package:nocvla/widgets/my_scaffold.dart';
import 'package:nocvla/widgets/my_text.dart';

import '../utils/my_images.dart';
import '../widgets/my_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(HomeController());

  late AnimationController _animController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Inisialisasi animasi awal
    _setupColorAnimation(
      from: controller.listColors[controller.currentColorIndex.value],
      to:
          controller.listColors[(controller.currentColorIndex.value + 1) %
              controller.listColors.length],
    );

    // Dengarkan perubahan index warna dari controller
    ever(controller.currentColorIndex, (int newIndex) {
      final prevColor = _colorAnimation.value ?? controller.listColors[0];
      final nextColor = controller.listColors[newIndex];
      _setupColorAnimation(from: prevColor, to: nextColor);
      _animController.forward(from: 0);
    });

    _animController.forward();
  }

  void _setupColorAnimation({required Color from, required Color to}) {
    _colorAnimation = ColorTween(begin: from, end: to).animate(_animController);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return MyScaffold(
      body: Container(
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
      ),
    );
  }
}
