import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

import '../../shared/utils/my_fonts.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/my_empty_state.dart';
import '../../shared/widgets/my_text.dart';
import '../main_layout/widgets/footer/m_footer.dart';
import '../main_layout/widgets/footer/t_footer.dart';

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
                child: Obx(
                  () => Column(
                    crossAxisAlignment: .start,
                    spacing: 24,
                    children: [
                      MyText(
                        text: "KERANJANG",
                        fontSize: isDesktop ? 64 : 44,
                        fontWeight: .w600,
                        fontFamily: MyFonts.grenzeGotisch,
                      ),
                      if (controller.resItems.isEmpty) ...[
                        MyEmptyState(text: "Keranjang kamu masih kosong."),
                        MyButton(
                          "LIHAT KOLEKSI",
                          onTap: controller.continueShopping,
                        ),
                      ] else if (isDesktop)
                        Row(
                          crossAxisAlignment: .start,
                          spacing: 40,
                          children: [
                            Expanded(flex: 3, child: CartProducts()),
                            Expanded(
                              flex: 2,
                              child: Column(
                                spacing: 16,
                                children: [CartVoucher(), CartSummary()],
                              ),
                            ),
                          ],
                        )
                      else if (isTab)
                        Column(
                          spacing: 24,
                          children: [
                            TCartProducts(),
                            TCartVoucher(),
                            TCartSummary(),
                          ],
                        )
                      else
                        Column(
                          spacing: 24,
                          children: [
                            MCartProducts(),
                            MCartVoucher(),
                            MCartSummary(),
                          ],
                        ),
                    ],
                  ),
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
