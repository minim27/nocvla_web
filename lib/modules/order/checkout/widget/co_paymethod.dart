import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/shared/utils/my_colors.dart';
import 'package:nocvla/shared/widgets/my_button.dart';
import 'package:nocvla/shared/widgets/my_image.dart';

import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_parsing_currency.dart';
import '../../../../shared/widgets/my_text.dart';
import '../checkout_controller.dart';

class COPayMethod extends GetView<CheckoutController> {
  const COPayMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: MyImage(
                  image: controller.resProduct[index].product["gallery"][0],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: controller.resProduct[index].product["name"],
                      fontSize: 12,
                      fontFamily: MyFonts.libreBaskerville,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 6),
                    MyText(
                      text:
                          "${controller.resProduct[index].product["size"]["name"]}-${controller.resProduct[index].product["color"]["name"]}",
                      fontSize: 12,
                      fontFamily: MyFonts.libreBaskerville,
                      fontStyle: FontStyle.italic,
                    ),
                    SizedBox(height: 12),
                    MyText(
                      text:
                          "${controller.resProduct[index].qty} x ${parsingCurrency(controller.resProduct[index].product["price"])}",
                      fontFamily: MyFonts.libreBaskerville,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ],
          ),
          separatorBuilder: (context, index) =>
              Divider(height: 36, thickness: 0.2),
          itemCount: controller.resProduct.length,
        ),
        Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: "Sub Total",
              fontSize: 12,
              fontFamily: MyFonts.libreBaskerville,
            ),
            MyText(
              text: parsingCurrency(controller.totalPrice.value),
              fontSize: 12,
              fontFamily: MyFonts.libreBaskerville,
            ),
          ],
        ),
        Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: "Shipping Fee",
              fontSize: 12,
              fontFamily: MyFonts.libreBaskerville,
            ),
            MyText(
              text: "Shipping fee is paid by the customer",
              fontSize: 12,
              fontFamily: MyFonts.libreBaskerville,
            ),
          ],
        ),
        Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: "Admin Fee",
              fontSize: 12,
              fontFamily: MyFonts.libreBaskerville,
            ),
            MyText(
              text: parsingCurrency(0),
              fontFamily: MyFonts.libreBaskerville,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: "Total",
              fontFamily: MyFonts.libreBaskerville,
              fontWeight: FontWeight.w600,
            ),
            MyText(
              text: parsingCurrency(controller.totalPrice.value + 0),
              fontFamily: MyFonts.libreBaskerville,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        Divider(height: 24),
        SizedBox(height: 12),
        MyText(
          text: "Payment Method",
          fontFamily: MyFonts.libreBaskerville,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () =>
                controller.selectPayMet(res: controller.resPayMethod[index]),
            child: Obx(
              () => Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      (controller.selectedPayMet.value ==
                          controller.resPayMethod[index].bankCode)
                      ? MyColors.yellow
                      : MyColors.secondary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  spacing: 12,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 20,
                      child: MyImage(
                        image: controller.resPayMethod[index].image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Flexible(
                      child: MyText(
                        text: controller.resPayMethod[index].name,
                        color: MyColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(height: 16),
          itemCount: controller.resPayMethod.length,
        ),
        SizedBox(height: 32),
        MyButton(text: "CHECKOUT", onTap: () => controller.checkout()),
        // SizedBox(height: 6),
        // MyText(
        //   text: "*Shipping fee is paid by the customer.",
        //   fontSize: 10,
        //   color: MyColors.primary80,
        // ),
      ],
    );
  }
}
