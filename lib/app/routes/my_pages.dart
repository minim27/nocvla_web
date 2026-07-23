import 'package:get/get.dart';
import 'package:nocvla_web/modules/about/about_binding.dart';
import 'package:nocvla_web/modules/about/about_page.dart';
import 'package:nocvla_web/modules/athlete/detail/athlete_detail_binding.dart';
import 'package:nocvla_web/modules/athlete/detail/athlete_detail_page.dart';
import 'package:nocvla_web/modules/athlete/list/athlete_binding.dart';
import 'package:nocvla_web/modules/athlete/list/athlete_page.dart';
import 'package:nocvla_web/modules/cart/cart_binding.dart';
import 'package:nocvla_web/modules/cart/cart_page.dart';
import 'package:nocvla_web/modules/checkout/checkout_binding.dart';
import 'package:nocvla_web/modules/checkout/checkout_page.dart';
import 'package:nocvla_web/modules/collection/collection_binding.dart';
import 'package:nocvla_web/modules/collection/collection_page.dart';
import 'package:nocvla_web/modules/contact/contact_binding.dart';
import 'package:nocvla_web/modules/contact/contact_page.dart';
import 'package:nocvla_web/modules/faq/faq_binding.dart';
import 'package:nocvla_web/modules/faq/faq_page.dart';
import 'package:nocvla_web/modules/product_detail/product_detail_binding.dart';
import 'package:nocvla_web/modules/product_detail/product_detail_page.dart';

import '../../modules/home/home_binding.dart';
import '../../modules/home/home_page.dart';
import 'my_routes.dart';

class MyPages {
  static final routes = [
    GetPage(
      name: MyRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: MyRoutes.collection,
      page: () => CollectionPage(),
      binding: CollectionBinding(),
    ),
    GetPage(
      name: MyRoutes.about,
      page: () => AboutPage(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: MyRoutes.athlete,
      page: () => AthletePage(),
      binding: AthleteBinding(),
    ),
    GetPage(
      name: MyRoutes.athleteDetail,
      page: () => AthleteDetailPage(),
      binding: AthleteDetailBinding(),
    ),
    GetPage(name: MyRoutes.faq, page: () => FAQPage(), binding: FAQBinding()),
    GetPage(
      name: MyRoutes.contact,
      page: () => ContactPage(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: MyRoutes.productDetail,
      page: () => ProductDetailPage(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: MyRoutes.cart,
      page: () => CartPage(),
      binding: CartBinding(),
    ),
    GetPage(
      name: MyRoutes.checkout,
      page: () => CheckoutPage(),
      binding: CheckoutBinding(),
    ),
  ];
}
