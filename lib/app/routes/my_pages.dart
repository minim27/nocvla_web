import 'package:get/get.dart';
import 'package:nocvla/app/routes/my_routes.dart';
import 'package:nocvla/modules/account/address/my_address_binding.dart';
import 'package:nocvla/modules/account/address/my_address_page.dart';
import 'package:nocvla/modules/account/auth/login/login_binding.dart';
import 'package:nocvla/modules/account/auth/login/login_page.dart';
import 'package:nocvla/modules/account/my_order/detail/my_order_detail_binding.dart';
import 'package:nocvla/modules/account/my_order/detail/my_order_detail_page.dart';
import 'package:nocvla/modules/account/my_order/my_order_binding.dart';
import 'package:nocvla/modules/account/my_order/my_order_page.dart';
import 'package:nocvla/modules/account/my_profile/my_profile_binding.dart';
import 'package:nocvla/modules/account/password/my_password_binding.dart';
import 'package:nocvla/modules/account/password/my_password_page.dart';
import 'package:nocvla/modules/dashboard/dashboard_binding.dart';
import 'package:nocvla/modules/dashboard/dashboard_page.dart';
import 'package:nocvla/modules/home/home_binding.dart';
import 'package:nocvla/modules/home/home_page.dart';
import 'package:nocvla/modules/intro/intro_binding.dart';
import 'package:nocvla/modules/intro/intro_page.dart';
import 'package:nocvla/modules/order/cart/cart_binding.dart';
import 'package:nocvla/modules/order/cart/cart_page.dart';
import 'package:nocvla/modules/order/checkout/checkout_binding.dart';
import 'package:nocvla/modules/order/checkout/checkout_page.dart';
import 'package:nocvla/modules/product/product_detail_binding.dart';
import 'package:nocvla/modules/product/product_detail_page.dart';

import '../../modules/account/my_profile/my_profile_page.dart';

class MyPages {
  static final routes = [
    GetPage(
      name: MyRoutes.dashboard,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: MyRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: MyRoutes.intro,
      page: () => IntroPage(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: MyRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
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
    GetPage(
      name: MyRoutes.myProfile,
      page: () => MyProfilePage(),
      binding: MyProfileBinding(),
    ),
    GetPage(
      name: MyRoutes.updatePassword,
      page: () => MyPasswordPage(),
      binding: MyPasswordBinding(),
    ),
    GetPage(
      name: MyRoutes.myAddress,
      page: () => MyAddressPage(),
      binding: MyAddressBinding(),
    ),
    GetPage(
      name: MyRoutes.myOrder,
      page: () => MyOrderPage(),
      binding: MyOrderBinding(),
    ),
    GetPage(
      name: MyRoutes.myOrderDetail,
      page: () => MyOrderDetailPage(),
      binding: MyOrderDetailBinding(),
    ),
  ];
}
