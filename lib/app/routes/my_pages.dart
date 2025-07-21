import 'package:get/get.dart';
import 'package:nocvla/app/routes/my_routes.dart';
import 'package:nocvla/modules/dashboard/dashboard_binding.dart';
import 'package:nocvla/modules/dashboard/dashboard_page.dart';
import 'package:nocvla/modules/home/home_binding.dart';
import 'package:nocvla/modules/home/home_page.dart';
import 'package:nocvla/modules/intro/intro_binding.dart';
import 'package:nocvla/modules/intro/intro_page.dart';

class MyPages {
  static final routes = [
    GetPage(
      name: MyRoutes.dashboard,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: MyRoutes.intro,
      page: () => IntroPage(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: MyRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
