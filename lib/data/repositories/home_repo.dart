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

  Future<ResponseHandler<dynamic>> featuredProducts() async => ResponseHandler(
    supabase
        .from("m_products")
        .select(
          "id, name, colors:m_product_color(id, name, "
          "images:m_product_images(image_url, sort_order), "
          "stock:m_product_stock(price))",
        )
        .eq("is_featured", true)
        .order("sort_order", referencedTable: "colors.images", ascending: true)
        .order("name", referencedTable: "colors", ascending: true)
        .order("name", ascending: true),
  );
}
