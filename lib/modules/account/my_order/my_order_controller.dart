import 'package:get/get.dart';
import 'package:nocvla/app/routes/my_routes.dart';
import 'package:nocvla/data/models/me/my_order_model.dart';
import 'package:nocvla/shared/utils/my_utility.dart';

import '../../../app/core/base_controller.dart';

class MyOrderController extends BaseController {
  var res = <MyOrderModel>[];

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchApi();
  }

  fetchApi() async {
    isLoading.value = true;
    var req = await myOrderRepo.myOrder();
    await req.responseHandler(
      res: (res) {
        for (var data in res["data"]) {
          this.res.add(MyOrderModel.fromJson(data));
        }
      },
      err: (err) => showErrSnackbar(msg: err),
    );
    isLoading.value = false;
  }

  openDetail({required MyOrderModel res}) =>
      Get.toNamed(MyRoutes.myOrderDetail, parameters: {"id": "${res.id}"});
}
