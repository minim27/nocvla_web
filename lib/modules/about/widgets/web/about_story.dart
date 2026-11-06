import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../about_controller.dart';

class AboutStory extends StatelessWidget {
  const AboutStory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();

    return Obx(() {
      final about = controller.resAbout;
      if (!controller.hasStory) return SizedBox();

      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1240 + 48 * 2),
          child: Padding(
            padding: .fromLTRB(48, 112, 48, 0),
            child: SizedBox(
              width: .infinity,
              child: Row(
                crossAxisAlignment: .start,
                spacing: 56,
                children: [
                  Expanded(
                    child: Padding(
                      padding: .only(top: 48),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          if (about["ABOUT_STORY_EYEBROW"] != null) ...[
                            MyText(
                              text: about["ABOUT_STORY_EYEBROW"]!.toUpperCase(),
                              fontFamily: MyFonts.archivoNarrow,
                              fontSize: 12,
                              fontWeight: .w700,
                              letterSpacing: 12 * 0.3,
                              color: MyColors.white2,
                            ),
                            SizedBox(height: 20),
                          ],
                          if (about["ABOUT_STORY_TITLE"] != null) ...[
                            MyText(
                              text: about["ABOUT_STORY_TITLE"]!,
                              fontFamily: MyFonts.grenzeGotisch,
                              fontSize: 58,
                              fontWeight: .w700,
                              height: 1.034,
                            ),
                            SizedBox(height: 20),
                          ],
                          for (final (i, item)
                              in controller.storyParagraphs.indexed) ...[
                            if (i > 0) SizedBox(height: 20),
                            MyText(
                              text: item,
                              fontSize: 15.5,
                              height: 1.8,
                              color: MyColors.white3,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child:
                        (about["ABOUT_STORY_IMAGE_1"] != null ||
                            about["ABOUT_STORY_IMAGE_2"] != null)
                        ? Row(
                            crossAxisAlignment: .start,
                            spacing: 12,
                            children: [
                              Expanded(
                                child: photo(about["ABOUT_STORY_IMAGE_1"]),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: .only(top: 48),
                                  child: photo(about["ABOUT_STORY_IMAGE_2"]),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget photo(String? path) {
    if (path == null) return SizedBox();

    return AspectRatio(aspectRatio: 3 / 4, child: MyImage(path));
  }
}
