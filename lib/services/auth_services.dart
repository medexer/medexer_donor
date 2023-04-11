// ignore_for_file: library_prefixes, prefer_const_constructors, unnecessary_brace_in_string_interps, unnecessary_null_comparison
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:medexer_donor/screens/auth/login_screen.dart';
import 'package:medexer_donor/screens/home/home_screen.dart';
import '../config/api_client.dart';
import '../config/api_config.dart';
import '../models/user_model.dart';
import '../screens/home/app_guide_screen.dart';

class AuthServices extends GetxController {
  final dio = DioConfig().api;
  final authStorage = GetStorage();
  final UserRepository userRepository = Get.find();

  var authLoading = false.obs;
  var authRequestError = ''.obs;
  var authRequestStatus = ''.obs;


Future<void> signinController(
    Map dto,
  ) async {
    try {
      authLoading.value = true;
      authRequestStatus.value = 'PENDING';
      final response = await dio.post(
        '${APIConstants.backendServerUrl}auth/donor/signin',
        data: dto,
      );

      if (response.statusCode == 200) {
        authStorage.write('USER', response.data['user']);
        authStorage.write('ACCESSTOKEN', response.data['access']);
        authStorage.write('REFRESHTOKEN', response.data['refresh']);

        userRepository.userData.value =
            UserModel.fromJson(response.data['user']);

        authLoading.value = false;
        authRequestError.value = '';
        authRequestStatus.value = 'SUCCESS';

        if (!response.data['user']['is_verified']) {
          authRequestError.value = 'ACCOUNT UNVERIFIED';

        } else {
          Get.to(
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 500),
            () => HomeScreen()
          );
        }
      } else {
        debugPrint('[SIGNIN ERROR] ${response.data}');
      }
    } catch (error) {
      if (error is DioError) {
        authLoading.value = false;
        authRequestStatus.value = 'FAILED';
        debugPrint('${error.response!.data}');
        if (error.response!.data['message'] != null) {
          authRequestError.value = error.response!.data['message'];
        }
        debugPrint('[SIGNIN CATCH ERROR] ${error.response!.data}');
      }
    }
  }

  Future<void> signupController(

    Map dto,
  ) async {
    try {
      authLoading.value = true;
      authRequestStatus.value = 'PENDING';
      final response = await dio.post(
        '${APIConstants.backendServerUrl}auth/donor/signup',
        data: dto,
      );

      if (response.statusCode == 201) {
        authLoading.value = false;
        authRequestError.value = '';
        authRequestStatus.value = 'SUCCESS';
        debugPrint('[SIGNUP SUCCESS]');
        debugPrint('[SIGNUP RESPONSE]:: ${response.data}');

        Get.to(
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500),
          () =>LoginScreen(),
        );
      }
    } catch (error) {
      if (error is DioError) {
        authLoading.value = false;
        authRequestStatus.value = 'FAILED';
        debugPrint('[SIGNUP CATCH ERROR] ${error.response!.data}');
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
