import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/utils/my_icons.dart';
import 'package:nocvla/utils/my_images.dart';
import 'package:nocvla/widgets/my_text.dart';
import '../controllers/controller/dashboard_controller.dart';
import '../utils/my_colors.dart';
import '../widgets/my_image.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final controller = Get.put(DashboardController());

  @override
  void initState() {
    controller.currentIndex.value = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: Row(
          children: [
            SizedBox(
              width: 70,
              child: MyImageAssets(assets: MyImages.imgNocvla),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.menuDashboard.length,
                  (index) => GestureDetector(
                    onTap: () => controller.changeMenuSelected(idx: index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Obx(
                        () => MyText(
                          text: controller.menuDashboard[index]["title"],
                          color: controller.currentIndex.value == index
                              ? MyColors.primary80
                              : MyColors.secondary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              spacing: 16,
              children: [
                SizedBox(
                  height: 18,
                  width: 18,
                  child: MyImageAssets(assets: MyIcons.icAccount),
                ),
                SizedBox(
                  height: 18,
                  width: 18,
                  child: MyImageAssets(assets: MyIcons.icCart),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value!,
          children: controller.pageList,
        ),
      ),
    );
  }
}
