class EarlyAccessStatusModel {
  dynamic isEarlyAccess, earlyAccessEndAt, updatedAt;

  EarlyAccessStatusModel({
    this.isEarlyAccess,
    this.earlyAccessEndAt,
    this.updatedAt,
  });

  EarlyAccessStatusModel.fromJson(Map<String, dynamic> json) {
    isEarlyAccess = json["is_early_access"];
    earlyAccessEndAt = json["early_access_end_at"];
    updatedAt = json["updated_at"];
  }
}
