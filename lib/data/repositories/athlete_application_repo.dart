import '../../app/core/base_repository.dart';

class AthleteApplicationRepo extends BaseRepository {
  Future<ResponseHandler<dynamic>> submitApplication({
    required String name,
    required String email,
    required String phone,
    required String instagramUsername,
    required String tiktokUsername,
    required String city,
    required String reason,
  }) async => ResponseHandler(
    supabase.from("m_athlete_application").insert({
      "name": name,
      "email": email,
      "phone": phone,
      "instagram_username": instagramUsername,
      "tiktok_username": tiktokUsername,
      "city": city,
      "reason": reason,
    }),
  );
}
