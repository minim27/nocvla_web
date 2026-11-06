import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/services/my_config.dart';
import '../../data/models/cart/cart_item_model.dart';
import '../widgets/my_text.dart';
import 'my_colors.dart';
import 'my_parsing_currency.dart';

void changeStatusBool(RxBool val) => val.toggle();

String buildOrderMessage({
  String? template,
  required List<CartItemModel> items,
  String? code,
  int discount = 0,
}) {
  final subTotal = items.fold(
    0,
    (total, item) => total + (item.price as int) * item.qty.value,
  );
  final values = {
    "nama penerima": "",
    "wa penerima": "",
    "alamat penerima": "",
    "notes": "",
    "kode": code ?? "",
    "subtotal": parsingCurrency(subTotal),
    "diskon": discount > 0 ? parsingCurrency(discount) : "",
    "total": parsingCurrency(subTotal - discount),
  };

  if (template == null) {
    return [
      "Halo NOCVLA, saya mau order:",
      for (final item in items)
        "• ${item.name} — ${"${item.color}".capitalize} / ${item.size} × ${item.qty.value}",
      "Subtotal: ${values["subtotal"]}",
      if (discount > 0) "Diskon ($code): - ${values["diskon"]}",
      if (discount > 0) "Total: ${values["total"]}",
      if (code != null) "Kode atlet: $code",
    ].join("\n");
  }

  const itemKeys = {"item", "warna", "ukuran", "qty", "harga"};
  final placeholder = RegExp(r"\{([^}]+)\}");

  String fill(String line, Map<String, String> data) => line.replaceAllMapped(
    placeholder,
    (m) => data[m.group(1)!.trim().toLowerCase()] ?? m.group(0)!,
  );

  final lines = <String>[];
  for (final line in template.split("\n")) {
    final keys = placeholder
        .allMatches(line)
        .map((m) => m.group(1)!.trim().toLowerCase())
        .toList();

    if (keys.any(itemKeys.contains)) {
      for (final item in items) {
        lines.add(
          fill(line, {
            ...values,
            "item": "${item.name}",
            "warna": "${item.color}".capitalize ?? "",
            "ukuran": "${item.size}",
            "qty": "${item.qty.value}",
            "harga": parsingCurrency((item.price as int) * item.qty.value),
          }),
        );
      }
      continue;
    }

    if (keys.any((key) => values[key]?.isEmpty ?? false)) continue;

    lines.add(fill(line, values));
  }

  return lines.join("\n").trim();
}

int sizeRank(String size) {
  const sizes = ["XXS", "XS", "S", "M", "L", "XL", "XXL", "XXXL"];
  final rank = sizes.indexOf(size.toUpperCase());

  return rank == -1 ? sizes.length : rank;
}

int getCartCount() {
  final data = GetStorage().read(MyConfig.keyCart) as Map<String, dynamic>?;
  final items = (data?["items"] as List?) ?? [];

  return items.fold<int>(0, (total, e) => total + ((e["qty"] as int?) ?? 0));
}

void execUri(String uri) {
  launchUrl(.parse(uri));
}

void showMySnackbar(String title, String message) => Get.snackbar(
  title,
  message,
  titleText: MyText(text: title, fontWeight: .w600, color: MyColors.black),
  messageText: MyText(text: message, color: MyColors.black),
  backgroundColor: MyColors.white,
  borderRadius: 0,
);

void showMyErrAPISnackbar(dynamic err) {
  print(err);
  print(err["errors"] == null);

  Get.snackbar(
    (err["errors"] == null) ? "Oopsss..." : err["message"],
    (err["errors"] == null)
        ? (err["message"] ?? err["detail"])
        : "${err["errors"].first["field"]} ${err["errors"].first["message"]}",
    titleText: MyText(
      text: (err["errors"] == null) ? "Oopsss..." : err["message"],
      fontWeight: .w600,
      color: MyColors.nativeWhite,
    ),
    messageText: MyText(
      text: (err["errors"] == null)
          ? (err["message"] ?? err["detail"])
          : "${err["errors"].first["field"]} ${err["errors"].first["message"]}",
      color: MyColors.nativeWhite,
    ),
    backgroundColor: MyColors.red,
    borderRadius: 0,
  );
}
