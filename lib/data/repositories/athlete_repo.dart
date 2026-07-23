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
              "created_at, m_products(id, name, color, "
              "images:m_product_images(image_url, sort_order), "
              "stock:m_product_stock(price))",
            )
            .eq("athlete_id", athleteId)
            .order(
              "sort_order",
              referencedTable: "m_products.images",
              ascending: true,
            )
            .order("created_at", ascending: false),
      );

  Future<ResponseHandler<dynamic>> validateCode(
    String code,
    List<String> productIds,
  ) async => ResponseHandler(
    supabase
        .from("m_athlete")
        .select("id, code, t_athlete!inner(product_id)")
        .eq("code", code)
        .inFilter("t_athlete.product_id", productIds)
        .maybeSingle(),
  );
}
