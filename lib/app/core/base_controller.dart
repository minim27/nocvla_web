import 'package:get/get.dart';

import '../../data/repositories/home_repo.dart';

class BaseController extends GetxController {
  late HomeRepository homeRepo = HomeRepository();
}
