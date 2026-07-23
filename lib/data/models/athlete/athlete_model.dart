class AthleteModel {
  dynamic id, picture, code, name;

  AthleteModel({this.id, this.picture, this.code, this.name});

  AthleteModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    picture = json["picture"];
    code = json["code"];
    name = json["name"];
  }
}
