class AthleteModel {
  dynamic id, picture, code, name, products;

  AthleteModel({this.id, this.picture, this.code, this.name, this.products});

  AthleteModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    picture = json["picture"];
    code = json["code"];
    name = json["name"];
    products = (json["t_athlete"] as List?)?.map((e) => e["product"]).toList();
  }
}
