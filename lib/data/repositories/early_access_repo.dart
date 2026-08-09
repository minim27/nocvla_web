import '../../app/core/base_repository.dart';

class EarlyAccessRepo extends BaseRepository {
  Future<ResponseHandler<dynamic>> status() async => ResponseHandler(
    supabase.from("v_early_access_status").select().maybeSingle(),
  );

  Future<ResponseHandler<dynamic>> images() async => ResponseHandler(
    supabase
        .from("m_early_access_images")
        .select()
        .order("sort_order", ascending: true),
  );

  Future<ResponseHandler<dynamic>> checkPassword(String password) async =>
      ResponseHandler(
        supabase.rpc(
          "check_early_access_password",
          params: {"input_password": password},
        ),
      );
}
