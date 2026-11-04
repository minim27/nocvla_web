class EarlyAccessStatusModel {
  dynamic isEarlyAccess, earlyAccessEndAt;

  EarlyAccessStatusModel({this.isEarlyAccess, this.earlyAccessEndAt});

  EarlyAccessStatusModel.fromJson(Map<String, dynamic> json) {
    isEarlyAccess = json["is_early_access"];
    earlyAccessEndAt = json["early_access_end_at"];
  }
}
