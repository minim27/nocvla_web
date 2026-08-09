import 'package:nocvla_web/shared/utils/my_dummies.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';

import '../../app/core/base_controller.dart';

class AboutController extends BaseController {
  final res = <String, dynamic>{
    "image": MyDummies.dumBanner,
    "title": "ABOUT NOCVLA",
    "desc":
        "NOCVLA lahir dari keyakinan bahwa kemajuan tidak diberikan, tetapi diperjuangkan. Melalui disiplin, konsistensi, dan kerja keras, kami menciptakan apparel yang mendukung setiap langkah perjalananmu—di gym maupun dalam kehidupan",
    "targets": [
      {
        "icon": MyIcons.icMission,
        "label": "OUR MISSION",
        "desc": "Membantu setiap individu\nmencapai potensi terbaiknya.",
      },
      {
        "icon": MyIcons.icVision,
        "label": "OUR VISION",
        "desc": "Menjadi brand apparel training\nterdepan di Indonesia.",
      },
      {
        "icon": MyIcons.icValues,
        "label": "OUR VALUES",
        "desc": "Disiplin, Kualitas, dan\nKomunitas",
      },
    ],
    "banners": [MyDummies.dumBanner, MyDummies.dumBanner, MyDummies.dumBanner],
  };
}
