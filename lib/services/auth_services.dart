// ignore_for_file: library_prefixes, prefer_const_constructors, unnecessary_brace_in_string_interps, unnecessary_null_comparison
import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart' as DioFormData;
import 'package:dio/src/multipart_file.dart' as DioMultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:medexer_donor/screens/auth/kyc/failed_kyc_info_screen.dart';
import 'package:medexer_donor/screens/auth/kyc/kyc_screen.dart';
import 'package:medexer_donor/screens/auth/login_screen.dart';
import 'package:medexer_donor/screens/auth/registration/reset_password_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/home_screen.dart';
import '../config/api_client.dart';
import '../config/api_config.dart';
import '../models/user_model.dart';
import '../screens/auth/registration/forgot_password_success_screen.dart';

class AuthServices extends GetxController {
  final dio = DioConfig().api;
  final authStorage = GetStorage();
  final UserRepository userRepository = Get.find();

  var authLoading = false.obs;
  var authRequestError = ''.obs;
  var authRequestStatus = ''.obs;

  Future<void> googleSigninController(Map dto) async {
    try {
      authLoading.value = true;
      authRequestStatus.value = 'PENDING';
      debugPrint('[SIGNIN-PENDING]');
      debugPrint('${APIConstants.backendServerUrl}auth/donor/google-signin');

      final response = await dio.post(
        '${APIConstants.backendServerUrl}auth/donor/google-signin',
        data: dto,
      );

      debugPrint('[RESPONSE] :: ${response}');
      if (response.statusCode == 200) {
        debugPrint('[SIGNIN-SUCCESS]');

        authStorage.write('MDX-USER', response.data['data']['user']);
        authStorage.write('MDX-ACCESSTOKEN', response.data['data']['access']);
        authStorage.write('MDX-REFRESHTOKEN', response.data['data']['refresh']);

        userRepository.userData.value =
            UserModel.fromJson(response.data['data']['user']);

        authLoading.value = false;
        authRequestError.value = '';
        authRequestStatus.value = 'SUCCESS';

        if (userRepository.userData.value.isKycUpdated == false) {
          Get.to(
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 500),
            () => KycScreen(),
          );
        } else {
          Get.snackbar(
            'Success',
            'Login successful!',
            colorText: Colors.white,
            backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
          );

          Get.to(
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 500),
            () => HomeScreen(),
          );
        }
      } else {
        debugPrint('[SIGNIN ERROR] ${response.data}');
      }
    } catch (error) {
      if (error is DioError) {
        authLoading.value = false;
        authRequestStatus.value = 'FAILED';
        debugPrint('${error}');
        debugPrint('${error.response}');
        if (error.response?.data['message'] != null) {
          authRequestError.value = error.response!.data['message'];
        }
        debugPrint('[SIGNIN CATCH ERROR] ${error.response?.data}');
      }
    }
  }

  Future<void> signinController(Map dto) async {
    try {
      authLoading.value = true;
      authRequestStatus.value = 'PENDING';
      debugPrint('[SIGNIN-PENDING]');
      debugPrint('${APIConstants.backendServerUrl}auth/donor/signin');

      final response = await dio.post(
        '${APIConstants.backendServerUrl}auth/donor/signin',
        data: dto,
      );

      debugPrint('[RESPONSE] :: ${response}');
      if (response.statusCode == 200) {
        debugPrint('[SIGNIN-SUCCESS]');

        authStorage.write('MDX-USER', response.data['data']['user']);
        authStorage.write('MDX-ACCESSTOKEN', response.data['data']['access']);
        authStorage.write('MDX-REFRESHTOKEN', response.data['data']['refresh']);

        userRepository.userData.value =
            UserModel.fromJson(response.data['data']['user']);

        authLoading.value = false;
        authRequestError.value = '';
        authRequestStatus.value = 'SUCCESS';

        if (userRepository.userData.value.isKycUpdated == false) {
          Get.to(
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 500),
            () => KycScreen(),
          );
        } else {
          Get.snackbar(
            'Success',
            'Login successful!',
            colorText: Colors.white,
            backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
          );

          Get.to(
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 500),
            () => HomeScreen(),
          );
        }
      } else {
        debugPrint('[SIGNIN ERROR] ${response.data}');
      }
    } catch (error) {
      if (error is DioError) {
        authLoading.value = false;
        authRequestStatus.value = 'FAILED';
        debugPrint('${error}');
        debugPrint('${error.response}');
        if (error.response?.data['message'] != null) {
          authRequestError.value = error.response!.data['message'];
        }
        debugPrint('[SIGNIN CATCH ERROR] ${error.response?.data}');
      }
    }
  }

  Future<void> signoutController() async {
    try {
      debugPrint('[SIGNOUT-PENDING]');

      debugPrint('${APIConstants.backendServerUrl}auth/donor/signin');

      final response = await dio.put(
        '${APIConstants.backendServerUrl}auth/donor/signout',
        data: {},
        options: Options(
          headers: {
            'Authorization': authStorage.read('MDX-ACCESSTOKEN'),
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('[SIGNOUT-SUCCESS]');

        await authStorage.remove('MDX-USER');

        Get.to(
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500),
          () => LoginScreen(),
        );
      } else {
        debugPrint('[SIGNOUT-ERROR] ${response.data}');
      }
    } catch (error) {
      if (error is DioError) {
        authLoading.value = false;
        authRequestStatus.value = 'FAILED';
        debugPrint('${error}');
        debugPrint('${error.response}');
        if (error.response?.data['message'] != null) {
          authRequestError.value = error.response!.data['message'];
        }
        debugPrint('[SIGNOUT-CATCH-ERROR] ${error.response?.data}');
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

        Get.snackbar(
          'Success',
          'Signup successful!',
          colorText: Colors.white,
          backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
        );

        Get.to(
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500),
          () => LoginScreen(),
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

  Future<void> forgetPassworController(
    Map dto,
  ) async {
    try {
      authLoading.value = true;
      authRequestStatus.value = 'PENDING';
      final response = await dio.put(
        '${APIConstants.backendServerUrl}auth/donor/forgot-password',
        data: dto,
      );

      if (response.statusCode == 200) {
        authLoading.value = false;
        authRequestError.value = '';
        authRequestStatus.value = 'SUCCESS';
        debugPrint('[RESTPASSWORD SUCCESS]');
        debugPrint('[RESTPASSWORD  RESPONSE]:: ${response.data}');

        Get.to(
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500),
          () => ResetPasswordScreen(),
        );
      }
    } catch (error) {
      if (error is DioError) {
        authLoading.value = false;
        authRequestStatus.value = 'FAILED';
        debugPrint('[FORGETPASSSWORD CATCH ERROR] ${error.response!.data}');
        if (error.response!.data['email'] != null) {
          authRequestError.value = error.response!.data['email'][0];
        }
        if (error.response!.data['message'] != null) {
          authRequestError.value = error.response!.data['message'];
        }
      }
    }
  }

  Future<void> resetPasswordController(
    Map dto,
  ) async {
    try {
      authLoading.value = true;
      authRequestStatus.value = 'PENDING';
      final response = await dio.put(
        '${APIConstants.backendServerUrl}auth/donor/reset-password',
        data: dto,
      );

      if (response.statusCode == 200) {
        authLoading.value = false;
        authRequestError.value = '';
        authRequestStatus.value = 'SUCCESS';
        debugPrint('[RESETPASSWORD SUCCESS]');
        debugPrint('[RESETPASSWORD RESPONSE]:: ${response.data}');

        Get.to(
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500),
          () => ForgotPasswordSuccessScreen(),
        );
      }
    } catch (error) {
      if (error is DioError) {
        authLoading.value = false;
        authRequestStatus.value = 'FAILED';
        debugPrint('[RESETPASSSWORD CATCH ERROR] ${error.response!.data}');
        if (error.response!.data['email'] != null) {
          authRequestError.value = error.response!.data['email'][0];
        }
        if (error.response!.data['message'] != null) {
          authRequestError.value = error.response!.data['message'];
        }
      }
    }
  }

  Future<void> updateProfileController(Map dto) async {
    try {
      authLoading.value = true;
      authRequestStatus.value = 'PENDING';

      debugPrint('[UPDATE-PROFILE-PENDING]');
      DioFormData.FormData formData = DioFormData.FormData.fromMap({
        ...dto,
        'avatar': await DioMultipartFile.MultipartFile.fromFile(
            dto['avatar'].path,
            filename: dto['avatar'].name)
      });

      final response = await dio.put(
        '${APIConstants.backendServerUrl}auth/donor/update-profile',
        data: formData,
        options: Options(
          headers: {
            'Authorization': authStorage.read('MDX-ACCESSTOKEN'),
            'Content-Type': 'multipart/form-data'
          },
        ),
      );

      if (response.statusCode == 200) {
        authLoading.value = false;
        authRequestError.value = '';
        authRequestStatus.value = 'SUCCESS';

        authStorage.write('MDX-USER', response.data['data']);
        userRepository.userData.value =
            UserModel.fromJson(response.data['data']);

        Get.snackbar(
          'Success',
          'Profile updated successfully!',
          colorText: Colors.white,
          backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
        );

        Get.to(
          transition: Transition.fade,
          duration: const Duration(milliseconds: 500),
          () => HomeScreen(),
        );
        debugPrint('[UPDATE-PROFILE-SUCCESS] :: ${response.data}');
      }
    } catch (error) {
      if (error is DioError) {
        authLoading.value = false;
        authRequestStatus.value = 'FAILED';
        debugPrint('[RESETPASSSWORD CATCH ERROR] ${error.response!.data}');
      }
    }
  }

  Future<void> updateProfileWithGoogleSigninController(Map dto) async {
    try {
      authLoading.value = true;
      authRequestStatus.value = 'PENDING';

      debugPrint('[UPDATE-PROFILE-PENDING]');

      DioFormData.FormData formData = DioFormData.FormData.fromMap({
        ...dto,
        // 'avatar': await DioMultipartFile.MultipartFile.fromFile(
        //     dto['avatar'].path,
        //     filename: dto['avatar'].name)
      });

      final response = await dio.put(
        '${APIConstants.backendServerUrl}auth/donor/update-google-signin-profile',
        data: formData,
        options: Options(
          headers: {
            'Authorization': authStorage.read('MDX-ACCESSTOKEN'),
            'Content-Type': 'multipart/form-data'
          },
        ),
      );

      if (response.statusCode == 200) {
        authLoading.value = false;
        authRequestError.value = '';
        authRequestStatus.value = 'SUCCESS';

        authStorage.write('MDX-USER', response.data['data']);
        userRepository.userData.value =
            UserModel.fromJson(response.data['data']);

        Get.snackbar(
          'Success',
          'Profile updated successfully!',
          colorText: Colors.white,
          backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
        );

        Get.to(
          transition: Transition.fade,
          duration: const Duration(milliseconds: 500),
          () => HomeScreen(),
        );
        debugPrint('[UPDATE-PROFILE-SUCCESS] :: ${response.data}');
      }
    } catch (error) {
      if (error is DioError) {
        authLoading.value = false;
        authRequestStatus.value = 'FAILED';
        debugPrint('[RESETPASSSWORD CATCH ERROR] ${error.response!.data}');
      }
    }
  }

  Future<void> kycCaptureController(Map dto) async {
    try {
      authLoading.value = true;
      authRequestStatus.value = 'PENDING';
      debugPrint('[KYC-CAPTURE-PENDING]');

      DioFormData.FormData formData = DioFormData.FormData.fromMap({
        ...dto,
        'documentUploadCover': await DioMultipartFile.MultipartFile.fromFile(
          dto['documentUploadCover'].path,
          filename: dto['documentUploadCover'].name,
        ),
        'documentUploadRear': await DioMultipartFile.MultipartFile.fromFile(
          dto['documentUploadRear'].path,
          filename: dto['documentUploadRear'].name,
        )
      });

      debugPrint('[HAS-TATTOS] :: ${dto['hasTattos']}');
      if (dto['hasTattos'] == true) {
        final response = await dio.delete(
          '${APIConstants.backendServerUrl}auth/donor/delete-account',
          options: Options(
            headers: {
              'Authorization': authStorage.read('MDX-ACCESSTOKEN'),
            },
          ),
        );

        if (response.statusCode == 200) {
          authLoading.value = false;
          authRequestError.value = '';
          authRequestStatus.value = 'SUCCESS';

          await authStorage.remove('MDX-USER');
          Get.to(() => FailedKycInfoScreen());
        }
      } else {
        final response = await dio.post(
          '${APIConstants.backendServerUrl}registration/donor/kyc-capture',
          data: formData,
          options: Options(
            headers: {
              'Authorization': authStorage.read('MDX-ACCESSTOKEN'),
              'Content-Type': 'multipart/form-data',
            },
          ),
        );

        if (response.statusCode == 201) {
          authLoading.value = false;
          authRequestError.value = '';
          authRequestStatus.value = 'SUCCESS';

          authStorage.write('MDX-USER', response.data['data']['user']);
          userRepository.userData.value =
              UserModel.fromJson(response.data['data']['user']);

          Get.snackbar(
            'Success',
            'KYC captured successfully!',
            colorText: Colors.white,
            backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
          );

          Get.to(
            transition: Transition.fade,
            duration: const Duration(milliseconds: 500),
            () => HomeScreen(),
          );
          debugPrint('[KYC-CAPTURE-SUCCESS] :: ${response.data}');
        }
      }
    } catch (error) {
      if (error is DioError) {
        authLoading.value = false;
        authRequestStatus.value = 'FAILED';
        debugPrint('[KYC-CAPTURE-CATCH-ERROR] ${error.response!.data}');
      }
    }
  }
}
