import 'package:get/get.dart';

import 'my_password_controller.dart';

class MyPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPasswordController>(() => MyPasswordController());
  }
}
