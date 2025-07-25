import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nocvla/app/core/base_controller.dart';
import 'package:nocvla/data/models/product_detail_model.dart';
import 'package:nocvla/modules/product/product_detail_params.dart';
import 'package:nocvla/shared/utils/my_utility.dart';

class ProductDetailController extends BaseController {
  var res = <ProductDetailModel>[];

  var isLoading = false.obs;

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
    await req.responseHandler(
      res: (res) => this.res.add(ProductDetailModel.fromJson(res["data"])),
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

  void addToCart() => null;

  void orderNow() => null;
}
