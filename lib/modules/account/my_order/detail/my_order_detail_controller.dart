import 'package:get/get.dart';
import 'package:nocvla/data/models/me/my_order_detail_model.dart';
import 'package:nocvla/modules/account/my_order/detail/my_order_detail_params.dart';

import '../../../../app/core/base_controller.dart';
import '../../../../shared/utils/my_utility.dart';

class MyOrderDetailController extends BaseController {
  var res = <MyOrderDetailModel>[];

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchApi();
  }

  fetchApi() async {
    isLoading.value = true;

    MyOrderDetailParams params = MyOrderDetailParams.fromMap(Get.parameters);

    var req = await myOrderRepo.myOrderDetail(id: int.parse(params.id));
    await req.responseHandler(
      res: (res) => this.res.add(MyOrderDetailModel.fromJson(res["data"])),
      err: (err) => showErrSnackbar(msg: err),
    );
    isLoading.value = false;
  }
}
