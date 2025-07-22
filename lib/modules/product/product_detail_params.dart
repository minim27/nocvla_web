class ProductDetailParams {
  dynamic slug;

  ProductDetailParams({this.slug});

  ProductDetailParams.fromMap(Map<String, String?> json) {
    slug = json["slug"];
  }
}
