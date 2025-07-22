class HomeModel {
  dynamic availableDate, product1, product2, product3;

  HomeModel({this.availableDate, this.product1, this.product2, this.product3});

  HomeModel.fromJson(Map<String, dynamic> json) {
    availableDate = json["availableDate"];
    product1 = json["product1"];
    product2 = json["product2"];
    product3 = json["product3"];
  }
}
