import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/services/my_config.dart';
import '../widgets/my_text.dart';
import 'my_colors.dart';

void changeStatusBool(RxBool val) => val.toggle();

int getCartCount() {
  final data = GetStorage().read(MyConfig.keyCart) as Map<String, dynamic>?;
  final items = (data?["items"] as List?) ?? [];

  return items.fold<int>(0, (total, e) => total + ((e["qty"] as int?) ?? 0));
}

void execUri(String uri) {
  print(uri);
  launchUrl(.parse(uri));
}

void showMyErrAPISnackbar(dynamic err) {
  print(err);
  print(err["errors"] == null);

  Get.snackbar(
    (err["errors"] == null) ? "Oopsss..." : err["message"],
    (err["errors"] == null)
        ? (err["message"] ?? err["detail"])
        : "${err["errors"].first["field"]} ${err["errors"].first["message"]}",
    titleText: MyText(
      text: (err["errors"] == null) ? "Oopsss..." : err["message"],
      fontWeight: .w600,
      color: MyColors.white,
    ),
    messageText: MyText(
      text: (err["errors"] == null)
          ? (err["message"] ?? err["detail"])
          : "${err["errors"].first["field"]} ${err["errors"].first["message"]}",
      color: MyColors.white,
    ),
    backgroundColor: MyColors.red,
  );
}
