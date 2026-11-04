import '../../app/core/base_repository.dart';

class OrderRepo extends BaseRepository {
  Future<ResponseHandler<dynamic>> createOrder({
    required List<Map<String, dynamic>> items,
    String? athleteCode,
    String? customerName,
    String? customerPhone,
    String? address,
  }) async => ResponseHandler(
    supabase.rpc(
      "create_wa_order",
      params: {
        "p_items": items,
        "p_athlete_code": athleteCode,
        "p_customer_name": customerName,
        "p_customer_phone": customerPhone,
        "p_address": address,
      },
    ),
  );
}
