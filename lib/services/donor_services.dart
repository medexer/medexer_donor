// ignore_for_file: library_prefixes, prefer_const_constructors, unnecessary_brace_in_string_interps, unnecessary_null_comparison
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/models/appointment_model.dart';
import 'package:medexer_donor/models/donation_center_geodata_model.dart';
import 'package:medexer_donor/models/donation_center_model.dart';
import 'package:medexer_donor/models/medical_history_model.dart';
import 'package:medexer_donor/models/notification_model.dart';
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

  Future<void> fetchDontationCentersGeoDataController() async {
    try {
      final response = await dio.get(
        '${APIConstants.backendServerUrl}donor/donation-centers/geo-data/fetch-all',
        options: Options(
          headers: {
            'Authorization': authStorage.read('MDX-ACCESSTOKEN'),
          },
        ),
      );

      if (response.statusCode == 200) {
        userRepository.donationCentersGeoData.clear();

        debugPrint('[FETCH-DONATION-CENTERS-GEODATA-SUCCESS]');
        // debugPrint(
        //     '[FETCH-DONATION-CENTERS-GEODATA-RESPONSE]:: ${response.data}');

        for (var item in response.data['data']) {
          userRepository.donationCentersGeoData
              .add(DonationCenterGeoDataModel.fromJson(item));
        }
      }
    } catch (error) {
      if (error is DioError) {
        donorRequestLoading.value = false;
        donorRequestStatus.value = 'FAILED';
        debugPrint('[FETCH-DONATION-CENTERS-GEODATA-CATCH-ERROR] ${error}');
      }
    }
  }

  Future<void> bookAppointmentController(
    Map dto,
  ) async {
    try {
      donorRequestLoading.value = true;
      donorRequestStatus.value = 'PENDING';

      final response = await dio.post(
        '${APIConstants.backendServerUrl}donor/appointments/create',
        data: dto,
        options: Options(
          headers: {
            'Authorization': authStorage.read('MDX-ACCESSTOKEN'),
          },
        ),
      );

      if (response.statusCode == 200) {
        donorRequestLoading.value = false;
        donorRequestError.value = '';
        donorRequestStatus.value = 'SUCCESS';

        debugPrint('[BOOK APPOINTMENT SUCCESS]');
        debugPrint('[BOOK APPOINTMENT RESPONSE]:: ${response.data}');

        Get.snackbar(
          'Success',
          'Appointment booking successful!',
          colorText: Colors.white,
          backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
        );

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
        if (error.response?.data['message'] != null) {
          donorRequestStatus.value = error.response!.data['message'];
          Get.snackbar(
            'Book Appointment Error',
            '${error.response!.data['status']}',
            colorText: Colors.white,
            backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
          );
        }
      }
    }
  }

  Future<void> fetchAppointmentsController() async {
    try {
      debugPrint('[FETCH-APPOINTMENTS-PENDING]');

      final response = await dio.get(
        '${APIConstants.backendServerUrl}donor/appointments',
        options: Options(
          headers: {
            'Authorization': authStorage.read('MDX-ACCESSTOKEN'),
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('[FETCH-APPOINTMENTS-SUCCESS] ${response.data['data']}');
        userRepository.appointments.clear();

        for (var item in response.data['data']) {
          userRepository.appointments.add(AppointmentModel.fromJson(item));
        }

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
      debugPrint('[FETCH-DONATION-CENTERS-PENDING]');

      final response = await dio.get(
        '${APIConstants.backendServerUrl}donor/donation-centers',
        options: Options(
          headers: {
            'Authorization': authStorage.read('MDX-ACCESSTOKEN'),
          },
        ),
      );

      if (response.statusCode == 200) {
        userRepository.donationCenters.clear();

        for (var item in response.data['data']) {
          userRepository.donationCenters
              .add(DonationCenterModel.fromJson(item));
        }

        debugPrint('[FETCH-DONATION-CENTERS-SUCCESS] :: -2');
      }
    } catch (error) {
      if (error is DioError) {
        donorRequestLoading.value = false;
        donorRequestStatus.value = 'FAILED';

        debugPrint('[FETCH-DONATION-CENTERS-ERROR] ${error.response?.data}');
      }
    }
  }

  Future<void> searchDonationCentersController(String query) async {
    try {
      debugPrint('[SEARCH-DONATION-CENTERS-PENDING]');

      final response = await dio.get(
        '${APIConstants.backendServerUrl}donor/donation-centers/search?query=${query}',
        options: Options(
          headers: {
            'Authorization': authStorage.read('MDX-ACCESSTOKEN'),
          },
        ),
      );

      if (response.statusCode == 200) {
        userRepository.searchResults.clear();

        for (var item in response.data['data']) {
          userRepository.searchResults.add(DonationCenterModel.fromJson(item));
        }

        debugPrint('[SEARCH-DONATION-CENTERS-SUCCESS]');
      }
    } catch (error) {
      if (error is DioError) {
        donorRequestLoading.value = false;
        donorRequestStatus.value = 'FAILED';

        debugPrint('[SEARCH-DONATION-CENTERS-ERROR] ${error.response?.data}');
      }
    }
  }

  Future<void> contactUsController(Map dto) async {
    try {
      donorRequestLoading.value = true;
      donorRequestStatus.value = 'PENDING';
      debugPrint('[CONTACT-US-PENDING]');

      final response = await dio.post(
        '${APIConstants.backendServerUrl}donor/contact-us',
        data: dto,
        options: Options(
          headers: {
            'Authorization': authStorage.read('MDX-ACCESSTOKEN'),
          },
        ),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Message',
          'Contact us message sent successfully',
          colorText: Colors.white,
          backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
        );

        donorRequestStatus.value = '';
        donorRequestLoading.value = false;
        debugPrint('[CONTACT-US-SUCCESS]');
      }
    } catch (error) {
      if (error is DioError) {
        donorRequestLoading.value = false;
        donorRequestStatus.value = 'FAILED';

        debugPrint('[CONTACT-US-ERROR] ${error.response!.data}');
        Get.snackbar(
          'Error',
          'An error occurred while sending contact us message, please try again.',
          colorText: Colors.white,
          backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
        );
      }
    }
  }

  Future<void> fetchNotificationsController() async {
    try {
      debugPrint('[FETCH-NOTIFICATIONS-PENDING]');

      final response = await dio.get(
        '${APIConstants.backendServerUrl}donor/notifications',
        options: Options(
          headers: {
            'Authorization': authStorage.read('MDX-ACCESSTOKEN'),
          },
        ),
      );

      if (response.statusCode == 200) {
        userRepository.notifications.clear();

        for (var item in response.data['data']) {
          userRepository.notifications.add(NotificationModel.fromJson(item));
        }

        debugPrint('[FETCH-NOTIFICATIONS-SUCCESS]');
      }
    } catch (error) {
      if (error is DioError) {
        donorRequestLoading.value = false;
        donorRequestStatus.value = 'FAILED';

        debugPrint('[FETCH-NOTIFICATIONS-ERROR] ${error.response!.data}');
      }
    }
  }

  Future<void> readNotificationsController(int? notification) async {
    try {
      donorRequestLoading.value = true;
      donorRequestStatus.value = 'PENDING';
      debugPrint('[READ-NOTIFICATION-PENDING]');

      final response = await dio.put(
        '${APIConstants.backendServerUrl}donor/notifications/${notification}/update',
        options: Options(
          headers: {
            'Authorization': authStorage.read('MDX-ACCESSTOKEN'),
          },
        ),
      );

      if (response.statusCode == 200) {
        donorRequestStatus.value = '';
        donorRequestLoading.value = false;

        debugPrint('[READ-NOTIFICATION-SUCCESS]');
      }
    } catch (error) {
      if (error is DioError) {
        donorRequestLoading.value = false;
        donorRequestStatus.value = 'FAILED';

        debugPrint('[READ-NOTIFICATION-ERROR] ${error.response!.data}');
      }
    }
  }

  Future<void> fetchMedicalHistoryController() async {
    try {
      debugPrint('[FETCH-NOTIFICATIONS-PENDING]');

      final response = await dio.get(
        '${APIConstants.backendServerUrl}medical-data/donor/medical-history/fetch-all',
        options: Options(
          headers: {
            'Authorization': authStorage.read('MDX-ACCESSTOKEN'),
          },
        ),
      );

      if (response.statusCode == 200) {
        userRepository.medicalHistory.clear();

        for (var item in response.data['data']) {
          userRepository.medicalHistory.add(MedicalHistoryModel.fromJson(item));
        }

        debugPrint('[FETCH-NOTIFICATIONS-SUCCESS]');
      }
    } catch (error) {
      if (error is DioError) {
        donorRequestLoading.value = false;
        donorRequestStatus.value = 'FAILED';

        debugPrint('[FETCH-NOTIFICATIONS-ERROR] ${error.response!.data}');
      }
    }
  }
}
