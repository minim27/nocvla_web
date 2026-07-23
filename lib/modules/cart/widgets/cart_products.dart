import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/cart/cart_controller.dart';
import 'package:nocvla_web/shared/utils/my_parsing_currency.dart';
import 'package:nocvla_web/shared/widgets/my_divider.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

import '../../../shared/utils/my_colors.dart';
import '../../../shared/widgets/my_text_form_field.dart';

class CartProducts extends StatelessWidget {
  const CartProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Obx(
      () => Column(
        spacing: 16,
        children: [header(), MyDivider(), ...products(controller), MyDivider()],
      ),
    );
  }

  Iterable<Widget> products(CartController controller) {
    return .generate(controller.resItems.length, (index) {
      final items = controller.resItems[index];

      final total = items.price * items.qty.value;

      return Row(
        spacing: 12,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              spacing: 12,
              children: [
                Container(
                  color: MyColors.black2,
                  width: 80,
                  height: 80,
                  child: MyImage(items.imageUrl, fit: .cover),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      MyText(
                        text: "${items.name} - ${items.color}",
                        fontSize: 16,
                        fontWeight: .w600,
                      ),
                      MyText(
                        text: "SIZE ${items.size}",
                        fontSize: 16,
                        color: MyColors.white.withValues(alpha: 0.6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: MyText(
              text: parsingCurrency(items.price),
              fontSize: 16,
              textAlign: .center,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: .center,
              children: [
                GestureDetector(
                  behavior: .opaque,
                  onTap: () => controller.decrease(items.qty),
                  child: Container(
                    alignment: .center,
                    width: 40,
                    height: 45,
                    decoration: BoxDecoration(
                      border: .all(
                        color: MyColors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Icon(
                      Icons.remove,
                      color: MyColors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                Container(
                  alignment: .center,
                  width: 50,
                  height: 45,
                  decoration: BoxDecoration(
                    border: .all(color: MyColors.white.withValues(alpha: 0.1)),
                  ),
                  child: Obx(
                    () => MyTextFormFieldNoBorder(
                      controller: TextEditingController(
                        text: items.qty.value.toString(),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: .opaque,
                  onTap: () => controller.increase(items.qty),
                  child: Container(
                    alignment: .center,
                    width: 40,
                    height: 45,
                    decoration: BoxDecoration(
                      border: .all(
                        color: MyColors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: MyColors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: MyText(
              text: parsingCurrency(total),
              fontSize: 16,
              textAlign: .center,
            ),
          ),
          SizedBox(
            width: 80,
            child: GestureDetector(
              behavior: .opaque,
              onTap: () => controller.removeItem(items.productId, items.size),
              child: Icon(Icons.delete_forever_outlined, color: MyColors.white),
            ),
          ),
        ],
      );
    });
  }

  Row header() {
    return Row(
      spacing: 12,
      children: [
        Expanded(
          flex: 3,
          child: MyText(text: "PRODUCT", fontSize: 16, color: MyColors.white2),
        ),
        Expanded(
          child: MyText(
            text: "PRICE",
            textAlign: .center,
            fontSize: 16,
            color: MyColors.white2,
          ),
        ),
        Expanded(
          child: MyText(
            text: "QTY",
            textAlign: .center,
            fontSize: 16,
            color: MyColors.white2,
          ),
        ),
        Expanded(
          flex: 2,
          child: MyText(
            text: "SUBTOTAL",
            textAlign: .center,
            fontSize: 16,
            color: MyColors.white2,
          ),
        ),
        SizedBox(width: 80),
      ],
    );
  }
}
