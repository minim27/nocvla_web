class ProductTypeModel {
  dynamic id,
      name,
      isActive,
      value,
      sortOrder,
      createdAt,
      updatedAt;

  ProductTypeModel({
    this.id,
    this.name,
    this.isActive,
    this.value,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  ProductTypeModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    isActive = json["is_active"];
    value = json["value"];
    sortOrder = json["sort_order"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }
}
