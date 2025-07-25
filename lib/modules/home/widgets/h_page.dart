import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nocvla/modules/home/home_controller.dart';
import 'package:nocvla/shared/utils/my_colors.dart';
import 'package:nocvla/shared/utils/my_fonts.dart';
import 'package:nocvla/shared/utils/my_input_formatters.dart';
import 'package:nocvla/shared/widgets/my_button.dart';
import 'package:nocvla/shared/widgets/my_image.dart';
import 'package:nocvla/shared/widgets/my_loading.dart';
import 'package:nocvla/shared/widgets/my_text_form_field.dart';

import '../../../shared/utils/my_utility.dart';
import '../../../shared/widgets/my_content.dart';
import '../../../shared/widgets/my_text.dart';

class HPage extends GetView<HomeController> {
  const HPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.isLoading.value)
          ? MyLoading()
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 24),
              children: [
                HPageNotifyForm(controller: controller),
                SizedBox(height: 32),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      HPageProd(controller: controller, index: index),
                  separatorBuilder: (context, index) => SizedBox(height: 32),
                  itemCount: controller.resContent.length,
                ),
              ],
            ),
    );
  }
}

class HPageProd extends StatelessWidget {
  const HPageProd({super.key, required this.controller, required this.index});

  final HomeController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (controller.resContent[index].gallery.isEmpty)
            ? SizedBox()
            : Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: Get.size.width,
                    height: Get.size.height,
                    child: MyImage(
                      image: controller.resContent[index].gallery[0],
                    ),
                  ),
                  Container(
                    color: MyColors.primary.withValues(alpha: 0.4),
                    width: Get.size.width,
                    height: Get.size.height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        MyText(
                          text: controller.resContent[index].title,
                          fontFamily: MyFonts.libreBaskerville,
                          textAlign: TextAlign.center,
                          fontSize: 18,
                        ),
                        Visibility(
                          visible:
                              controller.resContent[index].description != "",
                          child: MyText(
                            text: controller.resContent[index].description,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        SizedBox(height: 52),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.7,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, indexx) => MyProduct(
            image: controller.resContent[index].products[indexx]["gallery"][0],
            text: controller.resContent[index].products[indexx]["name"],
            price: controller.resContent[index].products[indexx]["price"],
            stock: controller.resContent[index].products[indexx]["stock"],
            isDisc:
                controller.resContent[index].products[indexx]["is_discount"],
            onTap: () => controller.openDetail(
              slug: controller.resContent[index].products[indexx]["slug"],
            ),
          ),
          itemCount: controller.resContent[index].products.length,
        ),
      ],
    );
  }
}

class HPageNotifyForm extends StatelessWidget {
  const HPageNotifyForm({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: DateTime.now().isBefore(
        DateTime.parse(controller.resAD[0].availableDate).toLocal(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextFormField(
              hintText: "Phone Number (For Get Notification)",
              inputFormatters: [
                NoLeadingZeroTextInputFormatter(),
                FilteringTextInputFormatter.digitsOnly,
                No62TextInputFormatter(),
              ],
              textInputAction: TextInputAction.next,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(top: 15, left: 12),
                child: MyText(text: "+62", color: MyColors.primary),
              ),
            ),
            SizedBox(height: 32),
            MyButton(text: "Notify Me", onTap: () => controller.notifyMe()),
            SizedBox(height: 12),
            RichText(
              text: TextSpan(
                children: [
                  myTextSpan(
                    text:
                        "By signing up via text you agree to receive recurring automated marketing messages and shopping cart reminders at the phone number provided. Consent is not a condition of purchase. Reply STOP to unsubscribe. HELP for help. Msg frequency varies. Msg & Data rates may apply. View ",
                    fontSize: 8,
                    color: MyColors.primary80,
                  ),
                  myTextSpan(
                    text: "Privacy Policy",
                    fontSize: 8,
                    color: MyColors.primary80,
                    decoration: TextDecoration.underline,
                  ),
                  myTextSpan(
                    text: " & ",
                    fontSize: 8,
                    color: MyColors.primary80,
                  ),
                  myTextSpan(
                    text: "Terms & Condition",
                    fontSize: 8,
                    color: MyColors.primary80,
                    decoration: TextDecoration.underline,
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Obx(
                          () => MyText(
                            text: twoDigits(controller.remaining.value.inDays),
                            fontSize: 40,
                            fontFamily: MyFonts.libreBaskerville,
                          ),
                        ),
                        MyText(
                          text: "Days",
                          fontFamily: MyFonts.libreBaskerville,
                        ),
                      ],
                    ),
                    MyText(
                      text: " : ",
                      fontSize: 35,
                      fontFamily: MyFonts.libreBaskerville,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Obx(
                          () => MyText(
                            text: twoDigits(
                              controller.remaining.value.inHours.remainder(24),
                            ),
                            fontSize: 40,
                            fontFamily: MyFonts.libreBaskerville,
                          ),
                        ),
                        MyText(
                          text: "Hours",
                          fontFamily: MyFonts.libreBaskerville,
                        ),
                      ],
                    ),
                    MyText(
                      text: " : ",
                      fontSize: 35,
                      fontFamily: MyFonts.libreBaskerville,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Obx(
                          () => MyText(
                            text: twoDigits(
                              controller.remaining.value.inMinutes.remainder(
                                60,
                              ),
                            ),
                            fontSize: 40,
                            fontFamily: MyFonts.libreBaskerville,
                          ),
                        ),
                        MyText(
                          text: "Minutes",
                          fontFamily: MyFonts.libreBaskerville,
                        ),
                      ],
                    ),
                    MyText(
                      text: " : ",
                      fontSize: 35,
                      fontFamily: MyFonts.libreBaskerville,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Obx(
                      () => MyText(
                        text: twoDigits(
                          controller.remaining.value.inSeconds.remainder(60),
                        ),
                        fontSize: 40,
                        fontFamily: MyFonts.libreBaskerville,
                      ),
                    ),
                    MyText(
                      text: "Seconds",
                      fontFamily: MyFonts.libreBaskerville,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
