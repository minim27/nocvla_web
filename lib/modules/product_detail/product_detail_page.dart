import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nocvla_web/modules/product_detail/product_detail_controller.dart';
import 'package:nocvla_web/modules/product_detail/widgets/mobile/m_product_detail_header.dart';
import 'package:nocvla_web/modules/product_detail/widgets/mobile/m_product_detail_payment.dart';
import 'package:nocvla_web/modules/product_detail/widgets/tab/t_product_detail_header.dart';
import 'package:nocvla_web/modules/product_detail/widgets/tab/t_product_detail_payment.dart';
import 'package:nocvla_web/modules/product_detail/widgets/web/product_detail_header.dart';
import 'package:nocvla_web/modules/product_detail/widgets/web/product_detail_payment.dart';
import 'package:nocvla_web/shared/widgets/my_loading.dart';
import 'package:nocvla_web/shared/widgets/my_scaffold.dart';

import '../main_layout/widgets/footer/footer.dart';
import '../main_layout/widgets/footer/m_footer.dart';
import '../main_layout/widgets/footer/t_footer.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Obx(() {
        if (controller.isLoading.value || controller.res.isEmpty) {
          return MyLoading();
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 1280;
            final isTab = constraints.maxWidth >= 768;

            return ListView(
              children: isDesktop
                  ? [ProductDetailHeader(), ProductDetailPayment(), Footer()]
                  : isTab
                  ? [
                      TProductDetailHeader(),
                      TProductDetailPayment(),
                      TFooter(),
                    ]
                  : [
                      MProductDetailHeader(),
                      MProductDetailPayment(),
                      MFooter(),
                    ],
            );
          },
        );
      }),
    );
  }
}
