import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/shared/utils/my_icons.dart';
import 'package:nocvla/shared/utils/my_images.dart';
import 'dashboard_controller.dart';
import '../../shared/widgets/my_image.dart';
import '../../shared/widgets/my_scaffold.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<DashboardController>();

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
          SizedBox(
            height: 18,
            width: 18,
            child: MyImageAssets(assets: MyIcons.icCart),
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
  }
}
