import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nocvla_web/modules/checkout/checkout_controller.dart';
import 'package:nocvla_web/modules/main_layout/widgets/footer/footer.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../../shared/utils/my_fonts.dart';
import '../../shared/widgets/my_text.dart';
import 'widgets/checkout_form.dart';
import 'widgets/checkout_summary.dart';

class CheckoutPage extends GetView<CheckoutController> {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: ListView(
        children: [
          Padding(
            padding: .all(40),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                MyText(
                  text: "CHECKOUT",
                  fontSize: 42,
                  letterSpacing: 2,
                  fontFamily: MyFonts.bebasNeue,
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: .start,
                  spacing: 40,
                  children: [CheckoutForm(), CheckoutSummary()],
                ),
              ],
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}
