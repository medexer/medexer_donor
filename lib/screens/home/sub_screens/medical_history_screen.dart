import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/services/donor_services.dart';
import '../../../network_services/network_error_message.dart';
import '../../../network_services/network_manager.dart';
import '../../../widgets/page_header.dart';
import '../../../widgets/text/custom_text_widget.dart';
import '../donation_center/donation_center_search_profile_screen.dart';
import '../sidebar.dart';
import 'package:medexer_donor/screens/home/sub_screens/medical_history_item_screen.dart';

class MedicalHistoryScreen extends StatefulWidget {
  const MedicalHistoryScreen({super.key});

  @override
  State<MedicalHistoryScreen> createState() => _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final NetworkManageController _networkManageController =
      Get.find<NetworkManageController>();
  final DonorServices donorServices = Get.find();
  final UserRepository userRepository = Get.find();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    donorServices.fetchMedicalHistoryController();

    return Scaffold(
      key: scaffoldKey,
      drawer: const SideBar(),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: Obx(
          () => _networkManageController.connectionType.value == 0
              ? Container()
              : Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.005),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PageHeader(scaffoldKey: scaffoldKey),
                    ],
                  ),
                ),
        ),
      ),
      body: Obx(
        () => (_networkManageController.connectionType.value == 0)
            ? const NetworkErrorMessage()
            : SingleChildScrollView(
                child: SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
                    width: double.maxFinite,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 2.0.hp),
                          // PageHeader(scaffoldKey: scaffoldKey),
                          Container(
                            width: double.maxFinite,
                            // padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                            child: Column(
                              children: [
                                CustomTextWidget(
                                  text: 'Medical History',
                                  size: 20,
                                  weight: FontWeight.w500,
                                ),
                                userRepository.medicalHistory.isEmpty
                                    ? Container(
                                        margin: EdgeInsets.only(top: 15.0.hp),
                                        child: Lottie.asset(
                                            'assets/animations/animation__5.json'),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(
                                            top: screenHeight * 0.01),
                                        height: screenHeight * 0.8,
                                        child: ListView.builder(
                                            itemCount: userRepository
                                                .medicalHistory.length,
                                            itemBuilder: (_, index) {
                                              return ListTile(
                                                tileColor: AppStyles.bgPrimary
                                                    .withOpacity(0.05),
                                                onTap: () {
                                                  Get.to(
                                                    () =>
                                                        MedicalHistoryItemScreen(
                                                      medicalHistoryItem:
                                                          userRepository
                                                                  .medicalHistory[
                                                              index],
                                                    ),
                                                  );
                                                },
                                                leading: CustomTextWidget(
                                                  text: '${index + 1}',
                                                  size: 12.0,
                                                ),
                                                title: CustomTextWidget(
                                                  text:
                                                      '${userRepository.medicalHistory[index].appointmentInfo!.appointmentID}',
                                                  size: 16.0,
                                                  color: AppStyles.bgPrimary,
                                                ),
                                                subtitle: CustomTextWidget(
                                                  text:
                                                      '${userRepository.medicalHistory[index].hospitalProfile!.hospitalName}',
                                                  size: 12.0,
                                                  color: AppStyles.bgBrightRed,
                                                ),
                                                trailing: CustomTextWidget(
                                                  text:
                                                      '${userRepository.medicalHistory[index].appointmentInfo!.donationDate}',
                                                  size: 10.0,
                                                ),
                                              );
                                            }),
                                      ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
      ),
    );
  }
}
