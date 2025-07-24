import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nocvla/app/core/base_controller.dart';
import 'package:nocvla/data/models/product_detail_model.dart';
import 'package:nocvla/modules/product/product_detail_params.dart';

class ProductDetailController extends BaseController {
  dynamic json = {
    "success": true,
    "message": "OK",
    "data": {
      "id": 1,
      "name": "ArchMage Compressed Premium",
      "slug": "archmage-compressed-premium",
      "gallery": [
        "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
        "https://i.scdn.co/image/ab67616d0000b27323a8321bd17fe693210812fe",
        "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
        "https://i.scdn.co/image/ab67616d0000b27323a8321bd17fe693210812fe",
        "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
        "https://i.scdn.co/image/ab67616d0000b27323a8321bd17fe693210812fe",
      ],
      "price": {
        "default": 259000,
        "regular": 289000,
        "sale": 259000,
        "discount": 10,
      },
      "description": [
        "Compressed Material",
        "Tight yet breathable fabric",
        "Sculpted fit for performance",
        "Moisture-wicking technology",
        "Reinforced stitches for durability",
        "Dark aesthetic design",
        "Made for intensity",
      ],
      "variations": [
       {
          "size": "M",
          "colors": [
            {
              "name": "Hitam",
              "hex": "#111111",
              "prints": [
                {
                  "primary": "#111111",
                  "secondary": "#7E44C3",
                  "stock": 10,
                },
                {
                  "primary": "#111111",
                  "secondary": "#8A0303",
                  "stock": 10,
                },
                {
                  "primary": "#111111",
                  "secondary": "#5BCEFA",
                  "stock": 10,
                },
              ],
            },
            {
              "id": 1,
              "name": "White",
              "hex": "#f9f9f9",
              "prints": [
                {
                  "id": 1,
                  "primary": "#111111",
                  "secondary": "#7E44C3",
                  "stock": 10,
                },
              ],
            },
            {
              "id": 1,
              "name": "Red",
              "hex": "#a10319",
              "prints": [
                {
                  "id": 1,
                  "primary": "#111111",
                  "secondary": "#7E44C3",
                  "stock": 10,
                },
              ],
            },
            {
              "id": 1,
              "name": "Army",
              "hex": "#364934",
              "prints": [
                {
                  "id": 1,
                  "primary": "#111111",
                  "secondary": "#7E44C3",
                  "stock": 10,
                },
              ],
            },
          ],
        },
        {
          "id": 1,
          "size": "L",
          "colors": [
            {
              "id": 1,
              "name": "Hitam",
              "hex": "#111111",
              "prints": [
                {
                  "id": 1,
                  "primary": "#111111",
                  "secondary": "#7E44C3",
                  "stock": 10,
                },
                {
                  "id": 1,
                  "primary": "#111111",
                  "secondary": "#8A0303",
                  "stock": 10,
                },
                {
                  "id": 1,
                  "primary": "#111111",
                  "secondary": "#5BCEFA",
                  "stock": 10,
                },
              ],
            },
            {
              "id": 1,
              "name": "White",
              "hex": "#f9f9f9",
              "prints": [
                {
                  "id": 1,
                  "primary": "#111111",
                  "secondary": "#7E44C3",
                  "stock": 10,
                },
              ],
            },
            {
              "id": 1,
              "name": "Red",
              "hex": "#a10319",
              "prints": [
                {
                  "id": 1,
                  "primary": "#111111",
                  "secondary": "#7E44C3",
                  "stock": 10,
                },
              ],
            },
            {
              "id": 1,
              "name": "Army",
              "hex": "#364934",
              "prints": [
                {
                  "id": 1,
                  "primary": "#111111",
                  "secondary": "#7E44C3",
                  "stock": 10,
                },
              ],
            },
          ],
        },
      ],
    },
  };

  var res = <ProductDetailModel>[];

  var isLoading = false.obs;

  var selectedGallery = 0.obs;
  var selectedSize = 0.obs;
  var selectedColor = Rxn<int>();
  var selectedPrint = Rxn<int>();

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

    res.add(ProductDetailModel.fromJson(json["data"]));

    isLoading.value = false;
  }

  void selectImage({required int index}) => selectedGallery.value = index;
  void selectSize({required int index}) {
    selectedSize.value = index;
    selectedColor.value = null;
    selectedPrint.value = null;
  }

  void selectColor({required int index}) {
    selectedColor.value = index;
    selectedPrint.value = null;
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
