import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nocvla_web/modules/athlete/application/athlete_application_controller.dart';
import 'package:nocvla_web/shared/widgets/my_loading.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../../../shared/utils/my_fonts.dart';
import '../../../shared/widgets/my_text.dart';
import '../../main_layout/widgets/footer/footer.dart';
import '../../main_layout/widgets/footer/m_footer.dart';
import '../../main_layout/widgets/footer/t_footer.dart';
import 'widgets/mobile/m_athlete_application_form.dart';
import 'widgets/tab/t_athlete_application_form.dart';
import 'widgets/web/athlete_application_form.dart';

class AthleteApplicationPage extends GetView<AthleteApplicationController> {
  const AthleteApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 1280;
              final isTab = constraints.maxWidth >= 768;

              return ListView(
                children: [
                  Padding(
                    padding: .all(isDesktop ? 40 : 24),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        MyText(
                          text: "ATHLETE APPLICATION",
                          fontSize: 42,
                          letterSpacing: 2,
                          fontFamily: MyFonts.grenzeGotisch,
                        ),
                        SizedBox(height: 20),
                        isDesktop
                            ? AthleteApplicationForm()
                            : isTab
                            ? TAthleteApplicationForm()
                            : MAthleteApplicationForm(),
                      ],
                    ),
                  ),
                  isDesktop
                      ? Footer()
                      : isTab
                      ? TFooter()
                      : MFooter(),
                ],
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
