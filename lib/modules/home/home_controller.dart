import 'package:get/get.dart';
import 'package:nocvla_web/data/models/collections/list_products_model.dart';
import 'package:nocvla_web/data/models/home/banner_model.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';
import 'package:nocvla_web/shared/utils/my_utility.dart';

import '../../app/core/base_controller.dart';
import '../../app/routes/my_routes.dart';

class HomeController extends BaseController {
  final resBanners = <BannerModel>[].obs;
  final resFeatured = <ListProductsModel>[].obs;

  final resBenefits = <String, dynamic>{
    "benefits1": [
      {
        "icon": MyIcons.icPerformance,
        "label": "PERFORMANCE",
        "desc": "Engineered to move",
      },
      {
        "icon": MyIcons.icComfort,
        "label": "COMFORT",
        "desc": "All-day comfort",
      },
      {"icon": MyIcons.icDurable, "label": "DURABLE", "desc": "Built to last"},
      {
        "icon": MyIcons.icFocus,
        "label": "FOCUS",
        "desc": "Train without distractions",
      },
    ],
    "benefits2": [
      {
        "icon": MyIcons.icShipping,
        "label": "FREE SHIPPING",
        "desc": "Fast worldwide delivery",
      },
      {
        "icon": MyIcons.icPayment,
        "label": "SECURE PAYMENT",
        "desc": "100% secure payment",
      },
      {
        "icon": MyIcons.icReturns,
        "label": "EASY RETURNS",
        "desc": "Quick, hassle-free",
      },
      {
        "icon": MyIcons.icSupport,
        "label": "SUPPORT",
        "desc": "24/7 customer support",
      },
    ],
  };

  final isLoadingBanners = false.obs;
  final isLoadingFeatured = false.obs;

  @override
  void onInit() {
    super.onInit();
    // fetchApiBanner();
    fetchApiFeatured();
  }

  void fetchApiBanner() async {
    isLoadingBanners.value = true;

    final req = await homeRepo.banners();
    req.responseHandler(
      res: (res) {
        resBanners.value = (res as List).map((e) {
          // print(e);
          return BannerModel.fromJson(e);
        }).toList();
      },
      err: (err) => showMyErrAPISnackbar(err),
    );
    isLoadingBanners.value = false;
  }

  void fetchApiFeatured() async {
    isLoadingFeatured.value = true;

    final req = await homeRepo.featuredProducts();
    req.responseHandler(
      res: (res) {
        resFeatured.value = (res as List).map((e) {
          final images = e["images"] as List;
          final mainImage = images.isEmpty
              ? null
              : images.firstWhere(
                  (img) => img["is_main"] == true,
                  orElse: () => images.first,
                );

          final prices = (e["stock"] as List)
              .map((s) => s["price"] as int)
              .toList();
          final minPrice = prices.isEmpty
              ? 0
              : prices.reduce((a, b) => a < b ? a : b);

          return ListProductsModel.fromJson({
            "id": e["id"],
            "name": e["name"],
            "image_url": mainImage?["image_url"],
            "color": e["color"],
            "price": minPrice,
          });
        }).toList();
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingFeatured.value = false;
  }

  void openDetail(String id) =>
      Get.toNamed(MyRoutes.productDetail, parameters: {"id": id});
}
