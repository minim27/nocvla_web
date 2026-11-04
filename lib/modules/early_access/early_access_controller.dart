import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nocvla_web/data/models/early_access/early_access_image_model.dart';
import 'package:nocvla_web/data/models/early_access/early_access_status_model.dart';
import 'package:nocvla_web/shared/utils/my_utility.dart';

import '../../app/core/base_controller.dart';
import '../../app/routes/my_routes.dart';
import '../../app/services/my_config.dart';

class EarlyAccessController extends BaseController {
  final isGated = false.obs;
  final isSubmitting = false.obs;
  final images = <EarlyAccessImageModel>[].obs;
  final remaining = Duration.zero.obs;

  final passwordController = TextEditingController();
  final box = GetStorage();

  bool isActive = false;

  DateTime? _endAt;
  String? _version;
  Timer? _ticker;

  @override
  void onInit() {
    super.onInit();
    ever(isGated, (gated) {
      if (!gated && Get.currentRoute == MyRoutes.earlyAccess) {
        Get.offAllNamed(MyRoutes.home);
      }
    });
  }

  Future<void> init() async {
    final unlockedVersion =
        box.read(MyConfig.keyEarlyAccessUnlockedVersion) as String?;

    final req = await earlyAccessRepo.status();
    await req.responseHandler(
      res: (res) {
        final status = EarlyAccessStatusModel.fromJson(
          (res as Map<String, dynamic>?) ?? {},
        );
        final endAtRaw = status.earlyAccessEndAt as String?;
        _endAt = endAtRaw == null ? null : DateTime.parse(endAtRaw);
        _version = endAtRaw;
        final expired = _endAt == null || DateTime.now().isAfter(_endAt!);
        final unlocked = unlockedVersion != null && unlockedVersion == _version;

        isActive = status.isEarlyAccess == true && !expired;

        if (isActive) {
          isGated.value = !unlocked;
          _fetchImages();
          _startTicker();
        }
      },
      err: (err) {},
    );
  }

  void _startTicker() {
    _tick();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    if (_endAt == null) return;
    final diff = _endAt!.difference(DateTime.now());

    if (diff.isNegative) {
      remaining.value = Duration.zero;
      isGated.value = false;
      _ticker?.cancel();
    } else {
      remaining.value = diff;
    }
  }

  void _fetchImages() async {
    final req = await earlyAccessRepo.images();
    await req.responseHandler(
      res: (res) => images.value = (res as List)
          .map((e) => EarlyAccessImageModel.fromJson(e))
          .toList(),
      err: (err) => showMyErrAPISnackbar(err),
    );
  }

  void submitPassword() async {
    final password = passwordController.text.trim();
    if (password.isEmpty) return;

    isSubmitting.value = true;

    final req = await earlyAccessRepo.checkPassword(password);
    await req.responseHandler(
      res: (res) {
        if (res == true) {
          final wasGated = isGated.value;

          box.write(MyConfig.keyEarlyAccessUnlockedVersion, _version);
          isGated.value = false;
          _ticker?.cancel();

          if (!wasGated) Get.offAllNamed(MyRoutes.home);
        } else {
          showMyErrAPISnackbar({"message": "Wrong Password"});
        }
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isSubmitting.value = false;
  }

  @override
  void onClose() {
    _ticker?.cancel();
    passwordController.dispose();
    super.onClose();
  }
}
