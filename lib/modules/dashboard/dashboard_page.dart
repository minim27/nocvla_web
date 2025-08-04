import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/shared/utils/my_colors.dart';
import 'package:nocvla/shared/utils/my_icons.dart';
import 'package:nocvla/shared/utils/my_images.dart';
import 'package:nocvla/shared/utils/my_utility.dart';
import 'package:nocvla/shared/widgets/my_loading.dart';
import 'dashboard_controller.dart';
import '../../shared/widgets/my_image.dart';
import '../../shared/widgets/my_scaffold.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return MyLoading();

      return MyScaffold(
        appBar: AppBar(
          title: SizedBox(
            width: 70,
            child: MyImageAssets(assets: MyImages.imgNocvla),
          ),
          centerTitle: true,
          actions: [
            SizedBox(
              height: 18,
              width: 18,
              child: MyImageAssets(assets: MyIcons.icAccount),
            ),
            SizedBox(width: 16),
            GestureDetector(
              onTap: () => openCart(),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: MyImageAssets(assets: MyIcons.icCart),
                  ),
                  Visibility(
                    visible: controller.resCart.isNotEmpty,
                    child: Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
        body: Obx(
          () => IndexedStack(
            index: controller.currentIndex.value,
            children: controller.pageList,
          ),
        ),
      );
    });
  }
}
