import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';
import 'package:nocvla_web/shared/utils/my_images.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';

import '../../../../app/routes/my_routes.dart';
import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_utility.dart';
import '../../../../shared/widgets/my_text.dart';

class MNavbar extends StatelessWidget {
  const MNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCount = getCartCount();

    return Container(
      padding: .symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: MyColors.black,
        border: Border(bottom: BorderSide(color: MyColors.line)),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: .centerLeft,
                  child: GestureDetector(
                    behavior: .opaque,
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: Icon(Icons.menu, color: MyColors.white),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Get.offNamed(MyRoutes.home),
                child: SizedBox(
                  width: 106,
                  height: 36,
                  child: MyImageAssets(MyImages.imgNocvla, fit: .contain),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: .centerRight,
                  child: GestureDetector(
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
                                color: MyColors.white,
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
