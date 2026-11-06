import '../../app/core/base_repository.dart';

class ContactRepo extends BaseRepository {
  Future<ResponseHandler<dynamic>> listFaqs() async => ResponseHandler(
    supabase
        .from("m_faq")
        .select("question, answer")
        .eq("is_active", true)
        .order("sort_order", ascending: true),
  );

  Future<ResponseHandler<dynamic>> listTopics() async => ResponseHandler(
    supabase
        .from("m_contact_topic")
        .select("name")
        .eq("is_active", true)
        .order("sort_order", ascending: true)
        .order("name", ascending: true),
  );

  Future<ResponseHandler<dynamic>> submitMessage({
    required String name,
    required String contact,
    String? topic,
    required String message,
  }) async => ResponseHandler(
    supabase.from("t_contact_messages").insert({
      "name": name,
      "contact": contact,
      "topic": ?topic,
      "message": message,
    }),
  );
}
