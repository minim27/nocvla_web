import '../../app/core/base_repository.dart';

class ConfigRepo extends BaseRepository {
  Future<ResponseHandler<dynamic>> getConfig(String name) async =>
      ResponseHandler(
        supabase.from("m_configurations").select().eq("name", name).single(),
      );

  Future<ResponseHandler<dynamic>> listConfigs(List<String> names) async =>
      ResponseHandler(
        supabase.from("m_configurations").select().inFilter("name", names),
      );
}
