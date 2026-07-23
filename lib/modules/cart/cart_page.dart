import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nocvla_web/modules/cart/cart_controller.dart';
import 'package:nocvla_web/modules/cart/widgets/cart_products.dart';
import 'package:nocvla_web/modules/cart/widgets/cart_summary.dart';
import 'package:nocvla_web/modules/cart/widgets/cart_voucher.dart';
import 'package:nocvla_web/modules/main_layout/widgets/footer/footer.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../../shared/utils/my_fonts.dart';
import '../../shared/widgets/my_text.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: ListView(
        children: [
          Padding(
            padding: .all(40),
            child: Column(
              children: [
                MyText(
                  text: "YOUR CART",
                  fontSize: 42,
                  letterSpacing: 2,
                  fontFamily: MyFonts.bebasNeue,
                ),
                SizedBox(height: 40),
                CartProducts(),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: .start,
                  spacing: 40,
                  children: [CartVoucher(), CartSummary()],
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
