import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/my_pages.dart';
import 'app/routes/my_routes.dart';
import 'app/services/my_config.dart';
import 'modules/early_access/early_access_controller.dart';
import 'modules/main_layout/main_layout.dart';
import 'modules/main_layout/main_layout_controller.dart';
import 'shared/utils/my_colors.dart';
import 'shared/utils/my_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await GetStorage.init();

  await Supabase.initialize(
    url: MyConfig.apiUrl,
    publishableKey: MyConfig.supabaseKey,
  );

  final earlyAccessController = Get.put(
    EarlyAccessController(),
    permanent: true,
  );
  await earlyAccessController.init();

  Get.put(MainLayoutController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: MyFonts.archivo,
        colorScheme: const .dark(
          primary: MyColors.white,
          onPrimary: MyColors.black,
          secondary: MyColors.white,
          onSecondary: MyColors.black,
          surface: MyColors.black2,
          onSurface: MyColors.white,
          error: MyColors.redText,
        ),
        scaffoldBackgroundColor: MyColors.black,
        dividerTheme: const DividerThemeData(color: MyColors.line),
        dialogTheme: const DialogThemeData(
          backgroundColor: MyColors.black2,
          surfaceTintColor: MyColors.black2,
          shape: RoundedRectangleBorder(),
        ),
        drawerTheme: const DrawerThemeData(
          shape: RoundedRectangleBorder(),
          endShape: RoundedRectangleBorder(),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: MyColors.white,
          selectionColor: MyColors.red.withValues(alpha: 0.4),
        ),
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
      title: "NOCVLA",
      routingCallback: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.find<MainLayoutController>().updateTitle();
        Get.appUpdate();
      }),
      builder: (context, child) => MainLayout(child: child!),
    );
  }
}
