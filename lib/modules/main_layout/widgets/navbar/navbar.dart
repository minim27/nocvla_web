import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';

import '../../../../app/routes/my_routes.dart';
import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_text.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;

    return Container(
      padding: .symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: MyColors.black,
        border: Border(
          bottom: BorderSide(color: MyColors.white.withValues(alpha: 0.08)),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.offNamed(MyRoutes.home),
              child: MyText(
                text: "NOCVLA",
                fontSize: 28,
                fontFamily: MyFonts.bebasNeue,
                fontWeight: .w600,
              ),
            ),
            Spacer(),
            navItem(
              label: "HOME",
              route: MyRoutes.home,
              currentRoute: currentRoute,
            ),
            navItem(
              label: "COLLECTIONS",
              route: MyRoutes.collection,
              currentRoute: currentRoute,
            ),
            navItem(
              label: "ATHLETES",
              route: MyRoutes.athlete,
              currentRoute: currentRoute,
            ),
            navItem(
              label: "ABOUT",
              route: MyRoutes.about,
              currentRoute: currentRoute,
            ),
            navItem(
              label: "CONTACT",
              route: MyRoutes.contact,
              currentRoute: currentRoute,
            ),
            SizedBox(width: 40),
            GestureDetector(
              onTap: () => null,
              child: MyImageAssets(MyIcons.icSearch),
            ),
            SizedBox(width: 16),
            GestureDetector(
              onTap: () => null,
              child: MyImageAssets(MyIcons.icProfile),
            ),
            SizedBox(width: 16),
            GestureDetector(
              onTap: () => null,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  MyImageAssets(MyIcons.icCart),
                  Positioned(
                    top: -6,
                    right: -8,
                    child: Container(
                      width: 18,
                      height: 18,
                      alignment: .center,
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: MyText(
                        text: "2",
                        fontSize: 10,
                        color: MyColors.black,
                        fontWeight: .w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem({
    required String label,
    required String route,
    required String currentRoute,
  }) {
    final isActive = currentRoute == route;

    return GestureDetector(
      onTap: () => Get.offNamed(route),
      child: Container(
        margin: .only(left: 32),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            MyText(
              text: label,
              fontSize: 14,
              fontWeight: isActive ? .w600 : .w400,
              color: isActive
                  ? MyColors.white
                  : MyColors.white.withValues(alpha: 0.6),
            ),
            SizedBox(height: 6),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: isActive ? 20 : 0,
              height: 2,
              decoration: BoxDecoration(color: MyColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
