import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nocvla_web/modules/athlete/detail/athlete_detail_controller.dart';
import 'package:nocvla_web/modules/athlete/detail/widgets/mobile/m_athlete_detail_body.dart';
import 'package:nocvla_web/modules/athlete/detail/widgets/mobile/m_athlete_detail_header.dart';
import 'package:nocvla_web/modules/athlete/detail/widgets/tab/t_athlete_detail_body.dart';
import 'package:nocvla_web/modules/athlete/detail/widgets/tab/t_athlete_detail_header.dart';
import 'package:nocvla_web/modules/athlete/detail/widgets/web/athlete_detail_body.dart';
import 'package:nocvla_web/modules/athlete/detail/widgets/web/athlete_detail_header.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../../main_layout/widgets/footer/footer.dart';
import '../../main_layout/widgets/footer/m_footer.dart';
import '../../main_layout/widgets/footer/t_footer.dart';

class AthleteDetailPage extends GetView<AthleteDetailController> {
  const AthleteDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1280;
          final isTab = constraints.maxWidth >= 768;

          return ListView(
            children: isDesktop
                ? [AthleteDetailHeader(), AthleteDetailBody(), Footer()]
                : isTab
                ? [TAthleteDetailHeader(), TAthleteDetailBody(), TFooter()]
                : [MAthleteDetailHeader(), MAthleteDetailBody(), MFooter()],
          );
        },
      ),
    );
  }
}
