// ignore_for_file: unused_local_variable

import 'package:get/get.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/services/auth_services.dart';
import 'package:medexer_donor/services/donor_activity_service.dart';

class RootRepository extends GetxController {
  initializeRepositories() {
    UserRepository userRepository = Get.put(UserRepository());
    AuthServices authServices = Get.put(AuthServices());
    //UserServices donorServices = Get.put(UserServices());
    DonorActivityService donorActivityService =Get.put(DonorActivityService());
  }
}
