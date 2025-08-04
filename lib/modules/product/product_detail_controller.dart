import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nocvla/app/core/base_controller.dart';
import 'package:nocvla/app/routes/my_routes.dart';
import 'package:nocvla/data/models/product_detail_model.dart';
import 'package:nocvla/modules/product/product_detail_params.dart';
import 'package:nocvla/shared/utils/my_utility.dart';

import '../../data/models/order/cart_model.dart';

class ProductDetailController extends BaseController {
  var res = <ProductDetailModel>[];
  var resCart = <CartModel>[];

  var isLoading = false.obs;
  var isLoadingAction = false.obs;

  var selectedGallery = 0.obs;
  var selectedSize = 0.obs;
  var selectedColor = 0.obs;
  var selectedPrint = 0.obs;

  var txtQty = TextEditingController(text: "1");

  @override
  void onInit() {
    super.onInit();
    final ProductDetailParams params = ProductDetailParams.fromMap(
      Get.parameters,
    );
    fetchApi(slug: params.slug);
  }

  void fetchApi({required String slug}) async {
    isLoading.value = true;

    var req = await productRepo.detailProduct(slug: slug);
    var reqCart = await orderRepo.listCart();

    await req.responseHandler(
      res: (res) => this.res.add(ProductDetailModel.fromJson(res["data"])),
      err: (err) => showErrSnackbar(msg: err),
    );
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

  void selectImage({required int index}) => selectedGallery.value = index;

  void selectSize({required int index}) {
    selectedSize.value = index;
    selectedColor.value = 0;
    selectedPrint.value = 0;
  }

  void selectColor({required int index}) {
    selectedColor.value = index;
    selectedPrint.value = 0;
  }

  void selectPrint({required int index}) => selectedPrint.value = index;

  void decreaseQty() {
    int qty = int.tryParse(txtQty.text) ?? 1;
    if (qty > 1) txtQty.text = "${qty - 1}";
  }

  void increaseQty() {
    int qty = int.tryParse(txtQty.text) ?? 1;
    txtQty.text = "${qty + 1}";
  }

  void addToCart({required ProductDetailModel res}) async {
    isLoadingAction.value = true;

    var req = await orderRepo.addToCart(
      data: {
        "product_id": res.id,
        "variation_id": res.variation[selectedSize.value]["id"],
        "color_id": res
            .variation[selectedSize.value]["color"][selectedColor.value]["id"],
        "print_id":
            res.variation[selectedSize.value]["color"][selectedColor
                .value]["print"][selectedPrint.value]["id"],
        "qty": txtQty.text,
        "note": "",
      },
    );
    await req.responseHandler(
      res: (res) => showSnackbar(msg: res["message"]),
      err: (err) => showErrSnackbar(msg: err),
    );
    isLoadingAction.value = false;
  }

  void orderNow() => Get.toNamed(MyRoutes.checkout);
}
