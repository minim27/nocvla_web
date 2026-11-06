import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../about_controller.dart';

class MAboutStory extends StatelessWidget {
  const MAboutStory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();

    return Obx(() {
      final about = controller.resAbout;
      if (!controller.hasStory) return SizedBox();

      return Padding(
        padding: .fromLTRB(24, 64, 24, 0),
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: 40,
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                if (about["ABOUT_STORY_EYEBROW"] != null) ...[
                  MyText(
                    text: about["ABOUT_STORY_EYEBROW"]!.toUpperCase(),
                    fontFamily: MyFonts.archivoNarrow,
                    fontSize: 11,
                    fontWeight: .w700,
                    letterSpacing: 11 * 0.3,
                    color: MyColors.white2,
                  ),
                  SizedBox(height: 20),
                ],
                if (about["ABOUT_STORY_TITLE"] != null) ...[
                  MyText(
                    text: about["ABOUT_STORY_TITLE"]!,
                    fontFamily: MyFonts.grenzeGotisch,
                    fontSize: 38,
                    fontWeight: .w700,
                    height: 1.0,
                  ),
                  SizedBox(height: 24),
                ],
                for (final (i, item) in controller.storyParagraphs.indexed) ...[
                  if (i > 0) SizedBox(height: 20),
                  MyText(
                    text: item,
                    fontSize: 15,
                    height: 1.7,
                    color: MyColors.white3,
                  ),
                ],
              ],
            ),
            if (about["ABOUT_STORY_IMAGE_1"] != null ||
                about["ABOUT_STORY_IMAGE_2"] != null)
              Row(
                crossAxisAlignment: .start,
                spacing: 12,
                children: [
                  Expanded(child: photo(about["ABOUT_STORY_IMAGE_1"])),
                  Expanded(
                    child: Padding(
                      padding: .only(top: 32),
                      child: photo(about["ABOUT_STORY_IMAGE_2"]),
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    });
  }

  Widget photo(String? path) {
    if (path == null) return SizedBox();

    return AspectRatio(aspectRatio: 3 / 4, child: MyImage(path));
  }
}
