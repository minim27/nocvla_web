import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../app/core/base_repository.dart';

class AthleteApplicationRepo extends BaseRepository {
  Future<ResponseHandler<dynamic>> listTrainingFocus() async => ResponseHandler(
    supabase
        .from("m_training_focus")
        .select("name")
        .eq("is_active", true)
        .order("sort_order", ascending: true)
        .order("name", ascending: true),
  );

  Future<ResponseHandler<dynamic>> checkLimit({required String phone}) async =>
      ResponseHandler(
        supabase.rpc("application_limit_ok", params: {"p_phone": phone}),
      );

  Future<ResponseHandler<dynamic>> uploadPhoto({
    required String path,
    required Uint8List bytes,
    required String contentType,
  }) async => ResponseHandler(
    supabase.storage
        .from("applications")
        .uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(contentType: contentType),
        ),
  );

  Future<ResponseHandler<dynamic>> submitApplication({
    required String name,
    required String phone,
    required String instagramUsername,
    required String city,
    required String reason,
    String? trainingFocus,
    String? photoPath,
  }) async => ResponseHandler(
    supabase.from("m_athlete_application").insert({
      "name": name,
      "phone": phone,
      "instagram_username": instagramUsername,
      "city": city,
      "training_focus": ?trainingFocus,
      "reason": reason,
      "photo_path": ?photoPath,
    }),
  );
}
