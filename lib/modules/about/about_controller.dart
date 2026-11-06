import 'package:get/get.dart';
import 'package:nocvla_web/shared/utils/my_utility.dart';

import '../../app/core/base_controller.dart';
import '../../app/routes/my_routes.dart';

class AboutController extends BaseController {
  final resAbout = <String, String>{}.obs;
  final isLoadingAbout = false.obs;

  final targets = const [
    ("MISI", "ABOUT_MISSION"),
    ("VISI", "ABOUT_VISION"),
    ("NILAI", "ABOUT_VALUES"),
  ];

  List<String> get storyParagraphs => (resAbout["ABOUT_STORY_BODY"] ?? "")
      .split(RegExp(r"\n\s*\n"))
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

  List<(String, String)> get crafts => [
    for (var i = 1; i <= 4; i++)
      if (resAbout["ABOUT_CRAFT_${i}_TITLE"] != null ||
          resAbout["ABOUT_CRAFT_${i}_DESC"] != null)
        (
          resAbout["ABOUT_CRAFT_${i}_TITLE"] ?? "",
          resAbout["ABOUT_CRAFT_${i}_DESC"] ?? "",
        ),
  ];

  bool get hasStory =>
      resAbout["ABOUT_STORY_TITLE"] != null ||
      storyParagraphs.isNotEmpty ||
      resAbout["ABOUT_STORY_IMAGE_1"] != null ||
      resAbout["ABOUT_STORY_IMAGE_2"] != null;

  @override
  void onInit() {
    super.onInit();
    fetchApiAbout();
  }

  void fetchApiAbout() async {
    isLoadingAbout.value = true;

    final req = await configRepo.listConfigs([
      "ABOUT_EYEBROW",
      "ABOUT_TITLE",
      "ABOUT_DESCRIPTION",
      "ABOUT_IMAGE",
      "ABOUT_STORY_EYEBROW",
      "ABOUT_STORY_TITLE",
      "ABOUT_STORY_BODY",
      "ABOUT_STORY_IMAGE_1",
      "ABOUT_STORY_IMAGE_2",
      "ABOUT_MISSION",
      "ABOUT_VISION",
      "ABOUT_VALUES",
      "ABOUT_CRAFT_EYEBROW",
      "ABOUT_CRAFT_TITLE",
      for (var i = 1; i <= 4; i++) ...[
        "ABOUT_CRAFT_${i}_TITLE",
        "ABOUT_CRAFT_${i}_DESC",
      ],
      "ABOUT_CTA_TITLE",
    ]);
    await req.responseHandler(
      res: (res) {
        resAbout.value = {
          for (final e in (res as List))
            if ("${e["value"] ?? ""}".trim().isNotEmpty)
              "${e["name"]}": "${e["value"]}".trim(),
        };
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingAbout.value = false;
  }

  void openCollection() => Get.toNamed(MyRoutes.collection);

  void openApplication() =>
      Get.toNamed(MyRoutes.athlete, parameters: {"join": "1"});
}
