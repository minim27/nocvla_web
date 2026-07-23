import 'package:nocvla_web/shared/utils/my_dummies.dart';

import '../../app/core/base_controller.dart';
import '../../shared/utils/my_icons.dart';

class AthleteController extends BaseController {
  final res = <Map<String, dynamic>>[
    {
      "id": "123",
      "image": MyDummies.dumBaju,
      "title": "ATHLETE",
      "subTitle": "BATCH 01",
      "count": 4,
      "isComingSoon": false,
    },
    {
      "id": "123",
      "image": MyDummies.dumBaju,
      "title": "ATHLETE",
      "subTitle": "BATCH 02",
      "count": 0,
      "isComingSoon": true,
    },
  ];

  final resBenefits = <Map<String, dynamic>>[
    {
      "icon": MyIcons.icShirt,
      "label": "FREE PRODUCT",
      "desc": "Dapatkan produk eksklusif",
    },
    {
      "icon": MyIcons.icLink,
      "label": "AFFILIATE ACCESS",
      "desc": "Dapatkan keuntungan dari hasil penjualan",
    },
    {
      "icon": MyIcons.icCommunity,
      "label": "EXCLUSIVE COMMUNITY",
      "desc": "Gabung dengan komunitas NOCVLA",
    },
    {
      "icon": MyIcons.icUp,
      "label": "GROW TOGETHER",
      "desc": "Bertumbuh bersama NOCVLA",
    },
  ];
}
