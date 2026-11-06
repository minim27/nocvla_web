import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/cart/cart_controller.dart';
import 'package:nocvla_web/modules/cart/widgets/mobile/m_cart_empty.dart';
import 'package:nocvla_web/modules/cart/widgets/mobile/m_cart_products.dart';
import 'package:nocvla_web/modules/cart/widgets/mobile/m_cart_summary.dart';
import 'package:nocvla_web/modules/cart/widgets/tab/t_cart_empty.dart';
import 'package:nocvla_web/modules/cart/widgets/tab/t_cart_products.dart';
import 'package:nocvla_web/modules/cart/widgets/tab/t_cart_summary.dart';
import 'package:nocvla_web/modules/cart/widgets/web/cart_empty.dart';
import 'package:nocvla_web/modules/cart/widgets/web/cart_products.dart';
import 'package:nocvla_web/modules/cart/widgets/web/cart_summary.dart';
import 'package:nocvla_web/modules/main_layout/widgets/footer/footer.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../../shared/utils/my_colors.dart';
import '../../shared/utils/my_fonts.dart';
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
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1240 + 48 * 2),
                  child: Padding(
                    padding: isDesktop
                        ? .fromLTRB(48, 48, 48, 112)
                        : isTab
                        ? .fromLTRB(40, 40, 40, 64)
                        : .fromLTRB(24, 40, 24, 64),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: .stretch,
                        spacing: isDesktop ? 28 : 24,
                        children: [
                          Row(
                            crossAxisAlignment: .end,
                            spacing: 16,
                            children: [
                              Expanded(
                                child: MyText(
                                  text: "Keranjang",
                                  fontSize: isDesktop
                                      ? 70
                                      : isTab
                                      ? 56
                                      : 44,
                                  fontWeight: .w700,
                                  fontFamily: MyFonts.grenzeGotisch,
                                  height: 1.05,
                                ),
                              ),
                              Padding(
                                padding: .only(bottom: isDesktop ? 1 : 4),
                                child: MyText(
                                  text:
                                      "${controller.resItems.length} produk · ${controller.totalQty} pcs",
                                  fontSize: 14.4,
                                  color: MyColors.white2,
                                ),
                              ),
                            ],
                          ),
                          if (controller.resItems.isEmpty)
                            isDesktop
                                ? CartEmpty()
                                : isTab
                                ? TCartEmpty()
                                : MCartEmpty()
                          else if (isDesktop)
                            Row(
                              crossAxisAlignment: .start,
                              spacing: 40,
                              children: [
                                Expanded(child: CartProducts()),
                                SizedBox(width: 439, child: CartSummary()),
                              ],
                            )
                          else if (isTab)
                            Column(
                              crossAxisAlignment: .stretch,
                              spacing: 40,
                              children: [TCartProducts(), TCartSummary()],
                            )
                          else
                            Column(
                              crossAxisAlignment: .stretch,
                              spacing: 32,
                              children: [MCartProducts(), MCartSummary()],
                            ),
                        ],
                      ),
                    ),
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
