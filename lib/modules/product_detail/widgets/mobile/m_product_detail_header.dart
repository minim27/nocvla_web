import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import 'package:nocvla_web/modules/product_detail/product_detail_controller.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';
import 'package:nocvla_web/shared/widgets/my_text_form_field.dart';

import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_parsing_currency.dart';

class MProductDetailHeader extends StatelessWidget {
  const MProductDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();
    final items = controller.res;
    final images = items["images"] as List;

    return Padding(
      padding: .all(24),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 16,
        children: [
          AspectRatio(
            aspectRatio: 4 / 5,
            child: Container(
              color: MyColors.black2,
              child: Obx(() {
                final selectedImage = controller.selectedImage.value;
                return MyImage(
                  images.isEmpty ? null : images[selectedImage],
                  onTap: images.isEmpty
                      ? null
                      : () => controller.openImageViewer(),
                );
              }),
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: .horizontal,
              itemCount: images.length,
              separatorBuilder: (context, index) => SizedBox(width: 10),
              itemBuilder: (context, index) {
                final image = images[index];

                return GestureDetector(
                  onTap: () => controller.selectImage(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.black2,
                      border: .all(
                        color: MyColors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    width: 60,
                    height: 60,
                    child: MyImage(image),
                  ),
                );
              },
            ),
          ),
          identity(controller, items),
          size(controller),
          qty(controller),
        ],
      ),
    );
  }

  Widget identity(
    ProductDetailController controller,
    Map<String, dynamic> items,
  ) {
    final description = items["description"];
    final descriptionController = quill.QuillController(
      document: description == null
          ? quill.Document()
          : quill.Document.fromJson(jsonDecode(description)),
      selection: const TextSelection.collapsed(offset: 0),
      readOnly: true,
    );

    return Obx(
      () => Column(
        spacing: 24,
        crossAxisAlignment: .start,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              MyText(text: items["name"], fontSize: 20, fontWeight: .w600),
              MyText(
                text: "- ${items["color"]}",
                fontSize: 24,
                fontWeight: .w600,
              ),
            ],
          ),
          MyText(
            text: parsingCurrency(
              controller.selectedStock.value?["price"] ??
                  minPrice(items["stock"] as List),
            ),
            fontSize: 18,
            fontWeight: .w600,
          ),
          DefaultTextStyle(
            style: TextStyle(
              color: MyColors.white2,
              fontSize: 16,
              fontWeight: .w100,
              fontFamily: MyFonts.stackSansHeadline,
            ),
            child: IgnorePointer(
              child: quill.QuillEditor(
                controller: descriptionController,
                focusNode: FocusNode(),
                scrollController: ScrollController(),
                config: const quill.QuillEditorConfig(
                  scrollable: false,
                  padding: EdgeInsets.zero,
                  autoFocus: false,
                  expands: false,
                  enableInteractiveSelection: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column qty(ProductDetailController controller) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        MyText(
          text: "QTY",
          color: MyColors.white.withValues(alpha: 0.6),
          fontWeight: .w500,
        ),
        Row(
          children: [
            GestureDetector(
              behavior: .opaque,
              onTap: () => controller.decrease(),
              child: Container(
                alignment: .center,
                width: 40,
                height: 45,
                decoration: BoxDecoration(
                  border: .all(color: MyColors.white.withValues(alpha: 0.1)),
                ),
                child: Icon(
                  Icons.remove,
                  color: MyColors.white.withValues(alpha: 0.6),
                ),
              ),
            ),
            Container(
              alignment: .center,
              width: 50,
              height: 45,
              decoration: BoxDecoration(
                border: .all(color: MyColors.white.withValues(alpha: 0.1)),
              ),
              child: Obx(
                () => MyTextFormFieldNoBorder(
                  controller: TextEditingController(
                    text: controller.qty.value.toString(),
                  ),
                ),
              ),
            ),
            GestureDetector(
              behavior: .opaque,
              onTap: () => controller.increase(),
              child: Container(
                alignment: .center,
                width: 40,
                height: 45,
                decoration: BoxDecoration(
                  border: .all(color: MyColors.white.withValues(alpha: 0.1)),
                ),
                child: Icon(
                  Icons.add,
                  color: MyColors.white.withValues(alpha: 0.6),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column size(ProductDetailController controller) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        MyText(
          text: "SIZE",
          color: MyColors.white.withValues(alpha: 0.6),
          fontWeight: .w500,
        ),
        Row(
          spacing: 6,
          children: .generate(controller.res["stock"].length, (index) {
            final items = controller.res["stock"][index];
            final isOutOfStock = items["qty"] <= 0;

            return GestureDetector(
              onTap: isOutOfStock ? null : () => controller.selectStock(items),
              child: Opacity(
                opacity: isOutOfStock ? 0.3 : 1,
                child: Obx(
                  () => Container(
                    alignment: .center,
                    width: 40,
                    height: 45,
                    decoration: BoxDecoration(
                      color: controller.selectedStock.value == items
                          ? MyColors.white
                          : MyColors.white.withValues(alpha: 0),
                      border: .all(
                        color: controller.selectedStock.value == items
                            ? MyColors.white
                            : MyColors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: MyText(
                      text: items["size"],
                      color: controller.selectedStock.value == items
                          ? MyColors.black
                          : MyColors.white.withValues(alpha: 0.6),
                      fontWeight: controller.selectedStock.value == items
                          ? .w500
                          : .w400,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  int minPrice(List stock) {
    if (stock.isEmpty) return 0;
    return stock.map((e) => e["price"] as int).reduce((a, b) => a < b ? a : b);
  }
}
