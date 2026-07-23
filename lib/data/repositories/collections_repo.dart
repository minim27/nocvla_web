import '../../app/core/base_repository.dart';

class CollectionsRepo extends BaseRepository {
  Future<ResponseHandler<dynamic>> productType() async => ResponseHandler(
    supabase.from("m_product_type").select().eq('is_active', true),
  );

  Future<ResponseHandler<dynamic>> listProducts(String type) async {
    final query = type.isEmpty
        ? supabase.from("v_products").select()
        : supabase.from("v_products").select().eq("type", type);

    return ResponseHandler(query.order("name", ascending: true));
  }

  Future<ResponseHandler<dynamic>> getProduct(String id) async =>
      ResponseHandler(
        supabase
            .from("m_products")
            .select("*, images:m_product_images(*), stock:m_product_stock(*)")
            .eq("id", id)
            .order("sort_order", referencedTable: "images", ascending: true)
            .order("sort_order", referencedTable: "stock", ascending: true)
            .single(),
      );
}
