import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:medexer_donor/screens/auth/kyc/sub_screen/id_proof.dart';
import '../config/api_client.dart';
import '../config/api_config.dart';

class KycServices extends GetxController {
  final dio = DioConfig().api;
  final authStorage = GetStorage();
  final UserRepository userRepository = Get.find();

  var authLoading = false.obs;
  var authRequestError = ''.obs;
  var authRequestStatus = ''.obs;

  Future<void> kycController(
    Map dto,
  ) async {
    try {
      authLoading.value = true;
      authRequestStatus.value = 'PENDING';
      final response = await dio.post(
        '${APIConstants.backendServerUrl}registration/donor/kyc-capture',
        data: dto,
      );

      if (response.statusCode == 200) {
        authLoading.value = false;
        authRequestError.value = '';
        authRequestStatus.value = 'SUCCESS';
        debugPrint('[KYC SUCCESS]');
        debugPrint('[KYC RESPONSE]:: ${response.data}');

        Get.to(
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 500),
            () => IdProofScreen());
      }
    } catch (error) {
      if (error is DioError) {
        authLoading.value = false;
        authRequestStatus.value = 'FAILED';
        debugPrint('[KYC CATCH ERROR] ${error.response!.data}');
        if (error.response!.data['email'] != null) {
          authRequestError.value = error.response!.data['email'][0];
        }
        if (error.response!.data['message'] != null) {
          authRequestError.value = error.response!.data['message'];
        }
      }
    }
  }
}
