import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/home_page.dart';
import '../base_controller.dart';

class DashboardController extends BaseController {
  List<Map<String, dynamic>> menuDashboard = [
    {"title": "Home Page".tr},
  ];

  List<Widget> pageList = [HomePage()];

  var currentIndex = Rxn<int>();

  void changeMenuSelected({required int idx}) => currentIndex.value = idx;
}
