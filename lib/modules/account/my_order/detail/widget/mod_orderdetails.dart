import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/utils/my_fonts.dart';
import '../../../../../shared/utils/my_parsing_currency.dart';
import '../../../../../shared/widgets/my_image.dart';
import '../../../../../shared/widgets/my_text.dart';
import '../my_order_detail_controller.dart';

class MODOrderDetails extends GetView<MyOrderDetailController> {
  const MODOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: "Order Details",
          fontSize: 24,
          fontFamily: MyFonts.libreBaskerville,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 16),
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
                  image: controller.res[0].items[index]["product"]["image"],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: controller.res[0].items[index]["product"]["name"],
                      fontSize: 12,
                      fontFamily: MyFonts.libreBaskerville,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 6),
                    MyText(
                      text:
                          "${controller.res[0].items[index]["size"]["name"]}-${controller.res[0].items[index]["color"]["name"]}",
                      fontSize: 12,
                      fontFamily: MyFonts.libreBaskerville,
                      fontStyle: FontStyle.italic,
                    ),
                    SizedBox(height: 12),
                    MyText(
                      text:
                          "${controller.res[0].items[index]["qty"]} x ${parsingCurrency(controller.res[0].items[index]["price"])}",
                      fontFamily: MyFonts.libreBaskerville,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ],
          ),
          separatorBuilder: (context, index) =>
              Divider(height: 36, thickness: 0.1),
          itemCount: controller.res[0].items.length,
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
              text: parsingCurrency(controller.res[0].subTotal),
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
              text: (controller.res[0].shipping["fee"] == 0)
                  ? "Shipping fee is paid by the customer"
                  : parsingCurrency(controller.res[0].shipping["fee"]),
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
              text: parsingCurrency((controller.res[0].adminFee)),
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
              text: "Total",
              fontFamily: MyFonts.libreBaskerville,
              fontWeight: FontWeight.w600,
            ),
            MyText(
              text: parsingCurrency(controller.res[0].totalAmount),
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
              text: "Payment Method",
              fontFamily: MyFonts.libreBaskerville,
              fontWeight: FontWeight.w600,
            ),
            MyText(
              text: controller.res[0].payment["payment_method_code"],
              fontFamily: MyFonts.libreBaskerville,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ],
    );
  }
}
