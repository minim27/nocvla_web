class ListProductsModel {
  dynamic
  id,
  name,
  imageUrl,
  type,
  color,
  price,
  linkAffShopee,
  linkAffTktkshop,
  linkAffTokped;

  ListProductsModel({
    this.id,
    this.name,
    this.imageUrl,
    this.type,
    this.color,
    this.price,
    this.linkAffShopee,
    this.linkAffTktkshop,
    this.linkAffTokped,
  });

  ListProductsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    imageUrl = json["image_url"];
    type = json["type"];
    color = json["color"];
    price = json["price"] ?? 0;
    linkAffShopee = json["link_aff_shopee"];
    linkAffTktkshop = json["link_aff_tktkshop"];
    linkAffTokped = json["link_aff_tokped"];
  }
}
