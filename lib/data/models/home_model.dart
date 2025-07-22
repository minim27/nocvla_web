class HomeModel {
  dynamic product1, product2, product3;

  HomeModel({this.product1, this.product2, this.product3});

  HomeModel.fromJson(Map<String, dynamic> json) {
    product1 = json["product1"];
    product2 = json["product2"];
    product3 = json["product3"];
  }
}
