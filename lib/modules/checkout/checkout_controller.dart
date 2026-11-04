import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nocvla_web/data/models/cart/cart_item_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/core/base_controller.dart';
import '../../app/services/my_config.dart';
import '../../shared/utils/my_parsing_currency.dart';
import '../../shared/utils/my_utility.dart';

class CheckoutController extends BaseController {
  final box = GetStorage();

  final resItems = <CartItemModel>[].obs;
  final appliedCode = RxnString();
  final discountProductIds = <String>[].obs;
  final isPlacingOrder = false.obs;

  final txtName = TextEditingController();
  final txtPhone = TextEditingController();
  final txtAddress = TextEditingController();
  // final txtCity = TextEditingController();
  // final txtPostalCode = TextEditingController();
  final txtNotes = TextEditingController();

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

  bool validOrder() {
    if (txtName.text.trim().isEmpty ||
        txtPhone.text.trim().isEmpty ||
        txtAddress.text.trim().isEmpty) {
      showMyErrAPISnackbar({
        "message": "Nama, No HP/WA, dan alamat wajib diisi",
      });
      return false;
    }

    if (resItems.isEmpty) {
      showMyErrAPISnackbar({"message": "Keranjang kamu masih kosong"});
      return false;
    }

    return true;
  }

  Future<void> placeOrder() async {
    if (!validOrder() || isPlacingOrder.value) return;

    isPlacingOrder.value = true;
    String? code;

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
      customerName: txtName.text.trim(),
      customerPhone: txtPhone.text.trim(),
      address: txtAddress.text.trim(),
    );
    await req.responseHandler(res: (res) => code = res["code"], err: (err) {});

    isPlacingOrder.value = false;

    final message = code == null
        ? buildMessage()
        : "Kode order: $code\n\n${buildMessage()}";

    launchUrl(
      .parse(
        "https://wa.me/${MyConfig.whatsappNumber}?text=${Uri.encodeComponent(message)}",
      ),
      webOnlyWindowName: "_self",
    );
  }

  void placeOrderViaInstagram() {
    if (!validOrder()) return;

    Clipboard.setData(ClipboardData(text: buildMessage()));
    showMySnackbar("Disalin", "Rincian order disalin, tinggal paste di DM");
    execUri("https://ig.me/m/${MyConfig.instagramUsername}");
  }

  void placeOrderViaTiktok() {
    if (!validOrder()) return;

    Clipboard.setData(ClipboardData(text: buildMessage()));
    showMySnackbar("Disalin", "Rincian order disalin, tinggal paste di DM");
    execUri("https://www.tiktok.com/@${MyConfig.tiktokUsername}");
  }

  String buildMessage() {
    final buffer = StringBuffer()
      ..writeln("Halo, saya mau order:")
      ..writeln();

    for (final item in resItems) {
      buffer.writeln(
        "- ${item.name} (${item.color}, ${item.size}) x${item.qty.value} "
        "= ${parsingCurrency((item.price as int) * item.qty.value)}",
      );
    }

    buffer
      ..writeln()
      ..writeln("Subtotal: ${parsingCurrency(subTotal)}");

    if (appliedCode.value != null) {
      buffer.writeln(
        "Diskon (${appliedCode.value}): - ${parsingCurrency(discountAmount)}",
      );
    }

    buffer
      ..writeln("Total: ${parsingCurrency(total)}")
      ..writeln()
      ..writeln("Nama Penerima: ${txtName.text.trim()}")
      ..writeln("No HP/WA Penerima: ${txtPhone.text.trim()}")
      ..writeln("Alamat Lengkap: ${txtAddress.text.trim()}");

    if (txtNotes.text.trim().isNotEmpty) {
      buffer.write("Catatan: ${txtNotes.text.trim()}");
    }

    return buffer.toString();
  }
}
