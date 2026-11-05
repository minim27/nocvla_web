import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/athlete/list/athlete_controller.dart';
import 'package:nocvla_web/modules/athlete/list/widgets/web/athlete_body.dart';
import 'package:nocvla_web/modules/athlete/list/widgets/web/athlete_header.dart';
import 'package:nocvla_web/shared/widgets/my_loading.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../../main_layout/widgets/footer/footer.dart';
import '../../main_layout/widgets/footer/m_footer.dart';
import '../../main_layout/widgets/footer/t_footer.dart';
import 'widgets/mobile/m_athlete_body.dart';
import 'widgets/mobile/m_athlete_header.dart';
import 'widgets/mobile/m_athlete_join.dart';
import 'widgets/tab/t_athlete_body.dart';
import 'widgets/tab/t_athlete_header.dart';
import 'widgets/tab/t_athlete_join.dart';
import 'widgets/web/athlete_join.dart';

class AthletePage extends GetView<AthleteController> {
  const AthletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 1280;
              final isTab = constraints.maxWidth >= 768;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: isDesktop
                      ? [
                          AthleteHeader(),
                          AthleteBody(),
                          AthleteJoin(),
                          Footer(),
                        ]
                      : isTab
                      ? [
                          TAthleteHeader(),
                          TAthleteBody(),
                          TAthleteJoin(),
                          TFooter(),
                        ]
                      : [
                          MAthleteHeader(),
                          MAthleteBody(),
                          MAthleteJoin(),
                          MFooter(),
                        ],
                ),
              );
            },
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoadingSubmit.value,
              child: const MyLoading(isStack: true),
            ),
          ),
        ],
      ),
    );
  }
}
