import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/data/models/athlete/athlete_model.dart';
import 'package:nocvla_web/data/models/collections/list_products_model.dart';
import 'package:nocvla_web/data/models/home/banner_model.dart';
import 'package:nocvla_web/modules/main_layout/main_layout_controller.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';
import 'package:nocvla_web/shared/utils/my_utility.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';

import '../../app/core/base_controller.dart';
import '../../app/routes/my_routes.dart';
import '../../app/services/my_config.dart';

class HomeController extends BaseController {
  final resBanners = <BannerModel>[].obs;
  final resFeatured = <ListProductsModel>[].obs;
  final resAthlete = <AthleteModel>[].obs;
  final resTypeImages = <String, dynamic>{}.obs;

  final resCategories = <Map<String, dynamic>>[].obs;

  final resBenefits = <Map<String, dynamic>>[
    {
      "icon": MyIcons.icShirt,
      "label": "FREE PRODUCT",
      "desc": "Dapatkan produk eksklusif",
    },
    {
      "icon": MyIcons.icLink,
      "label": "AFFILIATE ACCESS",
      "desc": "Dapatkan keuntungan dari hasil penjualan",
    },
    {
      "icon": MyIcons.icCommunity,
      "label": "EXCLUSIVE COMMUNITY",
      "desc": "Gabung dengan komunitas NOCVLA",
    },
    {
      "icon": MyIcons.icUp,
      "label": "GROW TOGETHER",
      "desc": "Bertumbuh bersama NOCVLA",
    },
  ];

  final isLoadingFeatured = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchApiBanner();
    fetchApiFeatured();
    fetchApiCategories();
    fetchApiAthlete();
  }

  void fetchApiBanner() async {
    final req = await homeRepo.banners();
    await req.responseHandler(
      res: (res) => resBanners.value = (res as List)
          .map((e) => BannerModel.fromJson(e))
          .toList(),
      err: (err) => showMyErrAPISnackbar(err),
    );
  }

  void fetchApiFeatured() async {
    isLoadingFeatured.value = true;

    final req = await homeRepo.featuredProducts();
    await req.responseHandler(
      res: (res) {
        resFeatured.value = (res as List)
            .where((e) {
              return ((e["colors"] as List?) ?? []).isNotEmpty;
            })
            .map((e) {
              final colors = (e["colors"] as List).map((c) {
                final images = c["images"] as List;

                return {
                  "id": c["id"],
                  "name": c["name"],
                  "image_url": images.isEmpty
                      ? null
                      : images.first["image_url"],
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
                "image_url": colors.first["image_url"],
                "price": prices.isEmpty
                    ? 0
                    : prices.reduce((a, b) => a < b ? a : b),
                "colors": colors,
              });
            })
            .toList();
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingFeatured.value = false;
    preloadHero();
  }

  void fetchApiCategories() async {
    final types = <String>[];

    final reqType = await collectionsRepo.productType();
    await reqType.responseHandler(
      res: (res) => types.addAll((res as List).map((e) => "${e["name"]}")),
      err: (err) => showMyErrAPISnackbar(err),
    );

    final req = await collectionsRepo.listProducts("");
    await req.responseHandler(
      res: (res) {
        final images = <String, dynamic>{};
        final names = <String, List<String>>{};

        for (final e in res as List) {
          final type = e["product_type"]?["name"];
          final colors = (e["colors"] as List?) ?? [];
          if (colors.isEmpty) continue;

          names.putIfAbsent(type, () => []).add("${e["name"]}");
          if (images.containsKey(type)) continue;

          final colorImages = colors.first["images"] as List;
          if (colorImages.isNotEmpty) {
            images[type] = colorImages.first["image_url"];
          }
        }

        resTypeImages.value = images;
        resCategories.value = [
          for (final type in types)
            if (names.containsKey(type))
              {
                "label": type,
                "desc": names[type]!.take(2).join(" · "),
                "type": type,
              },
          if (!types.contains("ACCESSORIES"))
            {"label": "ACCESSORIES", "desc": "Segera hadir", "type": null},
        ];
      },
      err: (err) => showMyErrAPISnackbar(err),
    );
  }

  void fetchApiAthlete() async {
    final req = await athleteRepo.listAthlete();
    await req.responseHandler(
      res: (res) => resAthlete.value = (res as List)
          .map((e) => AthleteModel.fromJson(e))
          .toList(),
      err: (err) => showMyErrAPISnackbar(err),
    );
  }

  void preloadHero() {
    final image = heroImage;
    final context = Get.context;
    if (image == null || context == null) return;

    precacheImage(CachedNetworkImageProvider(myImageUrl(image)), context);
  }

  String? get heroImage => resBanners.isNotEmpty
      ? resBanners.first.imageUrl
      : resFeatured.firstOrNull?.imageUrl;

  String get heroTitle =>
      resBanners.firstOrNull?.title ?? "BUILT DIFFERENT.\nTRAIN NOCVLA.";

  String get heroDesc =>
      resBanners.firstOrNull?.description ??
      "Performance gear designed for discipline, focus, and progress.";

  void openDetail(String id) =>
      Get.toNamed(MyRoutes.productDetail, parameters: {"id": id});

  void openCollection() => Get.toNamed(MyRoutes.collection);

  void openAthlete() => Get.toNamed(MyRoutes.athlete);

  void openAthleteDetail(String id) =>
      Get.toNamed(MyRoutes.athleteDetail, parameters: {"id": id});

  void openCategory(String? type) {
    if (type == null) return;

    Get.find<MainLayoutController>().openCollection(type);
  }

  void orderViaWhatsapp() =>
      execUri("https://wa.me/${MyConfig.whatsappNumber}");
}
