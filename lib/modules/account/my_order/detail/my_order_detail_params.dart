class MyOrderDetailParams {
  dynamic id;

  MyOrderDetailParams({this.id});

  MyOrderDetailParams.fromMap(Map<String, String?> json) {
    id = json["id"];
  }
}
