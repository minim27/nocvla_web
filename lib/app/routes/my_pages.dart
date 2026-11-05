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
import 'package:nocvla_web/modules/search/search_binding.dart';
import 'package:nocvla_web/modules/search/search_page.dart';

import '../../modules/early_access/early_access_page.dart';
import '../../modules/home/home_binding.dart';
import '../../modules/home/home_page.dart';
import 'early_access_middleware.dart';
import 'my_routes.dart';

class MyPages {
  static final routes = [
    GetPage(
      name: MyRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
      middlewares: [EarlyAccessMiddleware()],
    ),
    GetPage(
      name: MyRoutes.collection,
      page: () => CollectionPage(),
      binding: CollectionBinding(),
      middlewares: [EarlyAccessMiddleware()],
    ),
    GetPage(
      name: MyRoutes.about,
      page: () => AboutPage(),
      binding: AboutBinding(),
      middlewares: [EarlyAccessMiddleware()],
    ),
    GetPage(
      name: MyRoutes.athlete,
      page: () => AthletePage(),
      binding: AthleteBinding(),
      middlewares: [EarlyAccessMiddleware()],
    ),
    GetPage(
      name: MyRoutes.athleteDetail,
      page: () => AthleteDetailPage(),
      binding: AthleteDetailBinding(),
      middlewares: [EarlyAccessMiddleware()],
    ),
    GetPage(
      name: MyRoutes.faq,
      page: () => FAQPage(),
      binding: FAQBinding(),
      middlewares: [EarlyAccessMiddleware()],
    ),
    GetPage(
      name: MyRoutes.contact,
      page: () => ContactPage(),
      binding: ContactBinding(),
      middlewares: [EarlyAccessMiddleware()],
    ),
    GetPage(
      name: MyRoutes.productDetail,
      page: () => ProductDetailPage(),
      binding: ProductDetailBinding(),
      middlewares: [EarlyAccessMiddleware()],
    ),
    GetPage(
      name: MyRoutes.cart,
      page: () => CartPage(),
      binding: CartBinding(),
      middlewares: [EarlyAccessMiddleware()],
    ),
    GetPage(
      name: MyRoutes.search,
      page: () => SearchPage(),
      binding: SearchBinding(),
      middlewares: [EarlyAccessMiddleware()],
    ),
    GetPage(
      name: MyRoutes.checkout,
      page: () => CheckoutPage(),
      binding: CheckoutBinding(),
      middlewares: [EarlyAccessMiddleware()],
    ),
    GetPage(name: MyRoutes.earlyAccess, page: () => const EarlyAccessPage()),
  ];
}
