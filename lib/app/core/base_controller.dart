import 'package:get/get.dart';
import 'package:nocvla/data/repositories/auth_repo.dart';
import 'package:nocvla/data/repositories/me_repo.dart';
import 'package:nocvla/data/repositories/my_order_repo.dart';
import 'package:nocvla/data/repositories/order_repo.dart';

import '../../data/repositories/home_repo.dart';
import '../../data/repositories/product_repo.dart';

class BaseController extends GetxController {
  late AuthRepository authRepo = AuthRepository();
  late HomeRepository homeRepo = HomeRepository();
  late ProductRepository productRepo = ProductRepository();
  late OrderRepository orderRepo = OrderRepository();
  late MeRepository meRepo = MeRepository();
  late MyOrderRepository myOrderRepo = MyOrderRepository();
}
