import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nocvla_web/app/services/my_config.dart';
import 'package:nocvla_web/data/models/cart/cart_item_model.dart';
import 'package:flutter/services.dart';
import 'package:nocvla_web/data/models/collections/list_products_model.dart';
import 'package:nocvla_web/modules/product_detail/widgets/product_detail_image_viewer_dialog.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';

import '../../app/core/base_controller.dart';
import '../../app/routes/my_routes.dart';
import '../../shared/utils/my_utility.dart';

class ProductDetailController extends BaseController {
  final res = <String, dynamic>{}.obs;

  final resRelated = <ListProductsModel>[].obs;

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
    id.value = Get.parameters["color"] ?? Get.parameters["id"];
    athleteLinks = Get.arguments as Map<String, dynamic>?;
    if (athleteLinks != null) txtCode.text = athleteLinks?["code"] ?? "";
    fetchApiProduct();

    final cart = GetStorage().read(MyConfig.keyCart) as Map<String, dynamic>?;
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

    isLoading.value = res.isEmpty;

    final req = await collectionsRepo.getProduct(id.value!);
    await req.responseHandler(
      res: (data) {
        final product = data["product"];
        final stock = (data["stock"] as List)
            .map(
              (e) => {"size": e["size"], "qty": e["qty"], "price": e["price"]},
            )
            .toList();
        stock.sort(
          (a, b) => sizeRank(a["size"]).compareTo(sizeRank(b["size"])),
        );

        res.value = {
          "id": data["id"],
          "productBaseId": product["id"],
          "images": (data["images"] as List)
              .map((e) => e["image_url"])
              .toList(),
          "name": product["name"],
          "description": product["description"],
          "color": data["name"],
          "colors": (product["colors"] as List).map((c) {
            final images = c["images"] as List;

            return {
              "id": c["id"],
              "name": c["name"],
              "image_url": images.isEmpty ? null : images.first["image_url"],
            };
          }).toList(),
          "stock": stock,
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
        if (resRelated.isEmpty) fetchApiRelated(product);
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoading.value = false;
  }

  void fetchApiRelated(Map<String, dynamic> product) async {
    final type = product["product_type"]?["name"] ?? "";

    final req = await collectionsRepo.listProducts(type);
    await req.responseHandler(
      res: (data) {
        resRelated.value = (data as List)
            .where(
              (e) =>
                  e["id"] != product["id"] &&
                  ((e["colors"] as List?) ?? []).isNotEmpty,
            )
            .take(4)
            .map((e) {
              final color = (e["colors"] as List).first;
              final images = color["images"] as List;
              final prices = (color["stock"] as List)
                  .map((s) => s["price"] as int)
                  .toList();

              return ListProductsModel.fromJson({
                "id": color["id"],
                "product_id": e["id"],
                "name": e["name"],
                "image_url": images.isEmpty ? null : images.first["image_url"],
                "color": color["name"],
                "price": prices.isEmpty
                    ? 0
                    : prices.reduce((a, b) => a < b ? a : b),
                "stock": color["stock"],
              });
            })
            .toList();
      },
      err: (err) {},
    );
  }

  void selectColor(String colorId) {
    if (colorId == id.value) return;

    id.value = colorId;
    selectedImage.value = 0;
    selectedStock.value = null;
    qty.value = 0;
    fetchApiProduct();

    SystemNavigator.routeInformationUpdated(
      uri: Uri(
        path: MyRoutes.productDetail,
        queryParameters: {"id": colorId, "color": colorId},
      ),
    );
  }

  void openRelated(String colorId) =>
      Get.toNamed(MyRoutes.productDetail, parameters: {"id": colorId});

  void selectImage(int index) => selectedImage.value = index;

  void previousImage() {
    final length = (res["images"] as List).length;
    if (length > 0) {
      selectedImage.value = (selectedImage.value - 1 + length) % length;
    }
  }

  void nextImage() {
    final length = (res["images"] as List).length;
    if (length > 0) selectedImage.value = (selectedImage.value + 1) % length;
  }

  void openImageViewer() {
    Get.dialog(
      const ProductDetailImageViewerDialog(),
      barrierColor: MyColors.black,
      useSafeArea: false,
    );
  }

  void selectStock(Map<String, dynamic> value) {
    selectedStock.value = value;
    qty.value = 1;
  }

  void decrease() => qty.value > 1 ? qty.value-- : null;

  void increase() {
    if (selectedStock.value == null) return;
    if (qty.value < selectedStock.value!["qty"]) qty.value++;
  }

  bool validSelection() {
    if (selectedStock.value == null) {
      showMyErrAPISnackbar({"message": "Pilih ukuran terlebih dahulu"});
      return false;
    }

    if (qty.value <= 0) {
      showMyErrAPISnackbar({"message": "Masukkan jumlah qty terlebih dahulu"});
      return false;
    }

    return true;
  }

  CartItemModel selectedItem() {
    final images = res["images"] as List;
    final stock = selectedStock.value!;

    return CartItemModel(
      productId: res["id"],
      productBaseId: res["productBaseId"],
      name: res["name"],
      imageUrl: images.isEmpty ? null : images.first,
      color: res["color"],
      size: stock["size"],
      price: stock["price"],
      maxQty: stock["qty"],
      qty: qty.value,
    );
  }

  void orderNow() {
    if (saveToCart()) Get.toNamed(MyRoutes.checkout);
  }

  bool saveToCart() {
    if (!validSelection()) return false;

    final box = GetStorage();
    final data = box.read(MyConfig.keyCart) as Map<String, dynamic>?;

    final items = ((data?["items"] as List?) ?? [])
        .map((e) => CartItemModel.fromJson(e))
        .toList();

    final stock = selectedStock.value!;

    final existingIndex = items.indexWhere(
      (item) => item.productId == res["id"] && item.size == stock["size"],
    );

    if (existingIndex != -1) {
      final total = items[existingIndex].qty.value + qty.value;

      if (total > stock["qty"]) {
        showMyErrAPISnackbar({
          "message":
              "Stok ${res["name"]} ${res["color"]} ukuran ${stock["size"]} tidak cukup",
        });
        return false;
      }

      items[existingIndex].qty.value = total;
      items[existingIndex].maxQty = stock["qty"];
    } else {
      items.add(selectedItem());
    }

    box.write(MyConfig.keyCart, {
      "items": items.map((e) => e.toJson()).toList(),
      "appliedCode": data?["appliedCode"],
      "discountProductIds": data?["discountProductIds"] ?? [],
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => Get.appUpdate());

    return true;
  }

  void addToCart() {
    if (!saveToCart()) return;

    final images = res["images"] as List;

    showAddedToCartSnackbar(
      name: res["name"],
      color: res["color"],
      size: selectedStock.value!["size"],
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
