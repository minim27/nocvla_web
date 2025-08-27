class ProductDetailModel {
  dynamic id,
      name,
      slug,
      description,
      gallery,
      urlShopee,
      urlTiktokshop,
      urlTokped,
      variation;

  ProductDetailModel({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.gallery,
    this.urlShopee,
    this.urlTiktokshop,
    this.urlTokped,
    this.variation,
  });

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["alias_name"];
    slug = json["slug"];
    description = json["description"];
    gallery = json["gallery"];
    urlShopee = json["url_shopee"];
    urlTiktokshop = json["url_tiktokshop"];
    urlTokped = json["url_tokped"];
    variation = json["variation"];
  }
}
