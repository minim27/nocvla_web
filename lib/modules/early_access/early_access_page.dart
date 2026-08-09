import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import 'early_access_controller.dart';
import 'widgets/mobile/m_early_access_gate.dart';
import 'widgets/tab/t_early_access_gate.dart';
import 'widgets/web/early_access_gate.dart';

class EarlyAccessPage extends GetView<EarlyAccessController> {
  const EarlyAccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      backgroundColor: MyColors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1280;
          final isTab = constraints.maxWidth >= 768;

          return isDesktop
              ? const EarlyAccessGate()
              : isTab
              ? const TEarlyAccessGate()
              : const MEarlyAccessGate();
        },
      ),
    );
  }
}
