import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/app/routes/my_pages.dart';
import 'package:nocvla/app/routes/my_routes.dart';
import 'package:nocvla/shared/utils/my_colors.dart';

import 'app/services/my_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: MyColors.primary),
      initialRoute: (MyConfig.isCommingSoon)
          ? MyRoutes.intro
          : MyRoutes.dashboard,
      getPages: MyPages.routes,
    );
  }
}
