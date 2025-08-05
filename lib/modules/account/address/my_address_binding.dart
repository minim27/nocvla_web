import 'package:get/get.dart';
import 'package:nocvla/modules/account/address/my_address_controller.dart';

class MyAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAddressController>(() => MyAddressController());
  }
}
