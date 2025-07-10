import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/widgets/my_text.dart';

import '../controllers/controller/dashboard_controller.dart';
import '../utils/my_colors.dart';
import '../utils/my_images.dart';
import '../widgets/my_image.dart';
import '../widgets/my_scaffold.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  var controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => controller.enterSite(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24,
          children: [
            SizedBox(
              width: 700,
              child: MyImageAssets(assets: MyImages.imgNocvla),
            ),
            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 20, height: 1, color: MyColors.secondary),
                const MyText(text: "TAP TO ENTER SITE", fontSize: 14),
                Container(width: 20, height: 1, color: MyColors.secondary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
