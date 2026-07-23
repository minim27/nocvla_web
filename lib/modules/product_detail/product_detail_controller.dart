import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nocvla_web/app/routes/my_routes.dart';
import 'package:nocvla_web/app/services/my_config.dart';
import 'package:nocvla_web/data/models/cart/cart_item_model.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';

import '../../app/core/base_controller.dart';
import '../../shared/utils/my_utility.dart';

class ProductDetailController extends BaseController {
  final res = <String, dynamic>{}.obs;

  final features = <Map<String, dynamic>>[
    {"icon": MyIcons.icStretch, "label": "4 Way Stretch"},
    {"icon": MyIcons.icQuickDry, "label": "Quick Dry"},
    {"icon": MyIcons.icBreathable, "label": "Breathable Fabric"},
    {"icon": MyIcons.icPerformance, "label": "Performance Fit"},
  ];

  final resOrderBy = <Map<String, dynamic>>[{}];

  final id = RxnString();
  final selectedImage = 0.obs;
  final selectedStock = Rxn<Map<String, dynamic>>();

  final qty = 0.obs;
  final isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    id.value = Get.parameters["id"];
    fetchApiProduct();
  }

  void fetchApiProduct() async {
    if (id.value == null) return;

    isLoading.value = true;

    final req = await collectionsRepo.getProduct(id.value!);
    req.responseHandler(
      res: (data) {
        res.value = {
          "id": data["id"],
          "images": (data["images"] as List)
              .map((e) => e["image_url"])
              .toList(),
          "name": data["name"],
          "description": data["description"],
          "color": data["color"],
          "stock": (data["stock"] as List)
              .map(
                (e) => {
                  "size": e["size"],
                  "qty": e["qty"],
                  "price": e["price"],
                },
              )
              .toList(),
          "links": {
            "shopee": data["shopee_url"],
            "tiktok": data["tiktok_url"],
            "tokopedia": data["tokopedia_url"],
          },
        };
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoading.value = false;
  }

  void selectImage(int index) => selectedImage.value = index;

  void selectStock(Map<String, dynamic> value) => selectedStock.value = value;

  void decrease() => qty.value > 0 ? qty.value-- : null;

  void increase() =>
      qty.value < selectedStock.value!["qty"] ? qty.value++ : null;

  void openCart() {
    if (selectedStock.value == null) {
      showMyErrAPISnackbar({"message": "Pilih ukuran terlebih dahulu"});
      return;
    }

    if (qty.value <= 0) {
      showMyErrAPISnackbar({"message": "Masukkan jumlah qty terlebih dahulu"});
      return;
    }

    final box = GetStorage();
    final data = box.read(MyConfig.keyCart) as Map<String, dynamic>?;

    final items = ((data?["items"] as List?) ?? [])
        .map((e) => CartItemModel.fromJson(e))
        .toList();

    final stock = selectedStock.value!;
    final images = res["images"] as List;

    final existingIndex = items.indexWhere(
      (item) => item.productId == res["id"] && item.size == stock["size"],
    );

    if (existingIndex != -1) {
      items[existingIndex].qty.value += qty.value;
    } else {
      items.add(
        CartItemModel(
          productId: res["id"],
          name: res["name"],
          imageUrl: images.isEmpty ? null : images.first,
          color: res["color"],
          size: stock["size"],
          price: stock["price"],
          qty: qty.value,
        ),
      );
    }

    box.write(MyConfig.keyCart, {
      "items": items.map((e) => e.toJson()).toList(),
      "appliedCode": data?["appliedCode"],
      "discountProductIds": data?["discountProductIds"] ?? [],
    });

    Get.toNamed(MyRoutes.cart);
  }
}
