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
      donorRequestLoading.value = true;
      donorRequestStatus.value = 'PENDING';

      final response = await dio.get(
        '${APIConstants.backendServerUrl}donor/donation-centers/geo-data/fetch-all',
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

        donorRequestStatus.value = '';
        donorRequestLoading.value = false;
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
      donorRequestLoading.value = true;
      donorRequestStatus.value = 'PENDING';
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

        donorRequestStatus.value = '';
        donorRequestLoading.value = false;
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
      donorRequestLoading.value = true;
      donorRequestStatus.value = 'PENDING';
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

        donorRequestStatus.value = '';
        donorRequestLoading.value = false;
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
      donorRequestLoading.value = true;
      donorRequestStatus.value = 'PENDING';
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

        donorRequestStatus.value = '';
        donorRequestLoading.value = false;
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
