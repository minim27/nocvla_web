import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/data/models/collections/list_products_model.dart';

import '../../app/core/base_controller.dart';
import '../../app/routes/my_routes.dart';
import '../../shared/utils/my_utility.dart';

class SearchPageController extends BaseController {
  final resProducts = <ListProductsModel>[].obs;

  final popular = [
    "Argos",
    "Fallenseraph",
    "Prototype",
    "Compression",
    "Inferno",
  ];

  final txtQuery = TextEditingController();
  final query = "".obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchApiProducts();
  }

  void fetchApiProducts() async {
    isLoading.value = true;

    final req = await collectionsRepo.listProducts("");
    await req.responseHandler(
      res: (res) {
        resProducts.value = (res as List).expand((e) {
          final colors = (e["colors"] as List?) ?? [];

          return colors.map((c) {
            final images = c["images"] as List;
            final prices = (c["stock"] as List)
                .map((s) => s["price"] as int)
                .toList();

            return ListProductsModel.fromJson({
              "id": c["id"],
              "product_id": e["id"],
              "name": e["name"],
              "image_url": images.isEmpty ? null : images.first["image_url"],
              "color": c["name"],
              "type": e["product_type"]?["name"],
              "price": prices.isEmpty
                  ? 0
                  : prices.reduce((a, b) => a < b ? a : b),
              "stock": c["stock"],
            });
          });
        }).toList();
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoading.value = false;
  }

  List<ListProductsModel> get results {
    final value = query.value.trim().toLowerCase();
    if (value.isEmpty) return [];

    return resProducts.where((e) {
      return "${e.name} ${e.color} ${e.type}".toLowerCase().contains(value);
    }).toList();
  }

  void onChanged(String value) => query.value = value;

  void selectPopular(String value) {
    txtQuery.text = value;
    query.value = value;
  }

  void clearQuery() {
    txtQuery.clear();
    query.value = "";
  }

  void close() =>
      Get.previousRoute.isEmpty ? Get.offAllNamed(MyRoutes.home) : Get.back();

  void openCollection() => Get.toNamed(MyRoutes.collection);

  void openDetail(String id) =>
      Get.toNamed(MyRoutes.productDetail, parameters: {"id": id});
}
