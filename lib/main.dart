import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nocvla/app/routes/my_pages.dart';
import 'package:nocvla/app/routes/my_routes.dart';
import 'package:nocvla/shared/utils/my_colors.dart';

import 'app/services/my_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [ChuckerFlutter.navigatorObserver],
      theme: ThemeData(
        scaffoldBackgroundColor: MyColors.primary,
        appBarTheme: AppBarTheme(
          backgroundColor: MyColors.primary,
          surfaceTintColor: MyColors.primary,
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: MyColors.primary,
          surfaceTintColor: MyColors.primary,
        ),
      ),
      initialRoute: (MyConfig.isCommingSoon)
          ? MyRoutes.intro
          : MyRoutes.dashboard,
      // initialRoute: MyRoutes.myOrder,
      getPages: MyPages.routes,
      // home: const AgoraPage(),
    );
  }
}
