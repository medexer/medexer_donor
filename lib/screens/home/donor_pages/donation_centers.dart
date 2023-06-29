//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/screens/home/appointmentPages/book_appointment.dart';
import 'package:medexer_donor/screens/home/donation_center/donation_center_search_profile_screen.dart';
import 'package:medexer_donor/services/donor_services.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

import '../../../network_services/network_error_message.dart';
import '../../../network_services/network_manager.dart';

class DonationCenters extends StatefulWidget {
  final double height;
  const DonationCenters({super.key, required this.height});

  @override
  State<DonationCenters> createState() => _DonationCentersState();
}

class _DonationCentersState extends State<DonationCenters> {
  final DonorServices donorServices = Get.find();
  final UserRepository userRepository = Get.find();
  TextEditingController searchController = TextEditingController();
  
final NetworkManageController _networkManageController = Get.find<NetworkManageController>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    donorServices.fetchDonationCentersController();

    return Obx(
            () =>(_networkManageController.connectionType.value == 0)?const NetworkErrorMessage():
       Column(
        children: [
          userRepository.donationCenters.isEmpty
              ? Container(
                  child: Lottie.asset('assets/animations/animation__3.json'),
                )
              : Container(
                  // height: widget.height,
                  height: screenHeight * 0.8,
                  child: ListView.builder(
                      itemCount: userRepository.donationCenters.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => DonationCenterSearchProfileScreen(
                                  donationCenter:
                                      userRepository.donationCenters[index],
                                ),
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
                                () => DonationCenterSearchProfileScreen(
                                  donationCenter:
                                      userRepository.donationCenters[index],
                                ),
                              );
                            },
                            child: CustomTextWidget(
                              text:
                                  '${userRepository.donationCenters[index].hospitalName}',
                              size: 12.0.sp,
                            ),
                          ),
                          subtitle: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => DonationCenterSearchProfileScreen(
                                  donationCenter:
                                      userRepository.donationCenters[index],
                                ),
                              );
                            },
                            child: CustomTextWidget(
                              text:
                                  '${userRepository.donationCenters[index].centerAddress}',
                              size: 8.0.sp,
                            ),
                          ),
                          trailing: CustomButton(
                            text: 'Book Appointment',
                            borderRadius: 10,
                            fontColor: Colors.white,
                            backgroundColor: AppStyles.bgBlue,
                            fontSize: 8.0.sp,
                            onTapHandler: () {
                              Get.to(
                                BookAppointmentScreen(
                                  donationCenter:
                                      userRepository.donationCenters[index],
                                ),
                              );
                            },
                            fontWeight: FontWeight.w500,
                            height: 4.0.hp,
                            width: 25.0.wp,
                          ),
                        );
                      }),
                ),
        ],
      ),
    );
  }
}
