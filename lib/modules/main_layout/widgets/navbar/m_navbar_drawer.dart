import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/early_access/early_access_controller.dart';
import 'package:nocvla_web/shared/utils/my_images.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';

import '../../../../app/routes/my_routes.dart';
import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_divider.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../main_layout_controller.dart';

class MNavbarDrawer extends StatelessWidget {
  const MNavbarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainLayoutController>();
    final isDropActive = Get.find<EarlyAccessController>().isActive;

    return Drawer(
      backgroundColor: MyColors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: .all(24),
              child: SizedBox(
                width: 118,
                height: 40,
                child: MyImageAssets(MyImages.imgNocvla, fit: .contain),
              ),
            ),
            MyDivider(bottomGap: 8),
            navItem(
              context: context,
              label: "KOLEKSI",
              route: MyRoutes.collection,
              isActive: controller.isActiveRoute(MyRoutes.collection),
            ),
            navItem(
              context: context,
              label: "ATLET",
              route: MyRoutes.athlete,
              isActive: controller.isActiveRoute(MyRoutes.athlete),
            ),
            if (isDropActive)
              navItem(
                context: context,
                label: "DROP",
                route: MyRoutes.earlyAccess,
                isActive: controller.isActiveRoute(MyRoutes.earlyAccess),
              ),
            navItem(
              context: context,
              label: "TENTANG",
              route: MyRoutes.about,
              isActive: controller.isActiveRoute(MyRoutes.about),
            ),
            navItem(
              context: context,
              label: "KONTAK",
              route: MyRoutes.contact,
              isActive: controller.isActiveRoute(MyRoutes.contact),
            ),
            navItem(
              context: context,
              label: "CARI",
              route: MyRoutes.search,
              isActive: controller.isActiveRoute(MyRoutes.search),
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem({
    required BuildContext context,
    required String label,
    required String route,
    required bool isActive,
  }) {
    return GestureDetector(
      behavior: .opaque,
      onTap: () {
        Scaffold.of(context).closeDrawer();
        Get.offNamed(route);
      },
      child: Container(
        width: .infinity,
        padding: .symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: isActive ? MyColors.red : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: MyText(
          text: label,
          fontFamily: MyFonts.archivoNarrow,
          fontSize: 16,
          letterSpacing: 16 * 0.12,
          fontWeight: isActive ? .w700 : .w500,
          color: isActive ? MyColors.white : MyColors.white2,
        ),
      ),
    );
  }
}
