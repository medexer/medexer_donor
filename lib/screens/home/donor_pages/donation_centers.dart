//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/screens/home/appointmentPages/book_appointment.dart';
import 'package:medexer_donor/services/donor_services.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    donorServices.fetchDonationCentersController();

    return Obx(
      () => Column(
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
                          title: CustomTextWidget(
                            text:
                                '${userRepository.donationCenters[index].hospitalName}',
                            size: 12.0.sp,
                          ),
                          subtitle: CustomTextWidget(
                            text:
                                '${userRepository.donationCenters[index].location}',
                            size: 8.0.sp,
                          ),
                          trailing: CustomButton(
                            text: 'Book Apointment',
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
                            fontWeight: FontWeight.bold,
                            height: 4.0.hp,
                            width: 22.0.wp,
                          ),
                        );
                      }),
                ),
        ],
      ),
    );
  }
}
