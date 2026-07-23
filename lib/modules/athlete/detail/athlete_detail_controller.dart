import 'package:get/get.dart';
import 'package:nocvla_web/app/routes/my_routes.dart';
import 'package:nocvla_web/data/models/athlete/athlete_model.dart';
import 'package:nocvla_web/data/models/collections/list_products_model.dart';

import '../../../app/core/base_controller.dart';
import '../../../shared/utils/my_utility.dart';

class AthleteDetailController extends BaseController {
  final id = RxnString();

  final resAthlete = Rxn<AthleteModel>();
  final resProducts = <ListProductsModel>[].obs;

  final isLoadingAthlete = false.obs;
  final isLoadingProducts = false.obs;

  @override
  void onInit() {
    super.onInit();
    id.value = Get.parameters["id"];
    fetchApiAthlete();
    fetchApiProducts();
  }

  void fetchApiAthlete() async {
    if (id.value == null) return;
    isLoadingAthlete.value = true;

    final req = await athleteRepo.getAthlete(id.value!);
    req.responseHandler(
      res: (res) => resAthlete.value = AthleteModel.fromJson(res),
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingAthlete.value = false;
  }

  void fetchApiProducts() async {
    if (id.value == null) return;
    isLoadingProducts.value = true;

    final req = await athleteRepo.assignedProducts(id.value!);
    req.responseHandler(
      res: (res) {
        resProducts.value = (res as List)
            .map((e) => ListProductsModel.fromJson(e["v_products"]))
            .toList();
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingProducts.value = false;
  }

  void openDetail(String id) =>
      Get.toNamed(MyRoutes.productDetail, parameters: {"id": id});
}
