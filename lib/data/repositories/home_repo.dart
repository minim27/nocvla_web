import '../../app/core/base_repository.dart';

class HomeRepo extends BaseRepository {
  Future<ResponseHandler<dynamic>> banners() async {
    final now = DateTime.now().toIso8601String();

    return ResponseHandler(
      supabase
          .from("m_banners")
          .select()
          .eq('is_active', true)
          .lte('start_date', now)
          .gte('end_date', now),
    );
  }

  Future<ResponseHandler<dynamic>> featuredProducts() async =>
      ResponseHandler(supabase.from("v_product_features").select());
}
