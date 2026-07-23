import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nocvla_web/modules/athlete/list/athlete_controller.dart';
import 'package:nocvla_web/modules/athlete/list/widgets/web/athlete_body.dart';
import 'package:nocvla_web/modules/athlete/list/widgets/web/athlete_bottom.dart';
import 'package:nocvla_web/modules/athlete/list/widgets/web/athlete_header.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../../main_layout/widgets/footer/footer.dart';
import '../../main_layout/widgets/footer/m_footer.dart';
import '../../main_layout/widgets/footer/t_footer.dart';
import 'widgets/mobile/m_athlete_body.dart';
import 'widgets/mobile/m_athlete_bottom.dart';
import 'widgets/mobile/m_athlete_header.dart';
import 'widgets/tab/t_athlete_body.dart';
import 'widgets/tab/t_athlete_bottom.dart';
import 'widgets/tab/t_athlete_header.dart';

class AthletePage extends GetView<AthleteController> {
  const AthletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1280;
          final isTab = constraints.maxWidth >= 768;

          return ListView(
            children: isDesktop
                ? [AthleteHeader(), AthleteBody(), AthleteBottom(), Footer()]
                : isTab
                ? [
                    TAthleteHeader(),
                    TAthleteBody(),
                    TAthleteBottom(),
                    TFooter(),
                  ]
                : [
                    MAthleteHeader(),
                    MAthleteBody(),
                    MAthleteBottom(),
                    MFooter(),
                  ],
          );
        },
      ),
    );
  }
}
