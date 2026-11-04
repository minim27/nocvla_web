import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nocvla_web/app/services/my_config.dart';
import 'package:nocvla_web/data/models/cart/cart_item_model.dart';
import 'package:nocvla_web/modules/product_detail/widgets/product_detail_image_viewer_dialog.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
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

  Map<String, dynamic>? athleteLinks;

  final txtCode = TextEditingController();
  final isValidatingCode = false.obs;
  final appliedCode = RxnString();
  final discountProductIds = <String>[].obs;

  @override
  void onInit() async {
    super.onInit();
    id.value = Get.parameters["id"];
    athleteLinks = Get.arguments as Map<String, dynamic>?;
    if (athleteLinks != null) txtCode.text = athleteLinks?["code"] ?? "";
    fetchApiProduct();

    final cart =
        GetStorage().read(MyConfig.keyCart) as Map<String, dynamic>?;
    appliedCode.value = cart?["appliedCode"];
    discountProductIds.value = List<String>.from(
      cart?["discountProductIds"] ?? [],
    );
  }

  int get discountAmount {
    if (appliedCode.value == null) return 0;
    if (selectedStock.value == null) return 0;
    if (!discountProductIds.contains(res["productBaseId"])) return 0;

    final subTotal = (selectedStock.value!["price"] as int) * qty.value;
    return (subTotal * 0.08).round();
  }

  void fetchApiProduct() async {
    if (id.value == null) return;

    isLoading.value = true;

    final req = await collectionsRepo.getProduct(id.value!);
    await req.responseHandler(
      res: (data) {
        final product = data["product"];

        res.value = {
          "id": data["id"],
          "productBaseId": product["id"],
          "images": (data["images"] as List)
              .map((e) => e["image_url"])
              .toList(),
          "name": product["name"],
          "description": product["description"],
          "color": data["name"],
          "colors": product["colors"],
          "stock": (data["stock"] as List)
              .map(
                (e) => {
                  "size": e["size"],
                  "qty": e["qty"],
                  "price": e["price"],
                },
              )
              .toList(),
          "links": athleteLinks == null
              ? {
                  "shopee": product["shopee_url"],
                  "tiktok": product["tiktok_url"],
                  "tokopedia": product["tokopedia_url"],
                }
              : {
                  "shopee": athleteLinks?["shopee"],
                  "tiktok": athleteLinks?["tiktok"],
                  "tokopedia": athleteLinks?["tokopedia"],
                },
        };

        if (athleteLinks?["code"] != null) applyCode();
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoading.value = false;
  }

  void selectImage(int index) => selectedImage.value = index;

  void openImageViewer() {
    Get.dialog(
      const ProductDetailImageViewerDialog(),
      barrierColor: MyColors.black,
      useSafeArea: false,
    );
  }

  void selectStock(Map<String, dynamic> value) {
    selectedStock.value = value;
    qty.value = 0;
  }

  void decrease() => qty.value > 0 ? qty.value-- : null;

  void increase() =>
      qty.value < selectedStock.value!["qty"] ? qty.value++ : null;

  void addToCart() {
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
          productBaseId: res["productBaseId"],
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

    showAddedToCartSnackbar(
      name: res["name"],
      color: res["color"],
      size: stock["size"],
      imageUrl: images.isEmpty ? null : images.first,
    );
  }

  void applyCode() async {
    final code = txtCode.text.trim();
    if (code.isEmpty) return;

    isValidatingCode.value = true;

    final box = GetStorage();
    final cart = box.read(MyConfig.keyCart) as Map<String, dynamic>?;

    final items = ((cart?["items"] as List?) ?? [])
        .map((e) => CartItemModel.fromJson(e))
        .toList();

    final productIds = [
      ...items.map((e) => e.productBaseId).whereType<String>(),
      res["productBaseId"] as String,
    ];

    final req = await athleteRepo.validateCode(code, productIds);
    await req.responseHandler(
      res: (data) {
        if (data == null) {
          showMyErrAPISnackbar({
            "message": "Kode athlete tidak valid untuk produk ini",
          });
          return;
        }

        final matched = (data["t_athlete"] as List)
            .map((e) => e["product_id"] as String)
            .toList();

        box.write(MyConfig.keyCart, {
          "items": items.map((e) => e.toJson()).toList(),
          "appliedCode": code,
          "discountProductIds": matched,
        });

        appliedCode.value = code;
        discountProductIds.value = matched;
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isValidatingCode.value = false;
  }
}
