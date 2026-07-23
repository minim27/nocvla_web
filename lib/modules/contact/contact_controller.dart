import 'package:flutter/material.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';

import '../../app/core/base_controller.dart';

class ContactController extends BaseController {
  final res = <String, dynamic>{
    "whatsapp": {
      "icon": MyIcons.icWhatsapp,
      "label": "WHATSAPP",
      "desc": "+62 812-3321-1234",
      "link": null,
    },
    "email": {
      "icon": MyIcons.icEmail2,
      "label": "EMAIL",
      "desc": "cs@nocvla.com",
      "link": null,
    },
    "instagram": {
      "icon": MyIcons.icInstagram,
      "label": "INSTAGRAM",
      "desc": "@nocvla",
      "link": null,
    },
    "tiktok": {
      "icon": MyIcons.icTikTok,
      "label": "TIKTOK",
      "desc": "@nocvla",
      "link": null,
    },
  };

  final txtName = TextEditingController();
  final txtEmail = TextEditingController();
  final txtSubject = TextEditingController();
  final txtMessage = TextEditingController();

  void send() => null;
}
