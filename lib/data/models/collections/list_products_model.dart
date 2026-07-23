class ListProductsModel {
  dynamic id, name, imageUrl, type, color, price;

  ListProductsModel({
    this.id,
    this.name,
    this.imageUrl,
    this.type,
    this.color,
    this.price,
  });

  ListProductsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    imageUrl = json["image_url"];
    type = json["type"];
    color = json["color"];
    price = json["price"] ?? 0;
  }
}
