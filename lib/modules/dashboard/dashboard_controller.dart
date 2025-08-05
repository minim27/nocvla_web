import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/app/services/my_config.dart';
import 'package:nocvla/modules/dashboard/dashboard_params.dart';
import 'package:nocvla/shared/utils/my_audios.dart';
import 'package:nocvla/shared/utils/my_getstorage.dart';
import 'package:nocvla/shared/widgets/my_text.dart';

import '../../app/routes/my_routes.dart';
import '../../data/models/order/cart_model.dart';
import '../../shared/utils/my_utility.dart';
import '../home/home_page.dart';
import '../../app/core/base_controller.dart';

class DashboardController extends BaseController {
  var resCart = <CartModel>[];

  List<Map<String, dynamic>> menuDashboard = [
    {"title": "Home Page".tr},
  ];

  List<Widget> pageList = [HomePage()];

  var currentIndex = 0.obs;

  var isLoading = false.obs;

  final AudioPlayer _player = AudioPlayer();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments == null) {
      currentIndex.value = 0;
    } else {
      final DashboardParams params = DashboardParams.fromMap(Get.parameters);
      currentIndex.value = params.index;
    }

    fetchApi();
  }

  fetchApi() async {
    isLoading.value = true;

    var reqCart = await orderRepo.listCart();
    await reqCart.responseHandler(
      res: (res) {
        List<CartModel> result = [];

        for (var data in res["data"]["items"]) {
          result.add(CartModel.fromJson(data));
        }

        resCart.assignAll(result);
      },
      err: (err) => showErrSnackbar(msg: err),
    );

    isLoading.value = false;
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _initAudio() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource(MyAudios.audBG), volume: 1);
  }

  void enterSite() async {
    await _initAudio();
    Get.offAllNamed(MyRoutes.dashboard, parameters: {"index": "0"});
  }

  void changeMenuSelected({required int idx}) => currentIndex.value = idx;

  Future<void> tapAccount(context, {required TapDownDetails details}) async {
    var token = await MyGetStorage.getString(key: MyConfig.keyAccessToken);

    if (token == null) return;

    RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final selected = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        details.globalPosition & Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          child: MyText(text: "Change Profile"),
          onTap: () => Get.toNamed(MyRoutes.myProfile),
        ),
        PopupMenuItem(
          child: MyText(text: "Change Password"),
          onTap: () => Get.toNamed(MyRoutes.updatePassword),
        ),
        PopupMenuItem(
          child: MyText(text: "Change Address"),
          onTap: () => Get.toNamed(MyRoutes.myAddress),
        ),
        PopupMenuItem(
          child: MyText(text: "My Order"),
          onTap: () => Get.toNamed(MyRoutes.myOrder),
        ),
        PopupMenuItem(
          child: MyText(text: "Logout"),
          onTap: () => null,
        ),
      ],
    );

    if (selected == 'edit') {
      // Aksi edit
    } else if (selected == 'delete') {
      // Aksi delete
    }
  }
}
