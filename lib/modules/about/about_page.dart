import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/widgets/my_scaffold.dart';
import '../main_layout/widgets/footer/footer.dart';
import '../main_layout/widgets/footer/m_footer.dart';
import '../main_layout/widgets/footer/t_footer.dart';
import 'about_controller.dart';
import 'widgets/mobile/m_about_craft.dart';
import 'widgets/mobile/m_about_header.dart';
import 'widgets/mobile/m_about_target.dart';
import 'widgets/tab/t_about_craft.dart';
import 'widgets/tab/t_about_header.dart';
import 'widgets/tab/t_about_target.dart';
import 'widgets/web/about_craft.dart';
import 'widgets/web/about_header.dart';
import 'widgets/web/about_target.dart';

class AboutPage extends GetView<AboutController> {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1280;
          final isTab = constraints.maxWidth >= 768;

          return ListView(
            children: isDesktop
                ? [AboutHeader(), AboutTarget(), AboutCraft(), Footer()]
                : isTab
                ? [TAboutHeader(), TAboutTarget(), TAboutCraft(), TFooter()]
                : [MAboutHeader(), MAboutTarget(), MAboutCraft(), MFooter()],
          );
        },
      ),
    );
  }
}
