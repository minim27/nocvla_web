import 'package:get/get.dart';
import 'package:nocvla_web/data/models/athlete/athlete_model.dart';

import '../../../app/core/base_controller.dart';
import '../../../app/routes/my_routes.dart';
import '../../../shared/utils/my_icons.dart';
import '../../../shared/utils/my_utility.dart';

class AthleteController extends BaseController {
  final resAthlete = <AthleteModel>[].obs;
  final isLoadingAthlete = false.obs;

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

  @override
  void onInit() {
    super.onInit();
    fetchApiAthlete();
  }

  void fetchApiAthlete() async {
    isLoadingAthlete.value = true;

    final req = await athleteRepo.listAthlete();
    req.responseHandler(
      res: (res) {
        resAthlete.value = (res as List)
            .map((e) => AthleteModel.fromJson(e))
            .toList();
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingAthlete.value = false;
  }

  void openDetail(String id) =>
      Get.toNamed(MyRoutes.athleteDetail, parameters: {"id": id});
}
