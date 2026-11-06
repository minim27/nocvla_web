import 'package:get/get.dart';
import 'package:nocvla_web/data/repositories/athlete_application_repo.dart';
import 'package:nocvla_web/data/repositories/athlete_repo.dart';
import 'package:nocvla_web/data/repositories/collections_repo.dart';
import 'package:nocvla_web/data/repositories/config_repo.dart';
import 'package:nocvla_web/data/repositories/contact_repo.dart';
import 'package:nocvla_web/data/repositories/early_access_repo.dart';
import 'package:nocvla_web/data/repositories/home_repo.dart';
import 'package:nocvla_web/data/repositories/order_repo.dart';

class BaseController extends GetxController {
  HomeRepo homeRepo = HomeRepo();
  CollectionsRepo collectionsRepo = CollectionsRepo();
  AthleteRepo athleteRepo = AthleteRepo();
  AthleteApplicationRepo athleteApplicationRepo = AthleteApplicationRepo();
  EarlyAccessRepo earlyAccessRepo = EarlyAccessRepo();
  ConfigRepo configRepo = ConfigRepo();
  ContactRepo contactRepo = ContactRepo();
  OrderRepo orderRepo = OrderRepo();
}
