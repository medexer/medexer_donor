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

class MedicalScreen extends StatefulWidget {
  const MedicalScreen({super.key});

  @override
  State<MedicalScreen> createState() => _MedicalScreenState();
}

class _MedicalScreenState extends State<MedicalScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
      final NetworkManageController _networkManageController = Get.find<NetworkManageController>();
       final DonorServices donorServices = Get.find();
       final UserRepository userRepository = Get.find();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    donorServices.fetchMedicalHistoryController;
    return Scaffold(
      key: scaffoldKey,
      drawer: const SideBar(),
      body: Obx(()=>(_networkManageController.connectionType.value == 0)?const NetworkErrorMessage():       
        SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
              width: double.maxFinite,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.0.hp),
                  PageHeader(scaffoldKey: scaffoldKey),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                    child: Column(
                      children: [
                        CustomTextWidget(
                          text: 'MEDICAL HISTORY',
                          weight: FontWeight.w600,
                        ),
                        userRepository.medicalHistory.isEmpty
                        ? Container(
                          child: Lottie.asset('assets/animations/animation__3.json'),
                        ):
                        Container(
                          height: screenHeight * 0.8,
                          child: ListView.builder(
                            itemCount: userRepository.medicalHistory.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              Get.to(
                                () =>{} 
                                // DonationCenterSearchProfileScreen(
                                //   donationCenter:
                                //       userRepository.medicalHistory[index],
                                // ),
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: AppStyles.bgBlue,
                              child: SvgPicture.asset(
                                'assets/icons/icon__medical.svg',
                                color: AppStyles.bgWhite,
                              ),
                            ),
                          ),
                          title: GestureDetector(
                            onTap: () {
                              Get.to(
                                () =>{} 
                                // DonationCenterSearchProfileScreen(
                                //   donationCenter:
                                //       userRepository.medicalHistory[index],
                                // ),
                              );
                            },
                            child: CustomTextWidget(
                              text:
                                  '${userRepository.medicalHistory[index].hiv}',
                              size: 12.0.sp,
                            ),
                          ),
                          subtitle: GestureDetector(
                            onTap: () {
                              Get.to(
                                () =>{} 
                                // DonationCenterSearchProfileScreen(
                                //   donationCenter:
                                //       userRepository.medicalHistory[index],
                                // ),
                              );
                            },
                            child: CustomTextWidget(
                              text:
                                  '${userRepository.medicalHistory[index].hepatitisC}',
                              size: 8.0.sp,
                            ),
                          ),
                        );
                      }),
                    ),
                          ],
                        ),
                      ),
                    ]
                  ),
                )
              )  
            )
        ), 
    );
  }
}