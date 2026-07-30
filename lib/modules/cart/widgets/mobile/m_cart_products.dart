import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/cart/cart_controller.dart';
import 'package:nocvla_web/shared/utils/my_parsing_currency.dart';
import 'package:nocvla_web/shared/widgets/my_divider.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/widgets/my_text_form_field.dart';

class MCartProducts extends StatelessWidget {
  const MCartProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Obx(
      () => Column(spacing: 16, children: [...products(controller)]),
    );
  }

  Iterable<Widget> products(CartController controller) {
    return .generate(controller.resItems.length, (index) {
      final items = controller.resItems[index];

      final total = items.price * items.qty.value;

      return Column(
        spacing: 12,
        children: [
          Row(
            crossAxisAlignment: .start,
            spacing: 12,
            children: [
              Container(
                color: MyColors.black2,
                width: 64,
                height: 64,
                child: MyImage(items.imageUrl, fit: .cover),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    MyText(text: items.name, fontSize: 16, fontWeight: .w600),
                    MyText(
                      text: "${items.size} / ${items.color}",
                      fontStyle: .italic,
                      color: MyColors.white.withValues(alpha: 0.6),
                    ),
                    SizedBox(height: 4),
                    MyText(text: parsingCurrency(items.price), fontSize: 14),
                  ],
                ),
              ),
              GestureDetector(
                behavior: .opaque,
                onTap: () => controller.removeItem(items.productId, items.size),
                child: Icon(Icons.delete_forever_outlined, color: MyColors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    behavior: .opaque,
                    onTap: () => controller.decrease(items.qty),
                    child: Container(
                      alignment: .center,
                      width: 36,
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
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                      border: .all(
                        color: MyColors.white.withValues(alpha: 0.1),
                      ),
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
                      width: 36,
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
              MyText(
                text: "SUBTOTAL: ${parsingCurrency(total)}",
                fontSize: 14,
                fontWeight: .w600,
              ),
            ],
          ),
          MyDivider(),
        ],
      );
    });
  }
}
