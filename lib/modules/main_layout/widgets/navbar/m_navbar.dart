import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';

import '../../../../app/routes/my_routes.dart';
import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_utility.dart';
import '../../../../shared/widgets/my_text.dart';

class MNavbar extends StatelessWidget {
  const MNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCount = getCartCount();

    return Container(
      padding: .symmetric(horizontal: 24),
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
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Icon(Icons.menu, color: MyColors.white),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => Get.offNamed(MyRoutes.home),
              child: MyText(
                text: "NOCVLA",
                fontSize: 24,
                fontFamily: MyFonts.bebasNeue,
                fontWeight: .w600,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => Get.toNamed(MyRoutes.cart),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  MyImageAssets(MyIcons.icCart),
                  if (cartCount > 0)
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
                          text: "$cartCount",
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
}
