import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/modules/order/cart/cart_controller.dart';
import 'package:nocvla/shared/utils/my_colors.dart';
import 'package:nocvla/shared/utils/my_fonts.dart';
import 'package:nocvla/shared/utils/my_parsing_currency.dart';
import 'package:nocvla/shared/widgets/my_button.dart';
import 'package:nocvla/shared/widgets/my_image.dart';
import 'package:nocvla/shared/widgets/my_text.dart';

import '../../../shared/utils/my_images.dart';
import '../../../shared/widgets/my_loading.dart';
import '../../../shared/widgets/my_scaffold.dart';
import '../../../shared/widgets/my_text_form_field.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyScaffold(
          appBar: AppBar(
            title: SizedBox(
              width: 70,
              child: MyImageAssets(assets: MyImages.imgNocvla),
            ),
            centerTitle: true,
          ),
          body: Obx(() {
            if (controller.isLoading.value) return MyLoading();

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemBuilder: (context, index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: MyImage(
                            image: controller.res[index].product["gallery"][0],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: controller.res[index].product["name"],
                                fontSize: 12,
                                fontFamily: MyFonts.libreBaskerville,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: 6),
                              MyText(
                                text:
                                    "${controller.res[index].product["size"]["name"]}-${controller.res[index].product["color"]["name"]}",
                                fontSize: 12,
                                fontFamily: MyFonts.libreBaskerville,
                                fontStyle: FontStyle.italic,
                              ),
                              SizedBox(height: 12),
                              MyText(
                                text: parsingCurrency(
                                  controller.res[index].product["price"],
                                ),
                                fontFamily: MyFonts.libreBaskerville,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: 12),
                              FittedBox(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColors.primary90,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => controller.decreaseQty(
                                          index: index,
                                          res: controller.res[index],
                                        ),
                                        child: Icon(
                                          Icons.remove,
                                          color: MyColors.secondary,
                                        ),
                                      ),
                                      Container(
                                        color: MyColors.primary90,
                                        width: 3,
                                        height: 40,
                                      ),
                                      SizedBox(
                                        width: 40,
                                        child: MyTextFormFieldNoBorder(
                                          controller: controller.txtQty[index],
                                          textColor: MyColors.secondary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          onChanged: (value) {
                                            if (value.isEmpty ||
                                                int.tryParse(value) == null ||
                                                int.parse(value) <= 0) {
                                              controller.txtQty[index].text =
                                                  '1';
                                            }
                                          },
                                        ),
                                      ),
                                      Container(
                                        color: MyColors.primary90,
                                        width: 3,
                                        height: 40,
                                      ),
                                      GestureDetector(
                                        onTap: () => controller.increaseQty(
                                          index: index,
                                          res: controller.res[index],
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: MyColors.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              controller.deleteCart(res: controller.res[index]),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            color: MyColors.secondary,
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) =>
                        Divider(height: 36, thickness: 0.1),
                    itemCount: controller.res.length,
                  ),
                ),
                MyButton(
                  borderRadius: 0,
                  height: 50,
                  text:
                      "CHECKOUT • ${parsingCurrency(controller.totalPrice.value)}",
                  textColor: MyColors.secondary,
                  color: MyColors.red,
                  onTap: () => controller.checkout(),
                ),
              ],
            );
          }),
        ),
        Obx(
          () => Visibility(
            visible: controller.isLoadingAction.value,
            child: const MyLoading(isStack: true),
          ),
        ),
      ],
    );
  }
}
