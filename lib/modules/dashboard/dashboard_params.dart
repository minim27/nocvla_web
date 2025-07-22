class DashboardParams {
  dynamic index;

  DashboardParams({this.index});

  DashboardParams.fromMap(Map<String, String?> json) {
    index = json["index"];
  }
}
