import '../../app/core/base_repository.dart';

class CollectionsRepo extends BaseRepository {
  Future<ResponseHandler<dynamic>> productType() async => ResponseHandler(
    supabase.from("m_product_type").select().eq('is_active', true),
  );

  Future<ResponseHandler<dynamic>> listProducts(String type) async {
    final query = type.isEmpty
        ? supabase.from("v_products").select()
        : supabase.from("v_products").select().eq("type", type);

    return ResponseHandler(query);
  }
}
