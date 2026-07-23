import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nocvla_web/modules/home/home_controller.dart';
import 'package:nocvla_web/modules/home/widgets/web/home_featured.dart';
import 'package:nocvla_web/modules/home/widgets/web/home_header.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../main_layout/widgets/footer/footer.dart';
import '../main_layout/widgets/footer/m_footer.dart';
import '../main_layout/widgets/footer/t_footer.dart';
import 'widgets/mobile/m_home_featured.dart';
import 'widgets/mobile/m_home_header.dart';
import 'widgets/mobile/m_home_movement.dart';
import 'widgets/tab/t_home_featured.dart';
import 'widgets/tab/t_home_header.dart';
import 'widgets/tab/t_home_movement.dart';
import 'widgets/web/home_movement.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1280;
          final isTab = constraints.maxWidth >= 768;

          return ListView(
            children: isDesktop
                ? [HomeHeader(), HomeFeatured(), HomeMovement(), Footer()]
                : isTab
                ? [THomeHeader(), THomeFeatured(), THomeMovement(), TFooter()]
                : [MHomeHeader(), MHomeFeatured(), MHomeMovement(), MFooter()],
          );
        },
      ),
    );
  }
}
