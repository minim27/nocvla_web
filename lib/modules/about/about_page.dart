import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nocvla_web/modules/about/about_controller.dart';
import 'package:nocvla_web/modules/about/widgets/web/about_bottom.dart';
import 'package:nocvla_web/modules/about/widgets/web/about_header.dart';
import 'package:nocvla_web/modules/about/widgets/web/about_target.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../main_layout/widgets/footer/footer.dart';
import '../main_layout/widgets/footer/m_footer.dart';
import '../main_layout/widgets/footer/t_footer.dart';
import 'widgets/mobile/m_about_header.dart';
import 'widgets/mobile/m_about_target.dart';
import 'widgets/tab/t_about_header.dart';
import 'widgets/tab/t_about_target.dart';

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
                ? [AboutHeader(), AboutTarget(), AboutBottom(), Footer()]
                : isTab
                ? [TAboutHeader(), TAboutTarget(), AboutBottom(), TFooter()]
                : [MAboutHeader(), MAboutTarget(), AboutBottom(), MFooter()],
          );
        },
      ),
    );
  }
}
