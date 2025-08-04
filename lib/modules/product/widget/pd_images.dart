import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/my_image.dart';
import '../product_detail_controller.dart';

class PDImages extends GetView<ProductDetailController> {
  const PDImages({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1 / 1.2,
          child: Obx(
            () => MyImage(
              image:
                  controller.res[0].gallery[controller.selectedGallery.value],
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        SizedBox(height: 6),
        SizedBox(
          height: 100,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => controller.selectImage(index: index),
              child: AspectRatio(
                aspectRatio: 1,
                child: MyImage(image: controller.res[0].gallery[index]),
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(width: 6),
            itemCount: controller.res[0].gallery.length,
          ),
        ),
      ],
    );
  }
}
