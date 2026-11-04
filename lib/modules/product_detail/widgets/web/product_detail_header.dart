import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_icons.dart';
import '../../../../shared/utils/my_parsing_currency.dart';
import '../../../../shared/utils/my_utility.dart';
import '../../../../shared/widgets/my_accordion.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../product_detail_controller.dart';

class ProductDetailHeader extends StatelessWidget {
  const ProductDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();

    return Padding(
      padding: .all(40),
      child: Row(
        crossAxisAlignment: .start,
        spacing: 48,
        children: [
          Expanded(child: gallery(controller)),
          Expanded(child: info(controller)),
        ],
      ),
    );
  }

  Widget gallery(ProductDetailController controller) {
    return Obx(() {
      final images = (controller.res["images"] ?? []) as List;
      final selected = controller.selectedImage.value;

      return Row(
        crossAxisAlignment: .start,
        spacing: 16,
        children: [
          SizedBox(
            width: 80,
            child: Column(
              spacing: 12,
              children: [
                for (var index = 0; index < images.length; index++)
                  thumbnail(controller, images, index),
              ],
            ),
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 4 / 5,
              child: Container(
                color: MyColors.black2,
                child: Stack(
                  fit: .expand,
                  children: [
                    MyImage(
                      images.isEmpty ? null : images[selected],
                      onTap: images.isEmpty ? null : controller.openImageViewer,
                    ),
                    if (images.length > 1) ...[
                      Align(
                        alignment: .centerLeft,
                        child: arrow(
                          Icons.chevron_left,
                          controller.previousImage,
                        ),
                      ),
                      Align(
                        alignment: .centerRight,
                        child: arrow(Icons.chevron_right, controller.nextImage),
                      ),
                    ],
                    if (images.isNotEmpty)
                      Positioned(
                        right: 12,
                        bottom: 12,
                        child: Container(
                          padding: .symmetric(horizontal: 8, vertical: 4),
                          color: MyColors.black,
                          child: MyText(
                            text: "${selected + 1}/${images.length}",
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget thumbnail(ProductDetailController controller, List images, int index) {
    final isSelected = controller.selectedImage.value == index;

    return GestureDetector(
      onTap: () => controller.selectImage(index),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.black2,
            border: .all(color: isSelected ? MyColors.white : MyColors.line),
          ),
          child: MyImage(images[index]),
        ),
      ),
    );
  }

  Widget arrow(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      behavior: .opaque,
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        color: MyColors.black.withValues(alpha: 0.6),
        child: Icon(icon, color: MyColors.white),
      ),
    );
  }

  Widget info(ProductDetailController controller) {
    return Obx(() {
      final items = controller.res;
      final stock = (items["stock"] ?? []) as List;
      final colors = (items["colors"] ?? []) as List;
      final selectedStock = controller.selectedStock.value;

      return Column(
        crossAxisAlignment: .start,
        spacing: 24,
        children: [
          Column(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              MyText(text: "${items["name"]}", color: MyColors.white2),
              MyText(
                text: "${items["color"]}",
                fontFamily: MyFonts.grenzeGotisch,
                fontSize: 44,
                fontWeight: .w600,
                height: 1,
              ),
              MyText(
                text: parsingCurrency(
                  selectedStock?["price"] ?? minPrice(stock),
                ),
                fontSize: 20,
                fontWeight: .w600,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              label("WARNA"),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final color in colors)
                    GestureDetector(
                      onTap: () => controller.selectColor(color["id"]),
                      child: Container(
                        width: 44,
                        height: 44,
                        padding: .all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: .all(
                            color: color["id"] == items["id"]
                                ? MyColors.white
                                : MyColors.line,
                          ),
                        ),
                        child: ClipOval(child: MyImage(color["image_url"])),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              label("UKURAN"),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final item in stock)
                    size(controller, item, selectedStock == item),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              label("QTY"),
              Row(
                children: [
                  qtyButton(Icons.remove, controller.decrease),
                  Container(
                    alignment: .center,
                    width: 56,
                    height: 44,
                    decoration: BoxDecoration(
                      border: .all(color: MyColors.line),
                    ),
                    child: MyText(text: "${controller.qty.value}"),
                  ),
                  qtyButton(Icons.add, controller.increase),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: .stretch,
            spacing: 8,
            children: [
              MyButton("TAMBAH KE KERANJANG", onTap: controller.addToCart),
              MyButton(
                "LANGSUNG ORDER VIA WHATSAPP",
                color: MyColors.red,
                textColor: MyColors.nativeWhite,
                onTap: controller.orderNow,
              ),
              marketplace(
                "BELI DI SHOPEE",
                MyIcons.icShopee,
                items["links"]?["shopee"],
              ),
              marketplace(
                "BELI DI TIKTOK",
                MyIcons.icTikTok2,
                items["links"]?["tiktok"],
              ),
              marketplace(
                "BELI DI TOKOPEDIA",
                MyIcons.icTokped,
                items["links"]?["tokopedia"],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: .stretch,
            children: [
              MyAccordion(
                title: "Material & fitur lengkap",
                child: description(items["description"]),
              ),
              MyAccordion(
                title: "Cara order",
                child: MyText(
                  text:
                      "1. Pilih warna, ukuran, dan jumlah.\n2. Tambah ke keranjang atau langsung order via WhatsApp.\n3. Admin menghitung ongkir dan mengirim detail pembayaran lewat WhatsApp.",
                  color: MyColors.white2,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget label(String text) {
    return MyText(
      text: text,
      fontFamily: MyFonts.archivoNarrow,
      fontSize: 13,
      fontWeight: .w600,
      letterSpacing: 13 * 0.12,
      color: MyColors.white2,
    );
  }

  Widget size(
    ProductDetailController controller,
    Map<String, dynamic> item,
    bool isSelected,
  ) {
    final qty = item["qty"] as int;
    final isSoldOut = qty <= 0;

    return Column(
      spacing: 4,
      children: [
        GestureDetector(
          onTap: isSoldOut ? null : () => controller.selectStock(item),
          child: Container(
            alignment: .center,
            width: 56,
            height: 44,
            decoration: BoxDecoration(
              color: isSelected ? MyColors.white : null,
              border: .all(color: isSelected ? MyColors.white : MyColors.line),
            ),
            child: MyText(
              text: item["size"],
              fontWeight: .w500,
              decoration: isSoldOut ? .lineThrough : null,
              color: isSelected
                  ? MyColors.black
                  : isSoldOut
                  ? MyColors.white2.withValues(alpha: 0.5)
                  : MyColors.white,
            ),
          ),
        ),
        if (!isSoldOut && qty <= 3)
          MyText(text: "Sisa $qty", fontSize: 11, color: MyColors.orange),
      ],
    );
  }

  Widget qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      behavior: .opaque,
      onTap: onTap,
      child: Container(
        alignment: .center,
        width: 44,
        height: 44,
        decoration: BoxDecoration(border: .all(color: MyColors.line)),
        child: Icon(icon, color: MyColors.white2, size: 18),
      ),
    );
  }

  Widget marketplace(String label, String icon, String? url) {
    if (url == null || url.isEmpty) return SizedBox();

    return GestureDetector(
      behavior: .opaque,
      onTap: () => execUri(url),
      child: Container(
        padding: .symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(border: .all(color: MyColors.line)),
        child: Row(
          spacing: 12,
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: MyImageAssets(icon, fit: .cover),
            ),
            Expanded(
              child: MyText(
                text: label,
                fontFamily: MyFonts.archivoNarrow,
                fontWeight: .w600,
                letterSpacing: 14 * 0.12,
              ),
            ),
            Icon(Icons.chevron_right, color: MyColors.white2, size: 18),
          ],
        ),
      ),
    );
  }

  Widget description(String? description) {
    return DefaultTextStyle(
      style: TextStyle(
        color: MyColors.white2,
        fontSize: 14,
        fontFamily: MyFonts.archivo,
      ),
      child: IgnorePointer(
        child: quill.QuillEditor(
          controller: quill.QuillController(
            document: description == null
                ? quill.Document()
                : quill.Document.fromJson(jsonDecode(description)),
            selection: const TextSelection.collapsed(offset: 0),
            readOnly: true,
          ),
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
    );
  }

  int minPrice(List stock) {
    if (stock.isEmpty) return 0;
    return stock.map((e) => e["price"] as int).reduce((a, b) => a < b ? a : b);
  }
}
