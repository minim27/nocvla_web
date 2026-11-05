import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/home/banner_model.dart';
import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_linears.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_skeleton.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../home_controller.dart';

class MHomeHeader extends StatelessWidget {
  const MHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      if (controller.isLoadingBanner.value) {
        return MySkeleton(height: 560);
      }

      final slides = controller.resBanners.toList();
      if (slides.isEmpty) return SizedBox();

      return SizedBox(
        height: 560,
        child: Stack(
          fit: .expand,
          children: [
            PageView.builder(
              controller: controller.heroPage,
              itemCount: slides.length,
              onPageChanged: controller.onHeroChanged,
              itemBuilder: (context, index) => slide(controller, slides[index]),
            ),
            if (slides.length > 1)
              Positioned(
                left: 16,
                bottom: 16,
                child: Row(
                  children: [
                    for (var i = 0; i < slides.length; i++)
                      GestureDetector(
                        behavior: .opaque,
                        onTap: () => controller.tapHeroDot(i),
                        child: Container(
                          width: 24,
                          height: 24,
                          alignment: .center,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.heroIndex.value == i
                                  ? MyColors.white
                                  : MyColors.swatchBorder,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget slide(HomeController controller, BannerModel banner) {
    return Stack(
      fit: .expand,
      children: [
        MyImage(banner.imageUrl),
        Container(decoration: BoxDecoration(gradient: MyLinears.linear1)),
        Container(color: MyColors.black.withValues(alpha: 0.5)),
        Padding(
          padding: .symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            children: [
              if ("${banner.eyebrow ?? ""}".isNotEmpty) ...[
                Row(
                  spacing: 12,
                  children: [
                    Container(width: 32, height: 1, color: MyColors.redText),
                    Flexible(
                      child: MyText(
                        text: banner.eyebrow,
                        fontFamily: MyFonts.archivoNarrow,
                        fontSize: 12,
                        fontWeight: .w600,
                        letterSpacing: 12 * 0.3,
                        color: MyColors.redText,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
              MyText(
                text: "${banner.title ?? ""}",
                fontFamily: MyFonts.grenzeGotisch,
                fontSize: 44,
                fontWeight: .w600,
                height: 1.05,
              ),
              SizedBox(height: 20),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 480),
                child: MyText(
                  text: "${banner.description ?? ""}",
                  fontSize: 15,
                  height: 1.6,
                  color: MyColors.white,
                ),
              ),
              SizedBox(height: 28),
              Column(
                crossAxisAlignment: .stretch,
                spacing: 12,
                children: [
                  MyButton(
                    "SHOP THE DROP",
                    height: 48,
                    suffixIcon: Icons.arrow_forward,
                    onTap: () => controller.openDrop(banner),
                  ),
                  MyButtonBorder(
                    "LIHAT KOLEKSI",
                    borderColor: MyColors.line2,
                    height: 48,
                    onTap: controller.openCollection,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
