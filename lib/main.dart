import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/my_pages.dart';
import 'app/routes/my_routes.dart';
import 'modules/main_layout/main_layout.dart';
import 'shared/utils/my_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env["API_URL"]!,
    publishableKey: dotenv.env["SUPABASE_KEY"],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: MyColors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: MyColors.black,
          surfaceTintColor: MyColors.black,
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: MyColors.black,
          surfaceTintColor: MyColors.black,
        ),
      ),
      initialRoute: MyRoutes.home,
      getPages: MyPages.routes,
      routingCallback: (_) => Get.appUpdate(),
      builder: (context, child) => MainLayout(child: child!),
    );
  }
}
