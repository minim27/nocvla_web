import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nocvla_web/modules/faq/faq_controller.dart';
import 'package:nocvla_web/modules/faq/widgets/faq_body.dart';
import 'package:nocvla_web/modules/faq/widgets/faq_header.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../main_layout/widgets/footer/footer.dart';

class FAQPage extends GetView<FAQController> {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: ListView(children: [FAQHeader(), FAQBody(), Footer()]),
    );
  }
}
