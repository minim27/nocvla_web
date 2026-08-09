import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/main_layout/widgets/navbar/m_navbar.dart';
import 'package:nocvla_web/modules/main_layout/widgets/navbar/t_navbar.dart';

import '../../app/routes/my_routes.dart';
import 'widgets/navbar/m_navbar_drawer.dart';
import 'widgets/navbar/navbar.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (Get.currentRoute == MyRoutes.earlyAccess) return child;

    return Scaffold(
      drawer: MNavbarDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1280;
          final isTab = constraints.maxWidth >= 768;

          return Column(
            children: [
              isDesktop
                  ? Navbar()
                  : isTab
                  ? TNavbar()
                  : MNavbar(),
              Expanded(child: child),
            ],
          );
        },
      ),
    );
  }
}
