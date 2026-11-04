import '../../app/core/base_repository.dart';

class CollectionsRepo extends BaseRepository {
  Future<ResponseHandler<dynamic>> productType() async => ResponseHandler(
    supabase
        .from("m_product_type")
        .select()
        .eq('is_active', true)
        .order("sort_order", ascending: true)
        .order("name", ascending: true),
  );

  Future<ResponseHandler<dynamic>> listProducts(String type) async {
    final base = supabase
        .from("m_products")
        .select(
          "id, name, product_type:m_product_type!inner(name), "
          "colors:m_product_color(id, name, "
          "images:m_product_images(image_url, sort_order), "
          "stock:m_product_stock(size, qty, price, sort_order))",
        );

    final query = type.isEmpty ? base : base.eq("product_type.name", type);

    return ResponseHandler(
      query
          .order(
            "sort_order",
            referencedTable: "colors.images",
            ascending: true,
          )
          .order("sort_order", referencedTable: "colors.stock", ascending: true)
          .order("name", referencedTable: "colors", ascending: true)
          .order("name", ascending: true),
    );
  }

  Future<ResponseHandler<dynamic>> getProduct(
    String id,
  ) async => ResponseHandler(
    supabase
        .from("m_product_color")
        .select(
          "*, product:m_products(*, product_type:m_product_type(name), colors:m_product_color(id, name, "
          "images:m_product_images(image_url, sort_order))), "
          "images:m_product_images(*), stock:m_product_stock(*)",
        )
        .eq("id", id)
        .order("sort_order", referencedTable: "images", ascending: true)
        .order("sort_order", referencedTable: "stock", ascending: true)
        .order("name", referencedTable: "product.colors", ascending: true)
        .order(
          "sort_order",
          referencedTable: "product.colors.images",
          ascending: true,
        )
        .single(),
  );
}
