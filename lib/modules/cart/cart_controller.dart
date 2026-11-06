import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nocvla_web/app/routes/my_routes.dart';
import 'package:nocvla_web/app/services/my_config.dart';
import 'package:nocvla_web/data/models/cart/cart_item_model.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final resWa = <String, String>{}.obs;
  final isShowMessage = false.obs;
  final isPlacingOrder = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
    fetchApiWa();
  }

  void fetchApiWa() async {
    final req = await configRepo.listConfigs(["WA_NUMBER", "WA_TEMPLATE"]);
    await req.responseHandler(
      res: (res) {
        resWa.value = {
          for (final e in (res as List))
            if ("${e["value"] ?? ""}".trim().isNotEmpty)
              "${e["name"]}": "${e["value"]}".trim(),
        };
      },
      err: (err) {},
    );
  }

  String get waNumber => resWa["WA_NUMBER"] ?? MyConfig.whatsappNumber;

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

  int get totalQty => resItems.fold(0, (total, item) => total + item.qty.value);

  void decrease(RxInt val) {
    if (val.value > 1) {
      val.value--;
      refreshSubtotal.value++;
      saveCart();
      refreshCartBadge();
    }
  }

  void increase(CartItemModel item) {
    if (item.maxQty != null && item.qty.value >= item.maxQty) return;

    item.qty.value++;
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
    await req.responseHandler(
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

  void continueShopping() => Get.toNamed(MyRoutes.collection);

  void toggleMessage() => isShowMessage.toggle();

  String buildMessage() => buildOrderMessage(
    template: resWa["WA_TEMPLATE"],
    items: resItems,
    code: appliedCode.value,
    discount: discountAmount,
  );

  Future<void> placeOrder() async {
    if (resItems.isEmpty || isPlacingOrder.value) return;

    isPlacingOrder.value = true;

    final req = await orderRepo.createOrder(
      items: resItems
          .map(
            (item) => {
              "color_id": item.productId,
              "size": item.size,
              "qty": item.qty.value,
            },
          )
          .toList(),
      athleteCode: appliedCode.value,
    );
    await req.responseHandler(
      res: (res) {
        final message = "Kode order: ${res["code"]}\n\n${buildMessage()}";

        resItems.clear();
        removeCode();
        refreshCartBadge();

        launchUrl(
          .parse(
            "https://wa.me/$waNumber?text=${Uri.encodeComponent(message)}",
          ),
          webOnlyWindowName: "_blank",
        );
      },
      err: (err) {
        final stock = RegExp(
          r"Stok .+? tidak cukup",
        ).stringMatch(err["message"]);

        showMyErrAPISnackbar({
          "message": stock ?? "Order gagal dikirim, silakan coba lagi",
        });
      },
    );

    isPlacingOrder.value = false;
  }
}
