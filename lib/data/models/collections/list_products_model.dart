class ListProductsModel {
  dynamic id,
      productId,
      name,
      imageUrl,
      type,
      color,
      price,
      stock,
      colors,
      badge,
      subtitle,
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
    this.colors,
    this.badge,
    this.subtitle,
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
    colors = json["colors"];
    badge = json["badge"];
    subtitle = json["subtitle"];
    linkAffShopee = json["link_aff_shopee"];
    linkAffTktkshop = json["link_aff_tktkshop"];
    linkAffTokped = json["link_aff_tokped"];
  }

  int get totalQty => ((stock as List?) ?? []).fold(
    0,
    (total, e) => total + ((e["qty"] as int?) ?? 0),
  );
}
