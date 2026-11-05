import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/data/models/collections/product_type_model.dart';
import 'package:nocvla_web/modules/collection/collection_controller.dart';
import 'package:nocvla_web/shared/utils/my_utility.dart';

import '../../app/core/base_controller.dart';
import '../../app/routes/my_routes.dart';

class MainLayoutController extends BaseController {
  final linkDiscord = "".obs;
  final resType = <ProductTypeModel>[].obs;
  final resMarketplace = <String, dynamic>{}.obs;
  final resShopType = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDiscordLink();
    fetchApiType();
    fetchApiMarketplace();
    fetchApiShopType();
  }

  void fetchDiscordLink() async {
    final req = await configRepo.getConfig("LINK_DISCORD");
    await req.responseHandler(
      res: (res) => linkDiscord.value = res["value"] ?? "",
      err: (err) {},
    );
  }

  void fetchApiType() async {
    final req = await collectionsRepo.productType();
    await req.responseHandler(
      res: (res) => resType.value = (res as List)
          .map((e) => ProductTypeModel.fromJson(e))
          .toList(),
      err: (err) {},
    );
  }

  void fetchApiMarketplace() async {
    final links = <String, dynamic>{};

    final reqProduct = await collectionsRepo.marketplaceLinks();
    await reqProduct.responseHandler(
      res: (res) => links.addAll(res?["product"] ?? {}),
      err: (err) {},
    );

    const keys = {
      "SHOPEE_URL": "shopee_url",
      "TIKTOK_SHOP_URL": "tiktok_url",
      "TOKOPEDIA_URL": "tokopedia_url",
    };

    final reqConfig = await configRepo.listConfigs(keys.keys.toList());
    await reqConfig.responseHandler(
      res: (res) {
        for (final row in res as List) {
          final value = "${row["value"] ?? ""}".trim();
          if (value.isNotEmpty) links[keys[row["name"]]!] = value;
        }
      },
      err: (err) {},
    );

    resMarketplace.value = links;
  }

  void fetchApiShopType() async {
    final req = await collectionsRepo.listProducts("");
    await req.responseHandler(
      res: (res) => resShopType.value = (res as List)
          .map((e) => "${e["product_type"]?["name"]}")
          .toSet()
          .toList(),
      err: (err) {},
    );
  }

  void openMarketplace(String key) {
    final url = resMarketplace[key];
    if (url != null) execUri(url);
  }

  void openEmail() => execUri("mailto:nocvla.apparel@gmail.com");

  void updateTitle() {
    final path = Uri.parse(Get.currentRoute).path;
    final title = switch (path) {
      MyRoutes.collection => "The Armory",
      MyRoutes.productDetail => "Produk",
      MyRoutes.athlete || MyRoutes.athleteDetail => "The Congregation",
      MyRoutes.about => "Tentang",
      MyRoutes.contact => "Kontak",
      MyRoutes.cart => "Keranjang",
      MyRoutes.search => "Pencarian",
      MyRoutes.earlyAccess => "Drop",
      _ => null,
    };

    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: title == null ? "NOCVLA" : "$title — NOCVLA",
      ),
    );
  }

  bool isActiveRoute(String route) =>
      Uri.parse(Get.currentRoute).path.startsWith(route);

  void openDiscordLink() => execUri(linkDiscord.value);

  void openCollection(String type) {
    final isRegistered = Get.isRegistered<CollectionController>();
    if (isRegistered) Get.find<CollectionController>().selectType(type);

    if (Uri.parse(Get.currentRoute).path == MyRoutes.collection) return;

    Get.toNamed(MyRoutes.collection, parameters: {"type": type});
  }
}
