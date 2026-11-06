import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/shared/utils/my_utility.dart';

import '../../app/core/base_controller.dart';

class ContactController extends BaseController {
  final resContact = <String, String>{}.obs;
  final resFaq = <(String, String)>[].obs;
  final resTopics = <String>[].obs;
  final isLoadingContact = false.obs;

  final openFaq = 0.obs;

  final txtName = TextEditingController();
  final txtContact = TextEditingController();
  final txtMessage = TextEditingController();
  final topic = Rxn<String>();
  final isLoadingSubmit = false.obs;
  final isSubmitted = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchApiContact();
    fetchApiFaq();
    fetchApiTopic();
  }

  @override
  void onClose() {
    txtName.dispose();
    txtContact.dispose();
    txtMessage.dispose();
    super.onClose();
  }

  void fetchApiContact() async {
    isLoadingContact.value = true;

    final req = await configRepo.listConfigs([
      "CONTACT_EYEBROW",
      "CONTACT_TITLE",
      "CONTACT_DESCRIPTION",
      "WA_NUMBER",
      "CONTACT_EMAIL",
      "INSTAGRAM",
      "TIKTOK",
    ]);
    await req.responseHandler(
      res: (res) {
        resContact.value = {
          for (final e in (res as List))
            if ("${e["value"] ?? ""}".trim().isNotEmpty)
              "${e["name"]}": "${e["value"]}".trim(),
        };
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingContact.value = false;
  }

  void fetchApiFaq() async {
    final req = await contactRepo.listFaqs();
    await req.responseHandler(
      res: (res) => resFaq.value = [
        for (final e in (res as List))
          ("${e["question"] ?? ""}", "${e["answer"] ?? ""}"),
      ],
      err: (err) => showMyErrAPISnackbar(err),
    );
  }

  void fetchApiTopic() async {
    final req = await contactRepo.listTopics();
    await req.responseHandler(
      res: (res) {
        resTopics.value = (res as List).map((e) => "${e["name"]}").toList();
        topic.value = resTopics.firstOrNull;
      },
      err: (err) => showMyErrAPISnackbar(err),
    );
  }

  String username(String value) => value.replaceFirst(RegExp(r"^@"), "");

  List<
    ({
      IconData? icon,
      String? asset,
      String label,
      String desc,
      String link,
      bool isMain,
    })
  >
  get channels {
    final wa = resContact["WA_NUMBER"];
    final email = resContact["CONTACT_EMAIL"];
    final instagram = resContact["INSTAGRAM"];
    final tiktok = resContact["TIKTOK"];

    return [
      if (wa != null)
        (
          icon: Icons.chat_bubble_outline,
          asset: null,
          label: "WHATSAPP ORDER",
          desc: "+$wa · respon tercepat",
          link: "https://wa.me/$wa",
          isMain: true,
        ),
      if (email != null)
        (
          icon: Icons.mail_outline,
          asset: null,
          label: "EMAIL",
          desc: email,
          link: "mailto:$email",
          isMain: false,
        ),
      if (instagram != null)
        (
          icon: null,
          asset: "instagram",
          label: "INSTAGRAM",
          desc: "@${username(instagram)}",
          link: "https://instagram.com/${username(instagram)}",
          isMain: false,
        ),
      if (tiktok != null)
        (
          icon: null,
          asset: "tiktok",
          label: "TIKTOK",
          desc: "@${username(tiktok)}",
          link: "https://www.tiktok.com/@${username(tiktok)}",
          isMain: false,
        ),
    ];
  }

  void open(String link) => execUri(link);

  void toggleFaq(int index) =>
      openFaq.value = openFaq.value == index ? -1 : index;

  bool validMessage() {
    if (txtName.text.trim().isEmpty ||
        txtContact.text.trim().isEmpty ||
        txtMessage.text.trim().isEmpty) {
      showMyErrAPISnackbar({"message": "Nama, kontak, dan pesan wajib diisi"});
      return false;
    }

    return true;
  }

  void submit() async {
    if (!validMessage()) return;
    isLoadingSubmit.value = true;

    final req = await contactRepo.submitMessage(
      name: txtName.text.trim(),
      contact: txtContact.text.trim(),
      topic: topic.value,
      message: txtMessage.text.trim(),
    );
    await req.responseHandler(
      res: (res) => isSubmitted.value = true,
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingSubmit.value = false;
  }
}
