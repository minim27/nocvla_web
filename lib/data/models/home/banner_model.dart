class BannerModel {
  dynamic id,
      imageUrl,
      eyebrow,
      ctaProductId,
      title,
      description,
      startDate,
      endDate,
      sortOrder,
      isActive,
      createdAt,
      updatedAt;

  BannerModel({
    this.id,
    this.imageUrl,
    this.eyebrow,
    this.ctaProductId,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.sortOrder,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    imageUrl = json["image_url"];
    eyebrow = json["eyebrow"];
    ctaProductId = json["cta_product_id"];
    title = json["title"];
    description = json["description"];
    startDate = json["start_date"];
    endDate = json["end_date"];
    sortOrder = json["sort_order"];
    isActive = json["is_active"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }
}
