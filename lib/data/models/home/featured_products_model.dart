class FeaturedProductsModel {
  dynamic id, productId, name, imageUrl, type, color, price;

  FeaturedProductsModel({
    this.id,
    this.productId,
    this.name,
    this.imageUrl,
    this.type,
    this.color,
    this.price,
  });

  FeaturedProductsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productId = json["product_id"];
    name = json["name"];
    imageUrl = json["image_url"];
    type = json["type"];
    color = json["color"];
    price = json["price"] ?? 0;
  }
}
