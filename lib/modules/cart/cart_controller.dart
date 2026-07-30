import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nocvla_web/app/routes/my_routes.dart';
import 'package:nocvla_web/app/services/my_config.dart';
import 'package:nocvla_web/data/models/cart/cart_item_model.dart';

import '../../app/core/base_controller.dart';
import '../../shared/utils/my_utility.dart';

class CartController extends BaseController {
  final box = GetStorage();

  final resItems = <CartItemModel>[].obs;

  final txtCode = TextEditingController();
  final appliedCode = RxnString();
  final discountProductIds = <String>[].obs;

  final isValidatingCode = false.obs;
  final refreshSubtotal = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() {
    final data = box.read(MyConfig.keyCart) as Map<String, dynamic>?;

    resItems.value = ((data?["items"] as List?) ?? [])
        .map((e) => CartItemModel.fromJson(e))
        .toList();
    appliedCode.value = data?["appliedCode"];
    discountProductIds.value = List<String>.from(
      data?["discountProductIds"] ?? [],
    );
  }

  void saveCart() {
    box.write(MyConfig.keyCart, {
      "items": resItems.map((e) => e.toJson()).toList(),
      "appliedCode": appliedCode.value,
      "discountProductIds": discountProductIds,
    });
  }

  int get subTotal => resItems.fold(
    0,
    (total, item) => total + (item.price as int) * item.qty.value,
  );

  int get discountAmount {
    if (appliedCode.value == null) return 0;

    final anchorTotal = resItems
        .where((item) => discountProductIds.contains(item.productBaseId))
        .fold(0, (total, item) => total + (item.price as int) * item.qty.value);

    return (anchorTotal * 0.08).round();
  }

  int get total => subTotal - discountAmount;

  void decrease(RxInt val) {
    if (val.value > 1) {
      val.value--;
      refreshSubtotal.value++;
      saveCart();
      refreshCartBadge();
    }
  }

  void increase(RxInt val) {
    val.value++;
    refreshSubtotal.value++;
    saveCart();
    refreshCartBadge();
  }

  void removeItem(String productId, String size) {
    resItems.removeWhere(
      (item) => item.productId == productId && item.size == size,
    );

    final stillValid = resItems.any(
      (item) => discountProductIds.contains(item.productBaseId),
    );

    if (!stillValid) removeCode();

    saveCart();
    refreshCartBadge();
  }

  void removeCode() {
    appliedCode.value = null;
    discountProductIds.clear();
    txtCode.clear();
    saveCart();
  }

  void refreshCartBadge() =>
      WidgetsBinding.instance.addPostFrameCallback((_) => Get.appUpdate());

  void applyCode() async {
    final code = txtCode.text.trim();
    if (code.isEmpty) return;

    isValidatingCode.value = true;

    final productIds = resItems
        .map((e) => e.productBaseId)
        .whereType<String>()
        .toList();
    final req = await athleteRepo.validateCode(code, productIds);
    req.responseHandler(
      res: (res) {
        if (res == null) {
          showMyErrAPISnackbar({
            "message": "Kode athlete tidak valid untuk produk di cart ini",
          });
          return;
        }

        final matched = (res["t_athlete"] as List)
            .map((e) => e["product_id"] as String)
            .toList();

        appliedCode.value = code;
        discountProductIds.value = matched;
        txtCode.clear();
        saveCart();
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isValidatingCode.value = false;
  }

  void checkout() => Get.toNamed(MyRoutes.checkout);
}
