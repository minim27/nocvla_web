import 'package:get/get.dart';

import 'my_order_detail_controller.dart';

class MyOrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyOrderDetailController>(() => MyOrderDetailController());
  }
}
