import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/modules/account/my_order/my_order_controller.dart';
import 'package:nocvla/shared/utils/my_colors.dart';
import 'package:nocvla/shared/utils/my_parsing_currency.dart';
import 'package:nocvla/shared/utils/my_utility.dart';
import 'package:nocvla/shared/widgets/my_loading.dart';
import 'package:nocvla/shared/widgets/my_scaffold.dart';
import 'package:nocvla/shared/widgets/my_text.dart';

import '../../../shared/utils/my_fonts.dart';
import '../../../shared/utils/my_images.dart';
import '../../../shared/widgets/my_image.dart';

class MyOrderPage extends GetView<MyOrderController> {
  const MyOrderPage({super.key});

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

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "My Order",
                    fontSize: 24,
                    fontFamily: MyFonts.libreBaskerville,
                  ),
                  SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 24),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () =>
                            controller.openDetail(res: controller.res[index]),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: MyColors.secondary),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: MyColors.secondary,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText(
                                      text: controller.res[index].invoiceNo,
                                      color: MyColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    MyText(
                                      text: formatDate(
                                        val: controller.res[index].date,
                                      ),
                                      color: MyColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Column(
                                  spacing: 8,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyText(text: "Status"),
                                        MyText(
                                          text: controller.res[index].statusName,
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyText(
                                          text: "Total",
                                          fontWeight: FontWeight.w700,
                                        ),
                                        MyText(
                                          text: parsingCurrency(
                                            controller.res[index].totalAmount,
                                          ),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: 24),
                      itemCount: controller.res.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
