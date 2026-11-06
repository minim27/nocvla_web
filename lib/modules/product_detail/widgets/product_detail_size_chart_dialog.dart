import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/utils/my_colors.dart';
import '../../../shared/widgets/my_image.dart';
import '../product_detail_controller.dart';

class ProductDetailSizeChartDialog extends StatelessWidget {
  const ProductDetailSizeChartDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();

    return Dialog(
      backgroundColor: MyColors.black3,
      shape: const RoundedRectangleBorder(),
      insetPadding: .all(24),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 720, maxHeight: 900),
        child: Stack(
          children: [
            Padding(
              padding: .all(16),
              child: MyImage(controller.res["sizeChart"], fit: .contain),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                onPressed: Get.back,
                icon: Icon(Icons.close, color: MyColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
