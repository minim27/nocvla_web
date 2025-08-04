import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/modules/order/checkout/checkout_controller.dart';
import 'package:nocvla/modules/order/checkout/widget/co_bioaddress.dart';

import '../../../shared/utils/my_images.dart';
import '../../../shared/widgets/my_image.dart';
import '../../../shared/widgets/my_loading.dart';
import '../../../shared/widgets/my_scaffold.dart';
import 'widget/co_paymethod.dart';

class CheckoutPage extends GetView<CheckoutController> {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 900;

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

                if (isWide) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      spacing: 36,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: COBioAddress()),
                        Expanded(flex: 2, child: COPayMethod()),
                      ],
                    ),
                  );
                }

                return ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    COBioAddress(),
                    SizedBox(height: 32),
                    COPayMethod(),
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
      },
    );
  }
}
