import 'package:get/get.dart';

import '../../data/repositories/home_repo.dart';
import '../../data/repositories/product_repo.dart';

class BaseController extends GetxController {
  late HomeRepository homeRepo = HomeRepository();
  late ProductRepository productRepo = ProductRepository();
}
