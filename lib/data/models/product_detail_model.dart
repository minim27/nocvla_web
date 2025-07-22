class ProductDetailModel {
  dynamic id, name, image, gallery, price, description, variations;

  ProductDetailModel({
    this.id,
    this.name,
    this.image,
    this.gallery,
    this.price,
    this.description,
    this.variations,
  });

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
    gallery = json["gallery"];
    price = json["price"];
    description = json["description"];
    variations = json["variations"];
  }
}
