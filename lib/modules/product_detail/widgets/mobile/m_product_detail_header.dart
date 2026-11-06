import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_parsing_currency.dart';
import '../../../../shared/utils/my_utility.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../product_detail_controller.dart';

class MProductDetailHeader extends StatelessWidget {
  const MProductDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();

    return Padding(
      padding: .fromLTRB(24, 20, 24, 0),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          breadcrumb(controller),
          SizedBox(height: 24),
          Column(
            crossAxisAlignment: .stretch,
            spacing: 32,
            children: [gallery(controller), info(controller)],
          ),
        ],
      ),
    );
  }

  Widget breadcrumb(ProductDetailController controller) {
    final items = controller.res;

    return Wrap(
      spacing: 8,
      children: [
        MyText(text: "Beranda", fontSize: 12.5, color: MyColors.white2),
        MyText(text: "/", fontSize: 12.5, color: MyColors.white2),
        if (items["type"] != null) ...[
          MyText(
            text: "${items["type"]}".capitalize!,
            fontSize: 13,
            color: MyColors.white2,
          ),
          MyText(text: "/", fontSize: 12.5, color: MyColors.white2),
        ],
        MyText(text: "${items["series"]}", fontSize: 13, fontWeight: .w600),
      ],
    );
  }

  Widget gallery(ProductDetailController controller) {
    return Obx(() {
      final items = controller.res;
      final images = (items["images"] ?? []) as List;
      final selected = controller.selectedImage.value;

      return Column(
        crossAxisAlignment: .stretch,
        spacing: 12,
        children: [
          AspectRatio(
            aspectRatio: 4 / 5,
            child: Container(
              color: MyColors.black4,
              child: Stack(
                fit: .expand,
                children: [
                  MyImage(
                    images.isEmpty ? null : images[selected],
                    onTap: images.isEmpty ? null : controller.openImageViewer,
                  ),
                  if ("${items["badge"] ?? ""}".isNotEmpty)
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: .symmetric(horizontal: 10, vertical: 6),
                        color: MyColors.black3,
                        child: MyText(
                          text: "${items["badge"]}".toUpperCase(),
                          fontFamily: MyFonts.archivoNarrow,
                          fontSize: 11,
                          fontWeight: .w700,
                          letterSpacing: 11 * 0.15,
                        ),
                      ),
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
                      right: 14,
                      bottom: 14,
                      child: Container(
                        padding: .symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: MyColors.black3,
                          border: .all(color: MyColors.line2),
                        ),
                        child: MyText(
                          text: "${selected + 1}/${images.length}",
                          fontFamily: MyFonts.archivoNarrow,
                          fontSize: 12,
                          fontWeight: .w700,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: .horizontal,
              children: [
                for (final (i, item) in ([
                  for (var index = 0; index < images.length; index++)
                    thumbnail(controller, images, index),
                  if (items["sizeChart"] != null) sizeTile(controller),
                ]).indexed)
                  Padding(
                    padding: .only(left: i == 0 ? 0 : 12),
                    child: SizedBox(width: 64, child: item),
                  ),
              ],
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
        aspectRatio: 84 / 104,
        child: Container(
          padding: .all(isSelected ? 2 : 0),
          decoration: BoxDecoration(
            color: MyColors.black4,
            border: .all(color: isSelected ? MyColors.white : MyColors.line2),
          ),
          child: MyImage(images[index]),
        ),
      ),
    );
  }

  Widget sizeTile(ProductDetailController controller) {
    return GestureDetector(
      onTap: controller.openSizeChart,
      child: AspectRatio(
        aspectRatio: 84 / 104,
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.black4,
            border: .all(color: MyColors.line2),
          ),
          child: Column(
            mainAxisAlignment: .center,
            spacing: 8,
            children: [
              Icon(Icons.straighten, color: MyColors.white2, size: 16),
              MyText(
                text: "SIZE",
                fontFamily: MyFonts.archivoNarrow,
                fontSize: 11,
                fontWeight: .w700,
                letterSpacing: 11 * 0.15,
                color: MyColors.white2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget arrow(IconData icon, VoidCallback onTap) {
    return Padding(
      padding: .symmetric(horizontal: 12),
      child: GestureDetector(
        behavior: .opaque,
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: MyColors.black3.withValues(alpha: 0.7),
            border: .all(color: MyColors.line2),
          ),
          child: Icon(icon, color: MyColors.white, size: 20),
        ),
      ),
    );
  }

  Widget info(ProductDetailController controller) {
    return Obx(() {
      final items = controller.res;
      final stock = (items["stock"] ?? []) as List;
      final colors = (items["colors"] ?? []) as List;
      final selectedStock = controller.selectedStock.value;
      final eyebrow = [
        if (items["type"] != null) "${items["type"]}",
        if ("${items["material"] ?? ""}".isNotEmpty) "${items["material"]}",
      ].join(" · ").toUpperCase();

      return Column(
        crossAxisAlignment: .stretch,
        children: [
          if (eyebrow.isNotEmpty) ...[
            MyText(
              text: eyebrow,
              fontFamily: MyFonts.archivoNarrow,
              fontSize: 12,
              fontWeight: .w700,
              letterSpacing: 12 * 0.28,
              color: MyColors.white2,
            ),
            SizedBox(height: 8),
          ],
          MyText(
            text: "${items["name"]}".toLowerCase().capitalize!,
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 36,
            fontWeight: .w700,
            height: 1.0,
          ),
          SizedBox(height: 12),
          MyText(
            text: parsingCurrency(selectedStock?["price"] ?? minPrice(stock)),
            fontSize: 21,
            fontWeight: .w700,
          ),
          if (controller.resFeatures.isNotEmpty) ...[
            SizedBox(height: 25),
            features(controller),
          ],
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: label("WARNA")),
              MyText(
                text:
                    "${"${items["color"]}".capitalize} · ${controller.colorStock} tersisa",
                fontSize: 13,
                color: MyColors.white2,
              ),
            ],
          ),
          SizedBox(height: 12),
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
                            : MyColors.line2,
                      ),
                    ),
                    child: ClipOval(child: MyImage(color["image_url"])),
                  ),
                ),
            ],
          ),
          SizedBox(height: 32),
          Row(
            children: [
              Expanded(child: label("UKURAN")),
              if (items["sizeChart"] != null)
                GestureDetector(
                  onTap: controller.openSizeChart,
                  child: MyText(
                    text: "Panduan ukuran",
                    fontSize: 13,
                    color: MyColors.white2,
                    decoration: .underline,
                  ),
                ),
            ],
          ),
          SizedBox(height: 12),
          MyGrid(
            crossAxisCount: 4,
            spacing: 8,
            children: [
              for (final item in stock)
                size(controller, item, selectedStock == item),
            ],
          ),
          SizedBox(height: 28),
          Row(
            spacing: 12,
            children: [
              Container(
                width: 112,
                height: 56,
                decoration: BoxDecoration(border: .all(color: MyColors.line2)),
                child: Row(
                  children: [
                    qtyButton(Icons.remove, controller.decrease),
                    Expanded(
                      child: MyText(
                        text: "${controller.qty.value}",
                        textAlign: .center,
                        fontWeight: .w700,
                      ),
                    ),
                    qtyButton(Icons.add, controller.increase),
                  ],
                ),
              ),
              Expanded(
                child: MyButton(
                  "TAMBAH KE KERANJANG",
                  height: 56,
                  color: MyColors.red,
                  textColor: MyColors.nativeWhite,
                  fontSize: 12,
                  fontWeight: .w700,
                  prefixIcon: Icons.shopping_bag_outlined,
                  onTap: controller.addToCart,
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          MyButton(
            "LANGSUNG ORDER VIA WHATSAPP",
            height: 52,
            color: MyColors.black3,
            textColor: MyColors.white,
            borderColor: MyColors.swatchBorder,
            borderWidth: 1,
            fontSize: 14,
            fontWeight: .w700,
            prefixIcon: Icons.chat_bubble_outline,
            onTap: controller.orderNow,
          ),
          if (controller.addedMessage.value != null) ...[
            SizedBox(height: 18),
            Container(
              padding: .symmetric(horizontal: 14, vertical: 11),
              decoration: BoxDecoration(
                color: MyColors.green.withValues(alpha: 0.06),
                border: .all(color: MyColors.green.withValues(alpha: 0.3)),
              ),
              child: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: MyText(
                      text: controller.addedMessage.value!,
                      fontSize: 13,
                      color: MyColors.green,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.openCart,
                    child: MyText(
                      text: "Lihat keranjang",
                      fontSize: 13,
                      fontWeight: .w700,
                      decoration: .underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 10),
          MyText(
            text:
                "Order via WhatsApp lebih murah dibanding marketplace. Bisa gabung beberapa produk dalam satu pesan.",
            fontSize: 12,
            color: MyColors.white4,
          ),
          if ([
            items["links"]?["shopee"],
            items["links"]?["tiktok"],
            items["links"]?["tokopedia"],
          ].any((e) => "${e ?? ""}".isNotEmpty)) ...[
            SizedBox(height: 32),
            label("ATAU BELI DI MARKETPLACE"),
            SizedBox(height: 12),
            for (final (text, key) in [
              ("BELI DI SHOPEE", "shopee"),
              ("BELI DI TIKTOK SHOP", "tiktok"),
              ("BELI DI TOKOPEDIA", "tokopedia"),
            ])
              marketplace(text, items["links"]?[key]),
          ],
          if (controller.sections.isNotEmpty) ...[
            SizedBox(height: 22),
            accordion(controller),
          ],
        ],
      );
    });
  }

  Widget features(ProductDetailController controller) {
    final list = controller.resFeatures;

    return Container(
      decoration: BoxDecoration(border: .all(color: MyColors.line2)),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          for (var i = 0; i < list.length; i += 1)
            Container(
              decoration: BoxDecoration(
                border: i == 0
                    ? null
                    : Border(top: BorderSide(color: MyColors.line2)),
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: .stretch,
                  children: [
                    for (var j = i; j < i + 1; j++) ...[
                      if (j > i) Container(width: 1, color: MyColors.line2),
                      Expanded(
                        child: j < list.length
                            ? feature(controller, list[j])
                            : SizedBox(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget feature(
    ProductDetailController controller,
    Map<String, dynamic> item,
  ) {
    return Padding(
      padding: .fromLTRB(14, 11, 14, 15),
      child: Row(
        crossAxisAlignment: .start,
        spacing: 14,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(border: .all(color: MyColors.line2)),
            child: Icon(
              controller.featureIcon(item["icon"]),
              color: MyColors.redText,
              size: 16,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 4,
              children: [
                MyText(
                  text: "${item["title"] ?? ""}".toUpperCase(),
                  fontFamily: MyFonts.archivoNarrow,
                  fontSize: 13.5,
                  fontWeight: .w700,
                  letterSpacing: 13.5 * 0.08,
                ),
                if ("${item["description"] ?? ""}".isNotEmpty)
                  MyText(
                    text: "${item["description"]}",
                    fontSize: 12.5,
                    height: 1.5,
                    color: MyColors.white2,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget label(String text) {
    return MyText(
      text: text,
      fontFamily: MyFonts.archivoNarrow,
      fontSize: 13,
      fontWeight: .w700,
      letterSpacing: 13 * 0.2,
    );
  }

  Widget size(
    ProductDetailController controller,
    Map<String, dynamic> item,
    bool isSelected,
  ) {
    final qty = item["qty"] as int;
    final isSoldOut = qty <= 0;
    final color = isSelected
        ? MyColors.black
        : isSoldOut
        ? MyColors.white2.withValues(alpha: 0.5)
        : MyColors.white;

    return GestureDetector(
      onTap: isSoldOut ? null : () => controller.selectStock(item),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? MyColors.white : null,
          border: .all(color: isSelected ? MyColors.white : MyColors.line2),
        ),
        child: Column(
          mainAxisAlignment: .center,
          spacing: 4,
          children: [
            MyText(
              text: "${item["size"]}",
              fontWeight: .w700,
              decoration: isSoldOut ? .lineThrough : null,
              color: color,
            ),
            MyText(
              text: isSoldOut ? "Habis" : "Sisa $qty",
              fontSize: 10.5,
              decoration: isSoldOut ? .lineThrough : null,
              color: isSelected
                  ? MyColors.black.withValues(alpha: 0.6)
                  : MyColors.white2.withValues(alpha: isSoldOut ? 0.5 : 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      behavior: .opaque,
      onTap: onTap,
      child: SizedBox(
        width: 36,
        height: 56,
        child: Icon(icon, color: MyColors.white, size: 18),
      ),
    );
  }

  Widget marketplace(String text, String? url) {
    if (url == null || url.isEmpty) return SizedBox();

    return GestureDetector(
      behavior: .opaque,
      onTap: () => execUri(url),
      child: Container(
        height: 54,
        margin: .only(bottom: 8),
        padding: .symmetric(horizontal: 18),
        decoration: BoxDecoration(border: .all(color: MyColors.line2)),
        child: Row(
          children: [
            Expanded(
              child: MyText(
                text: text,
                fontFamily: MyFonts.archivoNarrow,
                fontSize: 14,
                fontWeight: .w700,
                letterSpacing: 14 * 0.1,
              ),
            ),
            Icon(Icons.north_east, color: MyColors.white2, size: 14),
          ],
        ),
      ),
    );
  }

  Widget accordion(ProductDetailController controller) {
    final sections = controller.sections;

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        for (final (i, item) in sections.indexed)
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: i == 0
                    ? BorderSide(color: MyColors.line2)
                    : BorderSide.none,
                bottom: BorderSide(color: MyColors.line2),
              ),
            ),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                GestureDetector(
                  behavior: .opaque,
                  onTap: () => controller.toggleSection(i),
                  child: Padding(
                    padding: .symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Expanded(child: label(item.$1)),
                        Icon(
                          controller.openSection.value == i
                              ? Icons.remove
                              : Icons.add,
                          color: MyColors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                if (controller.openSection.value == i)
                  Padding(
                    padding: .only(bottom: 20),
                    child: item.$2 == "description"
                        ? description(controller.res["description"])
                        : Column(
                            crossAxisAlignment: .start,
                            spacing: 6,
                            children: [
                              for (final point in controller.points(item.$2))
                                Row(
                                  crossAxisAlignment: .start,
                                  spacing: 10,
                                  children: [
                                    MyText(
                                      text: "•",
                                      fontSize: 13.5,
                                      height: 1.75,
                                      color: MyColors.white3,
                                    ),
                                    Expanded(
                                      child: MyText(
                                        text: point,
                                        fontSize: 13.5,
                                        height: 1.75,
                                        color: MyColors.white3,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget description(String? description) {
    return DefaultTextStyle(
      style: TextStyle(
        color: MyColors.white3,
        fontSize: 14,
        height: 1.7,
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
          config: quill.QuillEditorConfig(
            customStyles: quill.DefaultStyles(
              paragraph: quill.DefaultTextBlockStyle(
                TextStyle(
                  color: MyColors.white3,
                  fontSize: 13.5,
                  height: 1.75,
                  fontFamily: MyFonts.archivo,
                ),
                quill.HorizontalSpacing.zero,
                quill.VerticalSpacing.zero,
                quill.VerticalSpacing.zero,
                null,
              ),
            ),
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
