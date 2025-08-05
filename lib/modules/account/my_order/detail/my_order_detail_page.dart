import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/shared/utils/my_colors.dart';
import 'package:nocvla/shared/utils/my_utility.dart';
import 'package:nocvla/shared/widgets/my_loading.dart';
import 'package:nocvla/shared/widgets/my_scaffold.dart';
import 'package:nocvla/shared/widgets/my_text.dart';

import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_images.dart';
import '../../../../shared/widgets/my_image.dart';
import 'my_order_detail_controller.dart';
import 'widget/mod_orderdetails.dart';
import 'widget/mod_shipdetail.dart';

class MyOrderDetailPage extends GetView<MyOrderDetailController> {
  const MyOrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 70,
          child: MyImageAssets(assets: MyImages.imgNocvla),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) return MyLoading();

        return ListView(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          children: [
            MyText(
              text:
                  "Order ${controller.res[0].invoiceNo} was placed on ${formatDate(val: controller.res[0].date)} and is currently ${controller.res[0].statusName}.",
            ),
            SizedBox(height: 24),
            MODOrderDetails(),
            SizedBox(height: 36),
            MODShipDetail(),
            SizedBox(height: 36),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: "Order Address",
                  fontSize: 24,
                  fontFamily: MyFonts.libreBaskerville,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 16),
                Container(
                  width: Get.size.width,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.secondary),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      MyText(
                        text: controller.res[0].user["name"],
                        fontWeight: FontWeight.w600,
                      ),
                      MyText(
                        text: controller.res[0].user["phone_number"],
                        fontWeight: FontWeight.w600,
                      ),
                      MyText(
                        text: controller.res[0].user["email"],
                        fontWeight: FontWeight.w600,
                      ),
                      MyText(
                        text: controller.res[0].address["address"],
                        fontWeight: FontWeight.w600,
                      ),
                      MyText(
                        text: controller.res[0].address["city"],
                        fontWeight: FontWeight.w600,
                      ),
                      MyText(
                        text: controller.res[0].address["district"],
                        fontWeight: FontWeight.w600,
                      ),
                      MyText(
                        text: controller.res[0].address["village"],
                        fontWeight: FontWeight.w600,
                      ),
                      MyText(
                        text: controller.res[0].address["postal_code"],
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
