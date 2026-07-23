import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/my_text.dart';
import 'my_colors.dart';

void changeStatusBool(RxBool val) => val.toggle();

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
