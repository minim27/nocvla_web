import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/app/routes/my_routes.dart';
import 'package:nocvla_web/data/models/collections/list_products_model.dart';
import 'package:nocvla_web/data/models/collections/product_type_model.dart';

import '../../app/core/base_controller.dart';
import '../../shared/utils/my_utility.dart';

class CollectionController extends BaseController {
  final resType = <ProductTypeModel>[].obs;
  final resProducts = <ListProductsModel>[].obs;

  final txtEmail = TextEditingController();

  final selectedType = "".obs;

  final isLoadingType = false.obs;
  final isLoadingProd = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchApiType();
    fetchApiFeatured();
  }

  void fetchApiType() async {
    isLoadingType.value = true;

    final req = await collectionsRepo.productType();
    req.responseHandler(
      res: (res) {
        resType.value = [
          ProductTypeModel(name: "ALL", value: ""),
          ...(res as List).map((e) => ProductTypeModel.fromJson(e)),
        ];
      },
      err: (err) => showMyErrAPISnackbar(err),
    );
    isLoadingType.value = false;
  }

  void fetchApiFeatured() async {
    isLoadingProd.value = true;

    final req = await collectionsRepo.listProducts(selectedType.value);
    req.responseHandler(
      res: (res) {
        resProducts.value = (res as List).map((e) {
          // print(e);
          return ListProductsModel.fromJson(e);
        }).toList();
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingProd.value = false;
  }

  void selectType(String value) {
    selectedType.value = value;
    fetchApiFeatured();
  }

  void openDetail(String id) =>
      Get.toNamed(MyRoutes.productDetail, parameters: {"id": id});
}
