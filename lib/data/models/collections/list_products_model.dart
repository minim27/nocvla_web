class ListProductsModel {
  dynamic
  id,
  productId,
  name,
  imageUrl,
  type,
  color,
  price,
  stock,
  linkAffShopee,
  linkAffTktkshop,
  linkAffTokped;

  ListProductsModel({
    this.id,
    this.productId,
    this.name,
    this.imageUrl,
    this.type,
    this.color,
    this.price,
    this.stock,
    this.linkAffShopee,
    this.linkAffTktkshop,
    this.linkAffTokped,
  });

  ListProductsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productId = json["product_id"];
    name = json["name"];
    imageUrl = json["image_url"];
    type = json["type"];
    color = json["color"];
    price = json["price"] ?? 0;
    stock = json["stock"];
    linkAffShopee = json["link_aff_shopee"];
    linkAffTktkshop = json["link_aff_tktkshop"];
    linkAffTokped = json["link_aff_tokped"];
  }
}
