import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nocvla_web/modules/cart/cart_controller.dart';
import 'package:nocvla_web/modules/cart/widgets/mobile/m_cart_products.dart';
import 'package:nocvla_web/modules/cart/widgets/mobile/m_cart_summary.dart';
import 'package:nocvla_web/modules/cart/widgets/mobile/m_cart_voucher.dart';
import 'package:nocvla_web/modules/cart/widgets/tab/t_cart_products.dart';
import 'package:nocvla_web/modules/cart/widgets/tab/t_cart_summary.dart';
import 'package:nocvla_web/modules/cart/widgets/tab/t_cart_voucher.dart';
import 'package:nocvla_web/modules/cart/widgets/web/cart_products.dart';
import 'package:nocvla_web/modules/cart/widgets/web/cart_summary.dart';
import 'package:nocvla_web/modules/cart/widgets/web/cart_voucher.dart';
import 'package:nocvla_web/modules/main_layout/widgets/footer/footer.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../main_layout/widgets/footer/m_footer.dart';
import '../main_layout/widgets/footer/t_footer.dart';
import '../../shared/utils/my_fonts.dart';
import '../../shared/widgets/my_text.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

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
                  children: [
                    MyText(
                      text: "YOUR CART",
                      fontSize: 42,
                      letterSpacing: 2,
                      fontFamily: MyFonts.grenzeGotisch,
                    ),
                    SizedBox(height: 40),
                    isDesktop
                        ? CartProducts()
                        : isTab
                        ? TCartProducts()
                        : MCartProducts(),
                    SizedBox(height: 20),
                    isDesktop
                        ? Row(
                            crossAxisAlignment: .start,
                            spacing: 40,
                            children: [CartVoucher(), CartSummary()],
                          )
                        : isTab
                        ? Row(
                            crossAxisAlignment: .start,
                            spacing: 24,
                            children: [TCartVoucher(), TCartSummary()],
                          )
                        : Column(
                            spacing: 24,
                            children: [MCartVoucher(), MCartSummary()],
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
