// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/api_config.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/models/donation_center_model.dart';
import 'package:medexer_donor/screens/home/appointmentPages/book_appointment.dart';
import 'package:medexer_donor/screens/home/donation_center/donation_center_location_screen.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/services/donor_services.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class DonationCenterSearchProfileScreen extends StatefulWidget {
  final DonationCenterModel donationCenter;
  const DonationCenterSearchProfileScreen(
      {super.key, required this.donationCenter});

  @override
  State<DonationCenterSearchProfileScreen> createState() =>
      _DonationCenterSearchProfileScreenState();
}

class _DonationCenterSearchProfileScreenState
    extends State<DonationCenterSearchProfileScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String name = '';
  String named = '';
  final DonorServices donorServices = Get.find();
  final UserRepository userRepository = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: const SideBar(),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: 'Book Appointment',
              height: screenHeight * 0.06,
              width: MediaQuery.of(context).size.width * 0.9,
              onTapHandler: () {
                Get.to(
                  BookAppointmentScreen(
                    donationCenter: widget.donationCenter,
                  ),
                );
              },
              fontSize: 16.0,
              fontColor: Colors.white,
              fontWeight: FontWeight.bold,
              borderRadius: 15,
              backgroundColor: AppStyles.bgPurpleDark,
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.35),
        child: Container(
          decoration: BoxDecoration(
            image: widget.donationCenter.hospitalProfile!.hospitalImage != ""
                ? DecorationImage(
                    image: NetworkImage(
                        '${widget.donationCenter.hospitalProfile!.hospitalImage}'),
                    // '${APIConstants.backendServerRootUrl}${widget.donationCenter.hospitalProfile!.hospitalImage}'),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  )
                : const DecorationImage(
                    image: AssetImage('assets/images/hospital__2.jpg'),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // height: screenHeight,
            padding: EdgeInsets.symmetric(
              vertical: 2.0.hp,
              horizontal: 5.0.wp,
            ),
            child: Column(
              children: [
                // PageHeader(scaffoldKey: scaffoldKey),
                CustomTextWidget(
                  text: '${widget.donationCenter.hospitalName}',
                  size: 18.0,
                  weight: FontWeight.w500,
                ),
                SizedBox(height: 1.0.hp),
                Row(
                  children: [
                    CustomTextWidget(
                      text: 'About',
                      size: 16.0,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: widget.donationCenter.hospitalProfile
                                  ?.aboutHospital !=
                              null
                          ? CustomTextWidget(
                              maxLines: 100,
                              text:
                                  '${widget.donationCenter.hospitalName}, ${widget.donationCenter.hospitalProfile?.aboutHospital}',
                              size: 16.0,
                              // weight: FontWeight.w500,
                            )
                          : Container(),
                    ),
                  ],
                ),
                SizedBox(height: 1.0.hp),
                Row(
                  children: [
                    CustomTextWidget(
                      text: 'Address: ',
                      size: 16.0,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: widget.donationCenter.centerAddress != null
                          ? CustomTextWidget(
                              text: '${widget.donationCenter.centerAddress}',
                              size: 16.0,
                              // weight: FontWeight.w500,
                            )
                          : Container(),
                    ),
                  ],
                ),
                SizedBox(height: 1.0.hp),
                Row(
                  children: [
                    CustomTextWidget(
                      text: 'Contact number: ',
                      size: 16.0,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: widget.donationCenter.hospitalProfile!
                                  .contactNumber !=
                              null
                          ? CustomTextWidget(
                              text:
                                  '${widget.donationCenter.hospitalProfile!.contactNumber}',
                              size: 16.0,
                              // weight: FontWeight.w500,
                            )
                          : Container(),
                    ),
                  ],
                ),
                SizedBox(height: 1.0.hp),
                Row(
                  children: [
                    CustomTextWidget(
                      text: 'Email: ',
                      size: 16.0,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextWidget(
                        text: '${widget.donationCenter.email}',
                        size: 16.0,
                        // weight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.0.hp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
                SizedBox(height: 4.0.hp),
                CustomButton(
                  text: 'Call',
                  width: double.maxFinite,
                  height: screenHeight * 0.06,
                  onTapHandler: () async {
                    final Uri contactNumberUrl = Uri.parse(
                        'tel:${widget.donationCenter.hospitalProfile!.contactNumber}');
                    if (await canLaunchUrl(contactNumberUrl)) {
                      await launchUrl(contactNumberUrl);
                    } else {
                      throw 'Could not launch $contactNumberUrl';
                    }
                  },
                  fontSize: 16.0,
                  borderRadius: 5,
                  fontColor: Colors.white,
                  fontWeight: FontWeight.w500,
                  backgroundColor: AppStyles.bgBlue,
                ),
                SizedBox(height: 2.0.hp),
                CustomButton(
                  text: 'Message',
                  width: double.maxFinite,
                  height: screenHeight * 0.06,
                  onTapHandler: () async {
                    final Uri contactNumberUrl =
                        Uri.parse('sms:+2349020029920');
                    if (await canLaunchUrl(contactNumberUrl)) {
                      await launchUrl(contactNumberUrl);
                    } else {
                      throw 'Could not launch $contactNumberUrl';
                    }
                  },
                  fontSize: 16.0,
                  borderRadius: 5,
                  fontColor: Colors.white,
                  fontWeight: FontWeight.w500,
                  backgroundColor: Colors.deepPurple,
                ),
                SizedBox(height: 2.0.hp),
                CustomButton(
                  text: 'Center Location',
                  width: double.maxFinite,
                  height: screenHeight * 0.06,
                  onTapHandler: () {
                    Get.to(
                      () => DonationCenterLocationScreen(
                        donationCenter: widget.donationCenter,
                      ),
                    );
                  },
                  fontSize: 16.0,
                  borderRadius: 5,
                  fontColor: Colors.white,
                  fontWeight: FontWeight.w500,
                  backgroundColor: AppStyles.bgPrimary,
                ),
                // SizedBox(height: 2.0.hp),
                // CustomButton(
                //   text: 'Location',
                //   width: double.maxFinite,
                //   // width: 35.0.wp,
                //   height: 6.0.hp,
                //   onTapHandler: () {
                //     Get.to(
                //       () => DonationCenterLocationScreen(
                //         donationCenter: widget.donationCenter,
                //       ),
                //     );
                //   },
                //   fontSize: 16.0,
                //   borderRadius: 5,
                //   fontColor: Colors.white,
                //   fontWeight: FontWeight.w500,
                //   backgroundColor: Colors.teal,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
