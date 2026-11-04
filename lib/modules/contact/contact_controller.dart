import 'package:nocvla_web/shared/utils/my_icons.dart';
import 'package:nocvla_web/shared/utils/my_utility.dart';

import '../../app/core/base_controller.dart';
import '../../app/services/my_config.dart';

class ContactController extends BaseController {
  final res = <Map<String, dynamic>>[
    {
      "icon": MyIcons.icWhatsapp,
      "label": "WHATSAPP",
      "desc": "+${MyConfig.whatsappNumber}",
      "link": "https://wa.me/${MyConfig.whatsappNumber}",
    },
    {
      "icon": MyIcons.icEmail2,
      "label": "EMAIL",
      "desc": "nocvla.apparel@gmail.com",
      "link": "mailto:nocvla.apparel@gmail.com",
    },
    {
      "icon": MyIcons.icInstagram,
      "label": "INSTAGRAM",
      "desc": "@${MyConfig.instagramUsername}",
      "link": "https://instagram.com/${MyConfig.instagramUsername}",
    },
    {
      "icon": MyIcons.icTikTok,
      "label": "TIKTOK",
      "desc": "@${MyConfig.tiktokUsername}",
      "link": "https://www.tiktok.com/@${MyConfig.tiktokUsername}",
    },
  ];

  final resFaq = <Map<String, String>>[
    {
      "question": "Bagaimana cara order?",
      "answer":
          "Pilih produk, masukkan ke keranjang, lalu kirim order ke WhatsApp. Admin akan memproses pesanan kamu.",
    },
    {
      "question": "Berapa ongkirnya?",
      "answer": "Ongkir dihitung admin dan diinformasikan lewat WhatsApp.",
    },
    {
      "question": "Bagaimana cara memakai kode atlet?",
      "answer":
          "Masukkan kode atlet di keranjang. Diskon 8% berlaku untuk produk yang terhubung dengan atlet tersebut.",
    },
  ];

  void open(String link) => execUri(link);
}
