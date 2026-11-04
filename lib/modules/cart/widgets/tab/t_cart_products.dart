import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/cart/cart_item_model.dart';
import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_parsing_currency.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../cart_controller.dart';

class TCartProducts extends StatelessWidget {
  const TCartProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Column(
      crossAxisAlignment: .start,
      children: [
        for (final items in controller.resItems) item(controller, items),
        SizedBox(height: 16),
        GestureDetector(
          behavior: .opaque,
          onTap: controller.continueShopping,
          child: SizedBox(
            height: 44,
            child: Center(
              widthFactor: 1,
              child: MyText(
                text: "← LANJUT BELANJA",
                fontFamily: MyFonts.archivoNarrow,
                fontWeight: .w600,
                letterSpacing: 14 * 0.12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget item(CartController controller, CartItemModel items) {
    return Container(
      padding: .symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: MyColors.line)),
      ),
      child: Row(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          SizedBox(width: 88, height: 88, child: MyImage(items.imageUrl)),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 8,
              children: [
                MyText(text: "${items.name}", fontWeight: .w600),
                MyText(
                  text: "${items.color} / ${items.size}",
                  fontSize: 13,
                  color: MyColors.white2,
                ),
                MyText(text: parsingCurrency(items.price)),
                Row(
                  children: [
                    qtyButton(
                      Icons.remove,
                      () => controller.decrease(items.qty),
                    ),
                    Container(
                      alignment: .center,
                      width: 48,
                      height: 44,
                      decoration: BoxDecoration(
                        border: .all(color: MyColors.line),
                      ),
                      child: Obx(() => MyText(text: "${items.qty.value}")),
                    ),
                    qtyButton(Icons.add, () => controller.increase(items)),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            behavior: .opaque,
            onTap: () => controller.removeItem(items.productId, items.size),
            child: SizedBox(
              width: 44,
              height: 44,
              child: Icon(Icons.close, color: MyColors.white2, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      behavior: .opaque,
      onTap: onTap,
      child: Container(
        alignment: .center,
        width: 44,
        height: 44,
        decoration: BoxDecoration(border: .all(color: MyColors.line)),
        child: Icon(icon, color: MyColors.white2, size: 18),
      ),
    );
  }
}
