import 'package:get/get.dart';

import 'faq_controller.dart';

class FAQBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FAQController>(() => FAQController());
  }
}
