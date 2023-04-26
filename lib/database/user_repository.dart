// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';
import 'package:medexer_donor/models/kyc_formdata_model.dart';
import 'package:medexer_donor/models/user_model.dart';

class UserRepository extends GetxController {
  var userData = UserModel.fromJson({}).obs;
  
  RxList<dynamic> _donationCenters = [].obs;
  RxList get donationCenters => _donationCenters;
  
  RxList<dynamic> _appointments = [].obs;
  RxList get appointments => _appointments;
  
  RxList<dynamic> _notifications = [].obs;
  RxList get notifications => _notifications;

  var kycFormData = KYCFormDataModel.fromJson({}).obs;
}
