import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/widgets/my_scaffold.dart';
import '../main_layout/widgets/footer/footer.dart';
import '../main_layout/widgets/footer/m_footer.dart';
import '../main_layout/widgets/footer/t_footer.dart';
import 'home_controller.dart';
import 'widgets/mobile/m_home_athletes.dart';
import 'widgets/mobile/m_home_categories.dart';
import 'widgets/mobile/m_home_featured.dart';
import 'widgets/mobile/m_home_header.dart';
import 'widgets/mobile/m_home_order.dart';
import 'widgets/mobile/m_home_scriptures.dart';
import 'widgets/tab/t_home_athletes.dart';
import 'widgets/tab/t_home_categories.dart';
import 'widgets/tab/t_home_featured.dart';
import 'widgets/tab/t_home_header.dart';
import 'widgets/tab/t_home_order.dart';
import 'widgets/tab/t_home_scriptures.dart';
import 'widgets/web/home_athletes.dart';
import 'widgets/web/home_categories.dart';
import 'widgets/web/home_featured.dart';
import 'widgets/web/home_header.dart';
import 'widgets/web/home_order.dart';
import 'widgets/web/home_scriptures.dart';

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
                ? [
                    HomeHeader(),
                    HomeCategories(),
                    HomeFeatured(),
                    HomeScriptures(),
                    HomeAthletes(),
                    HomeOrder(),
                    Footer(),
                  ]
                : isTab
                ? [
                    THomeHeader(),
                    THomeCategories(),
                    THomeFeatured(),
                    THomeScriptures(),
                    THomeAthletes(),
                    THomeOrder(),
                    TFooter(),
                  ]
                : [
                    MHomeHeader(),
                    MHomeCategories(),
                    MHomeFeatured(),
                    MHomeScriptures(),
                    MHomeAthletes(),
                    MHomeOrder(),
                    MFooter(),
                  ],
          );
        },
      ),
    );
  }
}
