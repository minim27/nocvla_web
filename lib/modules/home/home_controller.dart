import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/data/models/athlete/athlete_model.dart';
import 'package:nocvla_web/data/models/collections/list_products_model.dart';
import 'package:nocvla_web/data/models/home/banner_model.dart';
import 'package:nocvla_web/modules/main_layout/main_layout_controller.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/utils/my_utility.dart';

import '../../app/core/base_controller.dart';
import '../../app/routes/my_routes.dart';
import '../../app/services/my_config.dart';

class HomeController extends BaseController {
  final resBanners = <BannerModel>[].obs;
  final resFeatured = <ListProductsModel>[].obs;
  final resAthlete = <AthleteModel>[].obs;
  final resTypeImages = <String, dynamic>{}.obs;
  final resCategories = <Map<String, dynamic>>[].obs;
  final resSeries = <Map<String, dynamic>>[].obs;

  final heroPage = PageController();
  final heroIndex = 0.obs;
  Timer? _heroTimer;

  final athletePage = PageController();
  final athleteIndex = 0.obs;
  Timer? _athleteTimer;
  final productColorIds = <String, String>{};

  final resBenefits = <Map<String, dynamic>>[
    {"label": "FREE PRODUCT", "desc": "Dapatkan produk eksklusif."},
    {"label": "AFFILIATE ACCESS", "desc": "Keuntungan dari setiap penjualan."},
    {"label": "KOMUNITAS", "desc": "Gabung komunitas NOCVLA di Discord."},
    {"label": "GROW TOGETHER", "desc": "Bertumbuh bersama NOCVLA."},
  ];

  final isLoadingFeatured = false.obs;
  final isLoadingBanner = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchApiBanner();
    fetchApiProducts();
    fetchApiSeries();
    fetchApiAthlete();
  }

  void fetchApiBanner() async {
    final req = await homeRepo.banners();
    await req.responseHandler(
      res: (res) {
        resBanners.value = (res as List)
            .map((e) => BannerModel.fromJson(e))
            .toList();
        _startHeroTimer();
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingBanner.value = false;
  }

  void _startHeroTimer() {
    _heroTimer?.cancel();
    if (resBanners.length < 2) return;

    _heroTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => selectHero((heroIndex.value + 1) % resBanners.length),
    );
  }

  void selectHero(int index) {
    if (!heroPage.hasClients) return;

    heroPage.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void tapHeroDot(int index) {
    selectHero(index);
    _startHeroTimer();
  }

  void onHeroChanged(int index) => heroIndex.value = index;

  void fetchApiProducts() async {
    isLoadingFeatured.value = true;

    final types = <String>[];

    final reqType = await collectionsRepo.productType();
    await reqType.responseHandler(
      res: (res) => types.addAll((res as List).map((e) => "${e["name"]}")),
      err: (err) => showMyErrAPISnackbar(err),
    );

    final req = await collectionsRepo.listProducts("");
    await req.responseHandler(
      res: (res) {
        final products = (res as List)
            .where((e) => ((e["colors"] as List?) ?? []).isNotEmpty)
            .toList();

        buildCategories(products, types);
        buildFeatured(products);

        for (final e in products) {
          productColorIds["${e["id"]}"] = (e["colors"] as List).first["id"];
        }
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingFeatured.value = false;
  }

  void buildCategories(List products, List<String> types) {
    final images = <String, dynamic>{};
    final names = <String, Set<String>>{};

    for (final e in products) {
      final type = e["product_type"]?["name"];

      names.putIfAbsent(type, () => {}).add(seriesName("${e["name"]}"));
      images.putIfAbsent(type, () => firstImage(e["colors"].first));
    }

    resTypeImages.value = images;
    resCategories.value = [
      for (final type in types)
        if (names.containsKey(type))
          {
            "label": "$type".capitalize,
            "desc": names[type]!.take(2).join(" · "),
            "type": type,
          },
    ];
  }

  void fetchApiSeries() async {
    final req = await homeRepo.series();
    await req.responseHandler(
      res: (res) => resSeries.value = (res as List).map((e) {
        final colors = (e["product"]?["colors"] as List?) ?? [];

        return {
          "label": e["label"],
          "title": e["title"],
          "desc": e["description"] ?? "",
          "image_url": e["image_url"],
          "id": colors.isEmpty ? null : colors.first["id"],
        };
      }).toList(),
      err: (err) => showMyErrAPISnackbar(err),
    );
  }

  void buildFeatured(List products) {
    final items = products.where((e) => e["is_featured"] == true).toList()
      ..sort((a, b) => "${a["name"]}".compareTo("${b["name"]}"));

    resFeatured.value = items.map((e) {
      final colors = (e["colors"] as List).map((c) {
        return {
          "id": c["id"],
          "name": c["name"],
          "swatch": MyColors.hex(c["hex"]),
        };
      }).toList();

      final prices = (e["colors"] as List)
          .expand((c) => c["stock"] as List)
          .map((s) => s["price"] as int)
          .toList();

      return ListProductsModel.fromJson({
        "id": colors.first["id"],
        "product_id": e["id"],
        "name": e["name"],
        "image_url": firstImage((e["colors"] as List).first),
        "type": "${e["product_type"]?["name"]}".capitalize,
        "price": prices.isEmpty ? 0 : prices.reduce((a, b) => a < b ? a : b),
        "colors": colors,
        "badge": e["badge"],
      });
    }).toList();
  }

  String? firstImage(dynamic color) {
    final images = color["images"] as List;

    return images.isEmpty ? null : images.first["image_url"];
  }

  String seriesName(String name) => name
      .replaceAll("VENOM TECH™ ", "")
      .replaceAll(RegExp(r" (Long Sleeve|Short Sleeve|Oversized T Shirt)$"), "")
      .toUpperCase();

  void fetchApiAthlete() async {
    final req = await athleteRepo.listAthlete();
    await req.responseHandler(
      res: (res) {
        resAthlete.value =
            (res as List).map((e) => AthleteModel.fromJson(e)).toList()
              ..sort((a, b) {
                if (a.picture == null) return 1;
                if (b.picture == null) return -1;
                return 0;
              });
        _startAthleteTimer();
      },
      err: (err) => showMyErrAPISnackbar(err),
    );
  }

  void _startAthleteTimer() {
    _athleteTimer?.cancel();
    if (resAthlete.length < 2) return;

    _athleteTimer = Timer.periodic(
      const Duration(seconds: 4),
      (_) => selectAthlete((athleteIndex.value + 1) % resAthlete.length),
    );
  }

  void selectAthlete(int index) {
    if (!athletePage.hasClients) return;

    athletePage.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void tapAthleteDot(int index) {
    selectAthlete(index);
    _startAthleteTimer();
  }

  void onAthleteChanged(int index) => athleteIndex.value = index;

  void openDetail(String id) =>
      Get.toNamed(MyRoutes.productDetail, parameters: {"id": id});

  void openDrop(BannerModel banner) {
    final id = productColorIds["${banner.ctaProductId}"];
    if (id == null) return openCollection();

    openDetail(id);
  }

  void openCollection() => Get.toNamed(MyRoutes.collection);

  void openAthlete() => Get.toNamed(MyRoutes.athlete);

  void openApplication() =>
      Get.toNamed(MyRoutes.athlete, parameters: {"join": "1"});

  void openCategory(String? type) {
    if (type == null) return;

    Get.find<MainLayoutController>().openCollection(type);
  }

  @override
  void onClose() {
    _heroTimer?.cancel();
    heroPage.dispose();
    _athleteTimer?.cancel();
    athletePage.dispose();
    super.onClose();
  }

  void orderViaWhatsapp() =>
      execUri("https://wa.me/${MyConfig.whatsappNumber}");
}
