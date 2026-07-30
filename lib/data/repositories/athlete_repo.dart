import '../../app/core/base_repository.dart';

class AthleteRepo extends BaseRepository {
  Future<ResponseHandler<dynamic>> listAthlete() async =>
      ResponseHandler(supabase.from("m_athlete").select());

  Future<ResponseHandler<dynamic>> getAthlete(String id) async =>
      ResponseHandler(
        supabase.from("m_athlete").select().eq("id", id).single(),
      );

  Future<ResponseHandler<dynamic>> assignedProducts(String athleteId) async =>
      ResponseHandler(
        supabase
            .from("t_athlete")
            .select(
              "created_at, product:m_products(id, name, "
              "colors:m_product_color(id, name, "
              "images:m_product_images(image_url, sort_order), "
              "stock:m_product_stock(price)))",
            )
            .eq("athlete_id", athleteId)
            .order(
              "sort_order",
              referencedTable: "product.colors.images",
              ascending: true,
            )
            .order("name", referencedTable: "product.colors", ascending: true)
            .order("created_at", ascending: false),
      );

  Future<ResponseHandler<dynamic>> validateCode(
    String code,
    List<String> productIds,
  ) async {
    final result = await supabase
        .from("m_athlete")
        .select("id, code, t_athlete!inner(product_id)")
        .eq("code", code)
        .inFilter("t_athlete.product_id", productIds)
        .maybeSingle();

    print(result);

    return ResponseHandler(Future.value(result));
  }
}
