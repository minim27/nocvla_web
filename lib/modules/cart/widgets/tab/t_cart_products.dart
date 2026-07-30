import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/cart/cart_controller.dart';
import 'package:nocvla_web/shared/utils/my_parsing_currency.dart';
import 'package:nocvla_web/shared/widgets/my_divider.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/widgets/my_text_form_field.dart';

class TCartProducts extends StatelessWidget {
  const TCartProducts({super.key});

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
        spacing: 8,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              spacing: 8,
              children: [
                Container(
                  color: MyColors.black2,
                  width: 56,
                  height: 56,
                  child: MyImage(items.imageUrl, fit: .cover),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      MyText(text: items.name, fontSize: 14, fontWeight: .w600),
                      MyText(
                        text: "${items.size} / ${items.color}",
                        fontSize: 12,
                        fontStyle: .italic,
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
              fontSize: 14,
              textAlign: .center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: .center,
              children: [
                GestureDetector(
                  behavior: .opaque,
                  onTap: () => controller.decrease(items.qty),
                  child: Container(
                    alignment: .center,
                    width: 32,
                    height: 40,
                    decoration: BoxDecoration(
                      border: .all(
                        color: MyColors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Icon(
                      Icons.remove,
                      size: 16,
                      color: MyColors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                Container(
                  alignment: .center,
                  width: 40,
                  height: 40,
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
                    width: 32,
                    height: 40,
                    decoration: BoxDecoration(
                      border: .all(
                        color: MyColors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 16,
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
              fontSize: 14,
              textAlign: .center,
            ),
          ),
          SizedBox(
            width: 40,
            child: GestureDetector(
              behavior: .opaque,
              onTap: () => controller.removeItem(items.productId, items.size),
              child: Icon(
                Icons.delete_forever_outlined,
                size: 20,
                color: MyColors.white,
              ),
            ),
          ),
        ],
      );
    });
  }

  Row header() {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          flex: 3,
          child: MyText(text: "PRODUCT", fontSize: 14, color: MyColors.white2),
        ),
        Expanded(
          child: MyText(
            text: "PRICE",
            textAlign: .center,
            fontSize: 14,
            color: MyColors.white2,
          ),
        ),
        Expanded(
          flex: 2,
          child: MyText(
            text: "QTY",
            textAlign: .center,
            fontSize: 14,
            color: MyColors.white2,
          ),
        ),
        Expanded(
          flex: 2,
          child: MyText(
            text: "SUBTOTAL",
            textAlign: .center,
            fontSize: 14,
            color: MyColors.white2,
          ),
        ),
        SizedBox(width: 40),
      ],
    );
  }
}
