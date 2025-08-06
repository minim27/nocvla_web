class LoginModel {
  dynamic id, access_token;

  LoginModel({this.id, this.access_token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    access_token = json["access_token"];
  }
}
