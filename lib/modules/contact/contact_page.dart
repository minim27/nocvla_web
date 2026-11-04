import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/widgets/my_scaffold.dart';
import '../main_layout/widgets/footer/footer.dart';
import '../main_layout/widgets/footer/m_footer.dart';
import '../main_layout/widgets/footer/t_footer.dart';
import 'contact_controller.dart';
import 'widgets/mobile/m_contact_sosmed.dart';
import 'widgets/tab/t_contact_sosmed.dart';
import 'widgets/web/contact_sosmed.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1280;
          final isTab = constraints.maxWidth >= 768;

          return ListView(
            children: isDesktop
                ? [ContactSosmed(), Footer()]
                : isTab
                ? [TContactSosmed(), TFooter()]
                : [MContactSosmed(), MFooter()],
          );
        },
      ),
    );
  }
}
