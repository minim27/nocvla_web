import 'package:get/get.dart';

class CartItemModel {
  dynamic productId, productBaseId, name, imageUrl, color, size, price, maxQty;
  late RxInt qty;

  CartItemModel({
    this.productId,
    this.productBaseId,
    this.name,
    this.imageUrl,
    this.color,
    this.size,
    this.price,
    this.maxQty,
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
    maxQty = json["maxQty"];
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
    "maxQty": maxQty,
    "qty": qty.value,
  };
}
