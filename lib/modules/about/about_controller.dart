import 'package:get/get.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';
import 'package:nocvla_web/shared/utils/my_utility.dart';

import '../../app/core/base_controller.dart';
import '../../app/routes/my_routes.dart';

class AboutController extends BaseController {
  final heroImage = RxnString();

  final res = <String, dynamic>{
    "title": "ABOUT NOCVLA",
    "story":
        "NOCVLA lahir dari keyakinan bahwa kemajuan tidak diberikan, tetapi diperjuangkan. Melalui disiplin, konsistensi, dan kerja keras, kami menciptakan apparel yang mendukung setiap langkah perjalananmu—di gym maupun dalam kehidupan",
    "targets": [
      {
        "icon": MyIcons.icMission,
        "label": "MISI",
        "desc": "Membantu setiap individu mencapai potensi terbaiknya.",
      },
      {
        "icon": MyIcons.icVision,
        "label": "VISI",
        "desc": "Menjadi brand apparel training terdepan di Indonesia.",
      },
      {
        "icon": MyIcons.icValues,
        "label": "NILAI",
        "desc": "Disiplin, Kualitas, dan Komunitas",
      },
    ],
    "crafts": [
      {"label": "Elastane 240gsm", "desc": "Material compression"},
      {"label": "Cotton 16s", "desc": "Material oversize"},
      {"label": "Overdeck stitch", "desc": "Jahitan kuat dan rapi"},
      {"label": "Sablon pekat", "desc": "Tinta tajam dan tahan lama"},
    ],
  };

  @override
  void onInit() {
    super.onInit();
    fetchApiHero();
  }

  void fetchApiHero() async {
    final req = await homeRepo.featuredProducts();
    await req.responseHandler(
      res: (res) {
        final colors = (res as List).expand((e) => e["colors"] as List);
        final images = colors.expand((c) => c["images"] as List);

        heroImage.value = images.firstOrNull?["image_url"];
      },
      err: (err) => showMyErrAPISnackbar(err),
    );
  }

  void openCollection() => Get.toNamed(MyRoutes.collection);
}
