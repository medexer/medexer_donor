// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';
import 'package:medexer_donor/models/kyc_formdata_model.dart';
import 'package:medexer_donor/models/signup_formdata_model.dart';
import 'package:medexer_donor/models/user_model.dart';
import 'package:medexer_donor/models/user_profile_model.dart';
import 'package:medexer_donor/models/kyc_personal_data_model.dart';

class UserRepository extends GetxController {
  var googleSignin = false.obs;
  var userLocationUsage = false.obs;
  var currentUserLatitude = 0.0.obs;
  var currentUserLongitude = 0.0.obs;
  var hospitalRouteAdded = false.obs;

  var userData = UserModel.fromJson({}).obs;
  var userProfile = UserProfileModel.fromJson({}).obs;

  RxList<dynamic> _donationCenters = [].obs;
  RxList get donationCenters => _donationCenters;

  RxList<dynamic> _searchResults = [].obs;
  RxList get searchResults => _searchResults;

  RxList<dynamic> _donationCentersGeoData = [].obs;
  RxList get donationCentersGeoData => _donationCentersGeoData;

  RxList<dynamic> _appointments = [].obs;
  RxList get appointments => _appointments;

  RxList<dynamic> _notifications = [].obs;
  RxList get notifications => _notifications;

  RxList<dynamic> _medicalHistory = [].obs;
  RxList get medicalHistory => _medicalHistory;

  var kycFormData = KYCFormDataModel.fromJson({}).obs;
  var kycPersonalData = KYCPersonalDataModel.fromJson({}).obs;

  var signupFormData = SignupFormDataModel.fromJson({}).obs;
}
