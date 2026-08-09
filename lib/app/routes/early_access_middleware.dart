import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/early_access/early_access_controller.dart';

import 'my_routes.dart';

class EarlyAccessMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route == MyRoutes.earlyAccess) return null;

    final controller = Get.find<EarlyAccessController>();
    if (controller.isGated.value) {
      return const RouteSettings(name: MyRoutes.earlyAccess);
    }

    return null;
  }
}
