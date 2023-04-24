// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';
import 'package:medexer_donor/models/donor_activity_model.dart';

import '../models/user_model.dart';

class UserRepository extends GetxController {
  var userData = UserModel.fromJson({}).obs;
  var donorData = DonorActivityModel.fromJson({}).obs;
  var hospitalData = HospitalScreenModel.fromJson({}).obs;
  var kycFormData = {}.obs;
}
