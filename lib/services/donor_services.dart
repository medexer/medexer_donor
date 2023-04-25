// ignore_for_file: library_prefixes, prefer_const_constructors, unnecessary_brace_in_string_interps, unnecessary_null_comparison
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medexer_donor/models/appointment_model.dart';
import 'package:medexer_donor/models/donation_center_model.dart';
import 'package:medexer_donor/screens/home/appointmentPages/view_appointment.dart';
import 'package:medexer_donor/config/api_client.dart';
import 'package:medexer_donor/config/api_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/screens/home/donor_pages/donor_centers.dart';

class DonorServices extends GetxController {
  final dio = DioConfig().api;
  final authStorage = GetStorage();
  final UserRepository userRepository = Get.find();

  var donorRequestError = ''.obs;
  var donorRequestStatus = ''.obs;
  var donorRequestLoading = false.obs;

  Future<void> bookAppointmentController(
    Map dto,
  ) async {
    try {
      donorRequestLoading.value = true;
      donorRequestStatus.value = 'PENDING';

      final response = await dio.post(
        '${APIConstants.backendServerUrl}donor/appointments/create',
        data: dto,
      );

      if (response.statusCode == 200) {
        donorRequestLoading.value = false;
        donorRequestError.value = '';
        donorRequestStatus.value = 'SUCCESS';

        debugPrint('[BOOK APPOINTMENT SUCCESS]');
        debugPrint('[BOOK APPOINTMENT RESPONSE]:: ${response.data}');

        Get.to(
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500),
          () => DonorCentersScreen(),
        );
      }
    } catch (error) {
      if (error is DioError) {
        donorRequestLoading.value = false;
        donorRequestStatus.value = 'FAILED';
        debugPrint('[BOOK AN APPOINTMENT CATCH ERROR] ${error.response!.data}');
      }
    }
  }

  Future<void> fetchAppointmentsController() async {
    try {
      donorRequestLoading.value = true;
      donorRequestStatus.value = 'PENDING';
      debugPrint('[FETCH-APPOINTMENTS-PENDING]');

      final response = await dio.get(
        '${APIConstants.backendServerUrl}donor/appointments',
        options: Options(
          headers: {
            'Authorization': authStorage.read('ACCESSTOKEN'),
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('[FETCH-APPOINTMENTS-SUCCESS] ${response.data['data']}');
        userRepository.appointments.clear();

        for (var item in response.data['data']) {
          userRepository.appointments.add(AppointmentModel.fromJson(item));
        }

        donorRequestStatus.value = '';
        donorRequestLoading.value = false;
        debugPrint('[FETCH-APPOINTMENTS-SUCCESS]');
      }
    } catch (error) {
      if (error is DioError) {
        donorRequestLoading.value = false;
        donorRequestStatus.value = 'FAILED';
        debugPrint('[FETCH-APPOINTMENTS-ERROR] ${error.response!.data}');
      }
    }
  }

  Future<void> fetchDonationCentersController() async {
    try {
      donorRequestLoading.value = true;
      donorRequestStatus.value = 'PENDING';
      debugPrint('[FETCH-DONATION-CENTERS-PENDING]');

      final response = await dio.get(
        '${APIConstants.backendServerUrl}donor/donation-centers',
        options: Options(
          headers: {
            'Authorization': authStorage.read('ACCESSTOKEN'),
          },
        ),
      );

      if (response.statusCode == 200) {
        userRepository.donationCenters.clear();

        for (var item in response.data['data']) {
          userRepository.donationCenters
              .add(DonationCenterModel.fromJson(item));
        }

        donorRequestStatus.value = '';
        donorRequestLoading.value = false;
        debugPrint('[FETCH-DONATION-CENTERS-SUCCESS]');
      }
    } catch (error) {
      if (error is DioError) {
        donorRequestLoading.value = false;
        donorRequestStatus.value = 'FAILED';

        debugPrint('[FETCH-DONATION-CENTERS-ERROR] ${error.response!.data}');
      }
    }
  }
}
