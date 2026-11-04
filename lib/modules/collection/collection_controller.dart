import 'package:get/get.dart';
import 'package:nocvla_web/app/routes/my_routes.dart';
import 'package:nocvla_web/data/models/collections/list_products_model.dart';
import 'package:nocvla_web/data/models/collections/product_type_model.dart';

import '../../app/core/base_controller.dart';
import '../../shared/utils/my_utility.dart';

class CollectionController extends BaseController {
  final resType = <ProductTypeModel>[].obs;
  final resProducts = <ListProductsModel>[].obs;

  final selectedType = "".obs;
  final selectedSize = "".obs;

  final isLoadingType = false.obs;
  final isLoadingProd = false.obs;

  @override
  void onInit() {
    super.onInit();
    selectedType.value = Get.parameters["type"] ?? "";
    fetchApiType();
    fetchApiProducts();
  }

  void fetchApiType() async {
    isLoadingType.value = true;

    final req = await collectionsRepo.productType();
    await req.responseHandler(
      res: (res) {
        final types = (res as List)
            .map((e) => ProductTypeModel.fromJson(e))
            .toList();

        resType.value = [
          ProductTypeModel(name: "ALL", value: ""),
          ...types,
          if (!types.any((e) => e.name == "ACCESSORIES"))
            ProductTypeModel(name: "ACCESSORIES", value: "accessories"),
        ];
      },
      err: (err) => showMyErrAPISnackbar(err),
    );
    isLoadingType.value = false;
  }

  void fetchApiProducts() async {
    isLoadingProd.value = true;

    final req = await collectionsRepo.listProducts(selectedType.value);
    await req.responseHandler(
      res: (res) {
        resProducts.value = (res as List).expand((e) {
          final colors = (e["colors"] as List?) ?? [];

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
              "product_id": e["id"],
              "name": e["name"],
              "image_url": mainImage?["image_url"],
              "color": c["name"],
              "type": e["product_type"]?["name"],
              "price": minPrice,
              "stock": c["stock"],
            });
          });
        }).toList();
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingProd.value = false;
  }

  List<String> get sizes {
    final sizes = resProducts
        .expand((e) => (e.stock as List))
        .where((s) => s["qty"] > 0)
        .map((s) => s["size"] as String)
        .toSet()
        .toList();
    sizes.sort((a, b) => sizeRank(a).compareTo(sizeRank(b)));

    return sizes;
  }

  List<List<ListProductsModel>> get groups {
    final groups = <dynamic, List<ListProductsModel>>{};
    final size = selectedSize.value;

    for (final item in resProducts) {
      final isReady =
          size.isEmpty ||
          (item.stock as List).any((s) => s["size"] == size && s["qty"] > 0);

      if (isReady) groups.putIfAbsent(item.productId, () => []).add(item);
    }

    return groups.values.toList();
  }

  void selectType(String value) {
    selectedType.value = value;
    selectedSize.value = "";
    fetchApiProducts();
  }

  void selectSize(String value) =>
      selectedSize.value = selectedSize.value == value ? "" : value;

  void openDetail(String id) =>
      Get.toNamed(MyRoutes.productDetail, parameters: {"id": id});
}
