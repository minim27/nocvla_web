import 'package:flutter/services.dart';
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
    await req.responseHandler(
      res: (res) => resAthlete.value = AthleteModel.fromJson(res),
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingAthlete.value = false;
  }

  void fetchApiProducts() async {
    if (id.value == null) return;
    isLoadingProducts.value = true;

    final req = await athleteRepo.assignedProducts(id.value!);
    await req.responseHandler(
      res: (res) {
        resProducts.value = (res as List).expand((e) {
          final product = e["product"];
          final colors = (product["colors"] as List?) ?? [];

          return colors.map((c) {
            final images = c["images"] as List;
            final mainImage = images.isEmpty ? null : images.first;

            final prices = (c["stock"] as List)
                .map((s) => s["price"] as int)
                .toList();
            final minPrice = prices.isEmpty
                ? 0
                : prices.reduce((a, b) => a < b ? a : b);

            return ListProductsModel.fromJson({
              "id": c["id"],
              "product_id": product["id"],
              "name": product["name"],
              "image_url": mainImage?["image_url"],
              "color": c["name"],
              "price": minPrice,
              "stock": c["stock"],
              "link_aff_shopee": e["link_aff_shopee"],
              "link_aff_tktkshop": e["link_aff_tktkshop"],
              "link_aff_tokped": e["link_aff_tokped"],
            });
          });
        }).toList();
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingProducts.value = false;
  }

  void openDetail(ListProductsModel item) => Get.toNamed(
    MyRoutes.productDetail,
    parameters: {"id": item.id},
    arguments: {
      "code": resAthlete.value?.code,
      "shopee": item.linkAffShopee,
      "tiktok": item.linkAffTktkshop,
      "tokopedia": item.linkAffTokped,
    },
  );

  void copyCode() {
    Clipboard.setData(ClipboardData(text: resAthlete.value?.code ?? ""));
    showMySnackbar("Disalin", "Code disalin");
  }
}
