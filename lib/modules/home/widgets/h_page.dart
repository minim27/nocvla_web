import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nocvla/modules/home/home_controller.dart';
import 'package:nocvla/shared/utils/my_colors.dart';
import 'package:nocvla/shared/utils/my_input_formatters.dart';
import 'package:nocvla/shared/widgets/my_button.dart';
import 'package:nocvla/shared/widgets/my_image.dart';
import 'package:nocvla/shared/widgets/my_loading.dart';
import 'package:nocvla/shared/widgets/my_text_form_field.dart';

import '../../../shared/widgets/my_content.dart';
import '../../../shared/widgets/my_text.dart';

class HPage extends GetView<HomeController> {
  const HPage({super.key});

  @override
  Widget build(BuildContext context) {
    return (controller.isLoading.value)
        ? MyLoading()
        : ListView(
            padding: EdgeInsets.symmetric(vertical: 24),
            children: [
              HPageNotifyForm(controller: controller),
              HPageProd1(controller: controller),
              HPageProd2(controller: controller),
              HPageProd3(controller: controller),
            ],
          );
  }
}

class HPageProd3 extends StatelessWidget {
  const HPageProd3({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (controller.res[0].product3["image"] == null)
            ? SizedBox()
            : Column(
                children: [
                  SizedBox(height: 52),
                  SizedBox(
                    width: Get.size.width,
                    height: Get.size.height,
                    child: MyImage(
                      image: controller.res[0].product3["image"]["src"],
                      alignment: Alignment.topCenter,
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
            childAspectRatio: 1 / 1.2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => MyProduct(
            image: controller.res[0].product3["products"][index]["image"],
            onTap: () => controller.openDetail(
              slug: controller.res[0].product3["products"][index]["slug"],
            ),
          ),
          itemCount: controller.res[0].product3["products"].length,
        ),
      ],
    );
  }
}

class HPageProd2 extends StatelessWidget {
  const HPageProd2({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (controller.res[0].product2["image"] == null)
            ? SizedBox()
            : Column(
                children: [
                  SizedBox(height: 52),
                  SizedBox(
                    width: Get.size.width,
                    height: Get.size.height,
                    child: MyImage(
                      image: controller.res[0].product2["image"]["src"],
                      alignment: Alignment.topCenter,
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
            childAspectRatio: 1 / 1.2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => MyProduct(
            image: controller.res[0].product2["products"][index]["image"],
            onTap: () => controller.openDetail(
              slug: controller.res[0].product2["products"][index]["slug"],
            ),
          ),
          itemCount: controller.res[0].product2["products"].length,
        ),
      ],
    );
  }
}

class HPageProd1 extends StatelessWidget {
  const HPageProd1({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 46),
        (controller.res[0].product1["image"] == null)
            ? SizedBox()
            : Column(
                children: [
                  SizedBox(
                    width: Get.size.width,
                    height: Get.size.height,
                    child: MyImage(
                      image: controller.res[0].product1["image"]["src"],
                      alignment: Alignment.topCenter,
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
            childAspectRatio: 1 / 1.2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => MyProduct(
            image: controller.res[0].product1["products"][index]["image"],
            onTap: () => controller.openDetail(
              slug: controller.res[0].product1["products"][index]["slug"],
            ),
          ),
          itemCount: controller.res[0].product1["products"].length,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
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
              padding: EdgeInsets.only(top: 11, left: 12),
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
                myTextSpan(text: " & ", fontSize: 8, color: MyColors.primary80),
                myTextSpan(
                  text: "Terms & Condition",
                  fontSize: 8,
                  color: MyColors.primary80,
                  decoration: TextDecoration.underline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
