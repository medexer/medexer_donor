// ignore_for_file: library_prefixes, prefer_const_constructors, unnecessary_brace_in_string_interps, unnecessary_null_comparison
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medexer_donor/models/donor_activity_model.dart';
import 'package:medexer_donor/screens/home/appointmentPages/view_appointment.dart';
import '../config/api_client.dart';
import '../config/api_config.dart';
import '../database/user_repository.dart';


class DonorActivityService extends GetxController {
  final dio = DioConfig().api;
  final authStorage = GetStorage();
  final UserRepository userRepository = Get.find();
  HospitalScreenModel? hospitalScreenModel;
  
  var donorActivityLoading = false.obs;
  var donorActivityError = ''.obs;
  var donorActivityStatus = ''.obs;

  
  Future<void> appointmentController(
    Map dto,
  ) async {
    try {
      donorActivityLoading.value = true;
      donorActivityStatus.value = 'PENDING';
      final response = await dio.post(
        '${APIConstants.backendServerUrl}donor/appointments/create',
        data:dto,
         options: Options(
          headers: {
            'Authorization': authStorage.read('ACCESSTOKEN'),
          },
        ),
      );
      if (response.statusCode == 200) {
        donorActivityLoading.value = false;
        donorActivityError.value = '';
        donorActivityStatus.value = 'SUCCESS';
        debugPrint('[BOOK APPOINTMENT SUCCESS]');
        debugPrint('[BOOK APPOINTMENT RESPONSE]:: ${response.data}');

        Get.to(
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500),
          () => ViewAppointmentScreen(),
        );
      }
    } catch (error) {
      if (error is DioError) {
        donorActivityLoading.value = false;
        donorActivityStatus.value = 'FAILED';
        debugPrint('[BOOK AN APPOINTMENT CATCH ERROR] ${error.response!.data}');
        if (error.response!.data['email'] != null) {
          donorActivityError.value = error.response!.data['email'][0];
        }
        if (error.response!.data['message'] != null) {
          donorActivityError.value = error.response!.data['message'];
        }
      }
    }
  }
  Future<void> UpdateAppointmentController(
    Map dto,
  ) async {
    try {
      donorActivityLoading.value = true;
      donorActivityStatus.value = 'PENDING';
      final response = await dio.put(
        '${APIConstants.backendServerUrl}donor/appointments/4',
        data:dto,
         options: Options(
          headers: {
            'Authorization': authStorage.read('ACCESSTOKEN'),
          },
        ),
      );
      if (response.statusCode == 200) {
        donorActivityLoading.value = false;
        donorActivityError.value = '';
        donorActivityStatus.value = 'SUCCESS';
        debugPrint('[BOOK APPOINTMENT UPDATE SUCCESSFUL]');
        debugPrint('[BOOK APPOINTMENT UPDATE RESPONSE]:: ${response.data}');

        Get.to(
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500),
          () => ViewAppointmentScreen(),
        );
      }
    } catch (error) {
      if (error is DioError) {
        donorActivityLoading.value = false;
        donorActivityStatus.value = 'FAILED';
        debugPrint('[BOOK APPOINTMENT UPDATE CATCH ERROR] ${error.response!.data}');
        if (error.response!.data['email'] != null) {
          donorActivityError.value = error.response!.data['email'][0];
        }
        if (error.response!.data['message'] != null) {
          donorActivityError.value = error.response!.data['message'];
        }
      }
    }
  }

  // Future<void> fetchAppointmentDataController() async {
  //   try {
  //     donorActivityLoading.value = true;
  //     donorActivityStatus.value = 'PENDING';
  //     final response = await dio.get(
  //       '${APIConstants.backendServerUrl}donor/appointments/4',
  //       options: Options(
  //         headers: {
  //           'Authorization': authStorage.read('ACCESSTOKEN'),
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       debugPrint('[APPOINTDATA RESPONSE] ${response.data}');

  //       userRepository.donorData.value = DonorActivityModel.fromJson(response.data);
  //     }
  //   } catch (error) {
  //     if (error is DioError) {
  //       donorActivityLoading.value = false;
  //       donorActivityStatus.value = 'FAILED';
  //       debugPrint('[DONOR ACTIVITY: CATCH ERROR] ${error.response!.data}');
  //     }
  //   }
  // }

  Future<void>onInit()async{
    super.onInit();
    fetchHospitalController();
  }
  Future<void> fetchHospitalController() async {
    try {
      donorActivityLoading.value = true;
      donorActivityStatus.value = 'PENDING';
      final response = await dio.get(
        '${APIConstants.backendServerUrl}donor/donation-centers/3',
        options: Options(
          headers: {
            'Authorization': authStorage.read('ACCESSTOKEN'),
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('[HOSPITAL RESPONSE] ${response.data}');

        userRepository.hospitalData.value = HospitalScreenModel.fromJson(response.data);
      }
    } catch (error) {
      if (error is DioError) {
        donorActivityLoading.value = false;
        donorActivityStatus.value = 'FAILED';
        debugPrint('[HOSPITAL: CATCH ERROR] ${error.response!.data}');
      }
    }
  }
}
