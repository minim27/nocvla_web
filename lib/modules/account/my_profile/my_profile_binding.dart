import 'package:get/get.dart';
import 'package:nocvla/modules/account/my_profile/my_profile_controller.dart';

class MyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyProfileController>(() => MyProfileController());
  }
}
