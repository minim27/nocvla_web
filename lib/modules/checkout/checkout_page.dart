import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nocvla_web/modules/checkout/checkout_controller.dart';
import 'package:nocvla_web/modules/main_layout/widgets/footer/footer.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../../shared/utils/my_fonts.dart';
import '../../shared/widgets/my_text.dart';
import '../main_layout/widgets/footer/m_footer.dart';
import '../main_layout/widgets/footer/t_footer.dart';
import 'widgets/mobile/m_checkout_form.dart';
import 'widgets/mobile/m_checkout_summary.dart';
import 'widgets/tab/t_checkout_form.dart';
import 'widgets/tab/t_checkout_summary.dart';
import 'widgets/web/checkout_form.dart';
import 'widgets/web/checkout_summary.dart';

class CheckoutPage extends GetView<CheckoutController> {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: LayoutBuilder(
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
                      text: "CHECKOUT",
                      fontSize: 42,
                      letterSpacing: 2,
                      fontFamily: MyFonts.bebasNeue,
                    ),
                    SizedBox(height: 20),
                    isDesktop
                        ? Row(
                            crossAxisAlignment: .start,
                            spacing: 40,
                            children: [CheckoutForm(), CheckoutSummary()],
                          )
                        : isTab
                        ? Row(
                            crossAxisAlignment: .start,
                            spacing: 24,
                            children: [TCheckoutForm(), TCheckoutSummary()],
                          )
                        : Column(
                            spacing: 24,
                            children: [MCheckoutForm(), MCheckoutSummary()],
                          ),
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
    );
  }
}
