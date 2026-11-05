import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/data/models/athlete/athlete_model.dart';

import '../../../app/core/base_controller.dart';
import '../../../app/routes/my_routes.dart';
import '../../../shared/utils/my_file_picker.dart';
import '../../../shared/utils/my_utility.dart';

class AthleteController extends BaseController {
  final resAthlete = <AthleteModel>[].obs;
  final isLoadingAthlete = false.obs;

  final formKey = GlobalKey();
  final txtName = TextEditingController();
  final txtCity = TextEditingController();
  final txtInstagram = TextEditingController();
  final txtPhone = TextEditingController();
  final txtReason = TextEditingController();

  final resFocuses = <String>[].obs;
  final trainingFocus = Rxn<String>();
  final photo = Rxn<MyPickedFile>();
  final isLoadingSubmit = false.obs;
  final isSubmitted = false.obs;

  final benefits = const [
    ("FREE PRODUCT", "Produk eksklusif untuk atlet."),
    ("AFFILIATE ACCESS", "Link marketplace dan kode pribadi."),
    ("KOMUNITAS", "Akses Discord NOCVLA."),
    ("GROW TOGETHER", "Bertumbuh bersama brand."),
  ];

  @override
  void onInit() {
    super.onInit();
    fetchApiAthlete();
    fetchApiFocus();
  }

  @override
  void onClose() {
    txtName.dispose();
    txtCity.dispose();
    txtInstagram.dispose();
    txtPhone.dispose();
    txtReason.dispose();
    super.onClose();
  }

  void fetchApiAthlete() async {
    isLoadingAthlete.value = true;

    final req = await athleteRepo.listAthlete();
    await req.responseHandler(
      res: (res) {
        resAthlete.value = (res as List)
            .map((e) => AthleteModel.fromJson(e))
            .toList();
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingAthlete.value = false;

    if (Get.parameters["join"] == "1") {
      WidgetsBinding.instance.addPostFrameCallback((_) => scrollToForm());
    }
  }

  void fetchApiFocus() async {
    final req = await athleteApplicationRepo.listTrainingFocus();
    await req.responseHandler(
      res: (res) {
        resFocuses.value = (res as List).map((e) => "${e["name"]}").toList();
        trainingFocus.value = resFocuses.firstOrNull;
      },
      err: (err) => showMyErrAPISnackbar(err),
    );
  }

  void openDetail(String id) =>
      Get.toNamed(MyRoutes.athleteDetail, parameters: {"id": id});

  void scrollToForm() {
    final context = formKey.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  void copyCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    showMySnackbar("Disalin", "Kode disalin");
  }

  void pickPhoto() async {
    final file = await pickMyFile(accept: "image/jpeg,image/png");
    if (file == null) return;

    if (!["image/jpeg", "image/png"].contains(file.type)) {
      showMyErrAPISnackbar({"message": "Foto harus JPG atau PNG"});
      return;
    }
    if (file.size > 5 * 1024 * 1024) {
      showMyErrAPISnackbar({"message": "Ukuran foto maksimal 5 MB"});
      return;
    }

    photo.value = file;
  }

  bool validApplication() {
    if (txtName.text.trim().isEmpty ||
        txtCity.text.trim().isEmpty ||
        txtInstagram.text.trim().isEmpty ||
        txtPhone.text.trim().isEmpty ||
        txtReason.text.trim().isEmpty) {
      showMyErrAPISnackbar({"message": "Semua field wajib diisi"});
      return false;
    }

    return true;
  }

  void submit() async {
    if (!validApplication()) return;
    isLoadingSubmit.value = true;

    var isAllowed = false;
    final reqLimit = await athleteApplicationRepo.checkLimit(
      phone: txtPhone.text.trim(),
    );
    await reqLimit.responseHandler(
      res: (res) {
        isAllowed = res == true;
        if (!isAllowed) {
          showMyErrAPISnackbar({
            "message": "Batas pendaftaran tercapai. Coba lagi nanti.",
          });
        }
      },
      err: (err) => showMyErrAPISnackbar(err),
    );
    if (!isAllowed) {
      isLoadingSubmit.value = false;
      return;
    }

    String? photoPath;
    final file = photo.value;
    if (file != null) {
      final path =
          "${DateTime.now().millisecondsSinceEpoch}.${file.type == "image/png" ? "png" : "jpg"}";
      var isUploaded = false;

      final reqPhoto = await athleteApplicationRepo.uploadPhoto(
        path: path,
        bytes: file.bytes,
        contentType: file.type,
      );
      await reqPhoto.responseHandler(
        res: (res) => isUploaded = true,
        err: (err) => showMyErrAPISnackbar(err),
      );

      if (!isUploaded) {
        isLoadingSubmit.value = false;
        return;
      }
      photoPath = path;
    }

    final req = await athleteApplicationRepo.submitApplication(
      name: txtName.text.trim(),
      phone: txtPhone.text.trim(),
      instagramUsername: txtInstagram.text.trim(),
      city: txtCity.text.trim(),
      trainingFocus: trainingFocus.value,
      reason: txtReason.text.trim(),
      photoPath: photoPath,
    );
    await req.responseHandler(
      res: (res) => isSubmitted.value = true,
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingSubmit.value = false;
  }
}
