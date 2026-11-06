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
        Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: MyColors.line2)),
          ),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              for (final items in controller.resItems) item(controller, items),
            ],
          ),
        ),
        SizedBox(height: 28),
        GestureDetector(
          behavior: .opaque,
          onTap: controller.continueShopping,
          child: Container(
            padding: .only(bottom: 5),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: MyColors.swatchBorder)),
            ),
            child: MyText(
              text: "LANJUT BELANJA",
              fontFamily: MyFonts.archivoNarrow,
              fontSize: 13,
              fontWeight: .w700,
              letterSpacing: 13 * 0.15,
            ),
          ),
        ),
      ],
    );
  }

  Widget item(CartController controller, CartItemModel items) {
    return Container(
      padding: .symmetric(vertical: 24),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: MyColors.line2)),
      ),
      child: Row(
        crossAxisAlignment: .start,
        spacing: 20,
        children: [
          SizedBox(width: 120, height: 150, child: MyImage(items.imageUrl)),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                MyText(
                  text: "${items.name}",
                  fontSize: 15.5,
                  fontWeight: .w600,
                ),
                SizedBox(height: 7),
                MyText(
                  text: "${"${items.color}".capitalize} · Ukuran ${items.size}",
                  fontSize: 13.5,
                  color: MyColors.white2,
                ),
                SizedBox(height: 4),
                MyText(
                  text: "${parsingCurrency(items.price)} / pcs",
                  fontSize: 13.5,
                  color: MyColors.white2,
                ),
                SizedBox(height: 8),
                GestureDetector(
                  behavior: .opaque,
                  onTap: () =>
                      controller.removeItem(items.productId, items.size),
                  child: MyText(
                    text: "Hapus",
                    fontSize: 12.5,
                    color: MyColors.white2,
                    decoration: .underline,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: .end,
            spacing: 16,
            children: [qty(controller, items), total(items)],
          ),
        ],
      ),
    );
  }

  Widget qty(CartController controller, CartItemModel items) {
    return Container(
      width: 126,
      height: 46,
      decoration: BoxDecoration(border: .all(color: MyColors.line2)),
      child: Row(
        children: [
          qtyButton(Icons.remove, () => controller.decrease(items.qty)),
          Expanded(
            child: Obx(
              () => MyText(
                text: "${items.qty.value}",
                fontSize: 14,
                textAlign: .center,
              ),
            ),
          ),
          qtyButton(Icons.add, () => controller.increase(items)),
        ],
      ),
    );
  }

  Widget qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      behavior: .opaque,
      onTap: onTap,
      child: SizedBox(
        width: 42,
        height: 46,
        child: Icon(icon, color: MyColors.white, size: 14),
      ),
    );
  }

  Widget total(CartItemModel items) {
    return Obx(
      () => MyText(
        text: parsingCurrency((items.price as int) * items.qty.value),
        fontSize: 15,
        fontWeight: .w700,
      ),
    );
  }
}
