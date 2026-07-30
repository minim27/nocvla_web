import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';

import '../../../../app/routes/my_routes.dart';
import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/widgets/my_text.dart';

class MNavbarDrawer extends StatelessWidget {
  const MNavbarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;

    return Drawer(
      backgroundColor: MyColors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(height: 8),
            navItem(
              context: context,
              label: "HOME",
              route: MyRoutes.home,
              currentRoute: currentRoute,
            ),
            navItem(
              context: context,
              label: "COLLECTIONS",
              route: MyRoutes.collection,
              currentRoute: currentRoute,
            ),
            navItem(
              context: context,
              label: "ATHLETES",
              route: MyRoutes.athlete,
              currentRoute: currentRoute,
            ),
            navItem(
              context: context,
              label: "ABOUT",
              route: MyRoutes.about,
              currentRoute: currentRoute,
            ),
            navItem(
              context: context,
              label: "CONTACT",
              route: MyRoutes.contact,
              currentRoute: currentRoute,
            ),
            Padding(
              padding: .symmetric(horizontal: 24, vertical: 16),
              child: Container(
                height: 1,
                color: MyColors.white.withValues(alpha: 0.08),
              ),
            ),
            GestureDetector(
              onTap: () => null,
              child: Padding(
                padding: .symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  spacing: 16,
                  children: [
                    MyImageAssets(MyIcons.icSearch),
                    MyText(text: "SEARCH", fontSize: 14),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => null,
              child: Padding(
                padding: .symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  spacing: 16,
                  children: [
                    MyImageAssets(MyIcons.icProfile),
                    MyText(text: "PROFILE", fontSize: 14),
                  ],
                ),
              ),
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
    required String currentRoute,
  }) {
    final isActive = currentRoute == route;

    return GestureDetector(
      onTap: () {
        Scaffold.of(context).closeDrawer();
        Get.offNamed(route);
      },
      child: Container(
        width: double.infinity,
        padding: .symmetric(horizontal: 24, vertical: 16),
        child: MyText(
          text: label,
          fontSize: 16,
          fontWeight: isActive ? .w600 : .w400,
          color: isActive
              ? MyColors.white
              : MyColors.white.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
