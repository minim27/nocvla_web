import '../../app/core/base_repository.dart';

class HomeRepo extends BaseRepository {
  Future<ResponseHandler<dynamic>> banners() async {
    final now = DateTime.now().toUtc().toIso8601String();

    return ResponseHandler(
      supabase
          .from("m_banners")
          .select()
          .eq('is_active', true)
          .lte('start_date', now)
          .gte('end_date', now)
          .order("sort_order", ascending: true),
    );
  }

  Future<ResponseHandler<dynamic>> series() async => ResponseHandler(
    supabase
        .from("m_series")
        .select("*, product:m_products(colors:m_product_color(id))")
        .eq("is_active", true)
        .order("sort_order", ascending: true),
  );
}
