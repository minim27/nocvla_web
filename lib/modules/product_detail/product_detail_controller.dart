import 'package:get/get.dart';
import 'package:nocvla_web/app/routes/my_routes.dart';
import 'package:nocvla_web/shared/utils/my_dummies.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';

import '../../app/core/base_controller.dart';

class ProductDetailController extends BaseController {
  final res = <String, dynamic>{
    "id": "123",
    "images": [
      MyDummies.dumBaju,
      MyDummies.dumBaju,
      MyDummies.dumBaju,
      MyDummies.dumBaju,
      MyDummies.dumBaju,
    ],
    "name": "VENOM TECH™ Prototype I Compression",
    "description":
        "Dirancang untuk performa maksimal, bahan premium yang nyaman, breathable dan mendukung dalam setiap performa.",
    "color": "IRON STEEL",
    "stock": [
      {"size": "M", "qty": 2, "price": 249000},
      {"size": "L", "qty": 5, "price": 249000},
      {"size": "XL", "qty": 2, "price": 249000},
      {"size": "XXL", "qty": 10, "price": 269000},
    ],
    "features": [
      {"icon": MyIcons.icStretch, "label": "4 Way Stretch"},
      {"icon": MyIcons.icQuickDry, "label": "Quick Dry"},
      {"icon": MyIcons.icBreathable, "label": "Breathable Fabric"},
      {"icon": MyIcons.icPerformance, "label": "Performance Fit"},
    ],
    "links": {"shopee": null, "tiktok": null, "tokopedia": null},
  };

  final resOrderBy = <Map<String, dynamic>>[{}];

  final id = RxnString();
  final selectedImage = 0.obs;
  final selectedStock = Rxn<Map<String, dynamic>>();

  final qty = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    id.value = Get.parameters["id"];
  }

  void selectImage(int index) => selectedImage.value = index;

  void selectStock(Map<String, dynamic> value) => selectedStock.value = value;

  void decrease() => qty.value > 0 ? qty.value-- : null;

  void increase() =>
      qty.value < selectedStock.value!["qty"] ? qty.value++ : null;

  void openCart() => Get.toNamed(MyRoutes.cart);
}
