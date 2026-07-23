import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nocvla_web/modules/contact/contact_controller.dart';
import 'package:nocvla_web/modules/contact/widgets/web/contact_sosmed.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../main_layout/widgets/footer/footer.dart';
import '../main_layout/widgets/footer/m_footer.dart';
import 'widgets/mobile/m_contact_form.dart';
import 'widgets/mobile/m_contact_sosmed.dart';
import 'widgets/web/contact_form.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTab = constraints.maxWidth >= 768;

          return ListView(
            children: isTab
                ? [
                    Padding(
                      padding: .symmetric(vertical: 80, horizontal: 40),
                      child: Row(
                        spacing: 100,
                        children: [ContactSosmed(), ContactForm()],
                      ),
                    ),
                    Footer(),
                  ]
                : [
                    Padding(
                      padding: .symmetric(vertical: 80, horizontal: 24),
                      child: Column(
                        spacing: 40,
                        children: [MContactSosmed(), MContactForm()],
                      ),
                    ),
                    MFooter(),
                  ],
          );
        },
      ),
    );
  }
}
