import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/routes/my_routes.dart';
import '../../app/services/my_config.dart';
import '../widgets/my_image.dart';
import '../widgets/my_text.dart';
import 'my_colors.dart';

void changeStatusBool(RxBool val) => val.toggle();

int getCartCount() {
  final data = GetStorage().read(MyConfig.keyCart) as Map<String, dynamic>?;
  final items = (data?["items"] as List?) ?? [];

  return items.fold<int>(0, (total, e) => total + ((e["qty"] as int?) ?? 0));
}

void execUri(String uri) {
  print(uri);
  launchUrl(.parse(uri));
}

void showAddedToCartSnackbar({
  required String name,
  required String color,
  required String size,
  String? imageUrl,
}) {
  Get.snackbar(
    "",
    "",
    titleText: SizedBox.shrink(),
    messageText: Container(
      padding: .symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: MyColors.white.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            behavior: .opaque,
            onTap: () => Get.closeAllSnackbars(),
            child: Icon(Icons.close, color: MyColors.white2, size: 20),
          ),
          Expanded(
            child: Column(
              spacing: 12,
              children: [
                MyText(
                  text: "$name [$color]",
                  textAlign: .center,
                  fontWeight: .w600,
                  color: MyColors.white,
                ),
                MyText(
                  text: "$size / $color   •   ADDED TO CART",
                  textAlign: .center,
                  fontSize: 12,
                  color: MyColors.white2,
                ),
                SizedBox(
                  width: 64,
                  height: 64,
                  child: MyImage(imageUrl, fit: .cover),
                ),
              ],
            ),
          ),
          GestureDetector(
            behavior: .opaque,
            onTap: () {
              Get.closeAllSnackbars();
              Get.toNamed(MyRoutes.cart);
            },
            child: MyText(
              text: "VIEW CART",
              fontWeight: .w600,
              color: MyColors.white2,
            ),
          ),
        ],
      ),
    ),
    backgroundColor: MyColors.black,
    snackPosition: SnackPosition.TOP,
    margin: EdgeInsets.zero,
    borderRadius: 0,
    padding: EdgeInsets.zero,
    duration: const Duration(seconds: 4),
  );
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
