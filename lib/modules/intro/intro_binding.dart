import 'package:get/get.dart';
import 'package:nocvla/modules/dashboard/dashboard_controller.dart';

class IntroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
