// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';
import 'package:medexer_donor/models/user_model.dart';

class UserRepository extends GetxController {
  var userData = UserModel.fromJson({}).obs;
  
  RxList<dynamic> _donationCenters = [].obs;
  RxList get donationCenters => _donationCenters;
  
  RxList<dynamic> _appointments = [].obs;
  RxList get appointments => _appointments;

  var kycFormData = {}.obs;
}
