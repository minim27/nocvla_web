import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/early_access/early_access_controller.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';
import 'package:nocvla_web/shared/utils/my_images.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';

import '../../../../app/routes/my_routes.dart';
import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_utility.dart';
import '../../../../shared/widgets/my_max_width.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../main_layout_controller.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainLayoutController>();
    final isDropActive = Get.find<EarlyAccessController>().isActive;
    final cartCount = getCartCount();

    return Container(
      decoration: BoxDecoration(
        color: MyColors.black,
        border: Border(bottom: BorderSide(color: MyColors.line)),
      ),
      child: MyMaxWidth(
        child: SafeArea(
          child: SizedBox(
            height: 72,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    spacing: 32,
                    children: [
                      navItem(
                        label: "KOLEKSI",
                        route: MyRoutes.collection,
                        isActive: controller.isActiveRoute(MyRoutes.collection),
                      ),
                      navItem(
                        label: "ATLET",
                        route: MyRoutes.athlete,
                        isActive: controller.isActiveRoute(MyRoutes.athlete),
                      ),
                      if (isDropActive)
                        navItem(
                          label: "DROP",
                          route: MyRoutes.earlyAccess,
                          isActive: controller.isActiveRoute(
                            MyRoutes.earlyAccess,
                          ),
                        ),
                      navItem(
                        label: "TENTANG",
                        route: MyRoutes.about,
                        isActive: controller.isActiveRoute(MyRoutes.about),
                      ),
                      navItem(
                        label: "KONTAK",
                        route: MyRoutes.contact,
                        isActive: controller.isActiveRoute(MyRoutes.contact),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.offNamed(MyRoutes.home),
                  child: SizedBox(
                    width: 120,
                    height: 41,
                    child: MyImageAssets(MyImages.imgNocvla, fit: .contain),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: .centerRight,
                    child: Row(
                      mainAxisSize: .min,
                      children: [
                        GestureDetector(
                          behavior: .opaque,
                          onTap: () => Get.toNamed(MyRoutes.search),
                          child: SizedBox(
                            width: 44,
                            height: 44,
                            child: MyImageAssets(MyIcons.icSearch),
                          ),
                        ),
                        GestureDetector(
                          behavior: .opaque,
                          onTap: () => Get.toNamed(MyRoutes.cart),
                          child: SizedBox(
                            width: 44,
                            height: 44,
                            child: Stack(
                              alignment: .center,
                              clipBehavior: Clip.none,
                              children: [
                                MyImageAssets(MyIcons.icCart),
                                if (cartCount > 0)
                                  Positioned(
                                    top: 2,
                                    right: 0,
                                    child: Container(
                                      width: 18,
                                      height: 18,
                                      alignment: .center,
                                      color: MyColors.red,
                                      child: MyText(
                                        text: "$cartCount",
                                        fontSize: 10,
                                        color: MyColors.nativeWhite,
                                        fontWeight: .w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navItem({
    required String label,
    required String route,
    required bool isActive,
  }) {
    return GestureDetector(
      behavior: .opaque,
      onTap: () => Get.offNamed(route),
      child: SizedBox(
        height: 72,
        child: Column(
          mainAxisAlignment: .center,
          spacing: 6,
          children: [
            MyText(
              text: label,
              fontFamily: MyFonts.archivoNarrow,
              fontSize: 14,
              letterSpacing: 14 * 0.12,
              fontWeight: isActive ? .w700 : .w500,
              color: isActive ? MyColors.white : MyColors.white2,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: isActive ? 20 : 0,
              height: 2,
              color: MyColors.red,
            ),
          ],
        ),
      ),
    );
  }
}
