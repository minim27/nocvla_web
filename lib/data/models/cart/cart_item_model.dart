import 'package:get/get.dart';

class CartItemModel {
  dynamic productId, productBaseId, name, imageUrl, color, size, price;
  late RxInt qty;

  CartItemModel({
    this.productId,
    this.productBaseId,
    this.name,
    this.imageUrl,
    this.color,
    this.size,
    this.price,
    int qty = 1,
  }) {
    this.qty = qty.obs;
  }

  CartItemModel.fromJson(Map<String, dynamic> json) {
    productId = json["productId"];
    productBaseId = json["productBaseId"];
    name = json["name"];
    imageUrl = json["imageUrl"];
    color = json["color"];
    size = json["size"];
    price = json["price"];
    qty = ((json["qty"] ?? 1) as int).obs;
  }

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productBaseId": productBaseId,
    "name": name,
    "imageUrl": imageUrl,
    "color": color,
    "size": size,
    "price": price,
    "qty": qty.value,
  };
}
