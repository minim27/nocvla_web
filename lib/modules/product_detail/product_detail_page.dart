import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nocvla_web/modules/product_detail/product_detail_controller.dart';
import 'package:nocvla_web/modules/product_detail/widgets/product_detail_header.dart';
import 'package:nocvla_web/modules/product_detail/widgets/product_detail_payment.dart';
import 'package:nocvla_web/shared/widgets/my_loading.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../main_layout/widgets/footer/footer.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Obx(() {
        if (controller.isLoading.value || controller.res.isEmpty) {
          return MyLoading();
        }

        return ListView(
          children: [ProductDetailHeader(), ProductDetailPayment(), Footer()],
        );
      }),
    );
  }
}
