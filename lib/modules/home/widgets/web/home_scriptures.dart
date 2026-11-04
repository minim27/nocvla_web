import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../home_controller.dart';

class HomeScriptures extends StatelessWidget {
  const HomeScriptures({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      margin: .only(top: 96),
      padding: .symmetric(horizontal: 48, vertical: 96),
      decoration: BoxDecoration(
        color: MyColors.black4,
        border: Border.symmetric(horizontal: BorderSide(color: MyColors.line2)),
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 24,
        children: [
          Column(
            crossAxisAlignment: .start,
            spacing: 4,
            children: [eyebrow("SERI"), title("The Scriptures")],
          ),
          Obx(
            () => MyGrid(
              crossAxisCount: 3,
              children: [
                for (final items in controller.resSeries)
                  GestureDetector(
                    onTap: () {
                      if (items["id"] != null) {
                        controller.openDetail(items["id"]);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.black3,
                        border: .all(color: MyColors.line3),
                      ),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          AspectRatio(
                            aspectRatio: 5 / 4,
                            child: MyImage(items["image_url"]),
                          ),
                          Padding(
                            padding: .all(20),
                            child: Column(
                              crossAxisAlignment: .start,
                              spacing: 8,
                              children: [
                                eyebrow(
                                  items["label"],
                                  color: MyColors.redText,
                                ),
                                MyText(
                                  text: items["title"],
                                  fontFamily: MyFonts.grenzeGotisch,
                                  fontSize: 24,
                                  fontWeight: .w600,
                                ),
                                MyText(
                                  text: items["desc"],
                                  fontSize: 13,
                                  height: 1.5,
                                  color: MyColors.white2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget eyebrow(String text, {Color color = MyColors.white2}) {
    return MyText(
      text: text,
      fontFamily: MyFonts.archivoNarrow,
      fontSize: 12,
      fontWeight: .w600,
      letterSpacing: 12 * 0.2,
      color: color,
    );
  }

  Widget title(String text) {
    return MyText(
      text: text,
      fontFamily: MyFonts.grenzeGotisch,
      fontSize: 48,
      fontWeight: .w600,
      height: 1.1,
    );
  }
}
