// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/api_config.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/models/donation_center_model.dart';
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
              text: 'Center Location',
              height: 6.0.hp,
              width: MediaQuery.of(context).size.width * 0.9,
              onTapHandler: () {
                Get.to(
                  () => DonationCenterLocationScreen(
                    donationCenter: widget.donationCenter,
                  ),
                );
              },
              fontSize: 10.0.sp,
              fontColor: Colors.white,
              fontWeight: FontWeight.bold,
              borderRadius: 10,
              backgroundColor: AppStyles.bgPrimary,
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
                  size: 14.0.sp,
                  weight: FontWeight.w500,
                ),
                SizedBox(height: 1.0.hp),
                Row(
                  children: [
                    CustomTextWidget(
                      text: 'About',
                      size: 12.0.sp,
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
                              text:
                                  '${widget.donationCenter.hospitalName}, ${widget.donationCenter.hospitalProfile?.aboutHospital}',
                              size: 12.0.sp,
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
                      size: 12.0.sp,
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
                              size: 12.0.sp,
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
                      size: 12.0.sp,
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
                              size: 12.0.sp,
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
                      size: 12.0.sp,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextWidget(
                        text: '${widget.donationCenter.email}',
                        size: 12.0.sp,
                        // weight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.0.hp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      text: 'Call',
                      width: 35.0.wp,
                      height: 4.5.hp,
                      onTapHandler: () async {
                        final Uri contactNumberUrl = Uri.parse(
                            'tel:${widget.donationCenter.hospitalProfile!.contactNumber}');
                        if (await canLaunchUrl(contactNumberUrl)) {
                          await launchUrl(contactNumberUrl);
                        } else {
                          throw 'Could not launch $contactNumberUrl';
                        }
                      },
                      fontSize: 10.0.sp,
                      borderRadius: 5,
                      fontColor: Colors.white,
                      fontWeight: FontWeight.w500,
                      backgroundColor: AppStyles.bgBlue,
                    ),
                    CustomButton(
                      text: 'Message',
                      width: 35.0.wp,
                      height: 4.5.hp,
                      onTapHandler: () async {
                        final Uri contactNumberUrl =
                            Uri.parse('sms:+2349020029920');
                        if (await canLaunchUrl(contactNumberUrl)) {
                          await launchUrl(contactNumberUrl);
                        } else {
                          throw 'Could not launch $contactNumberUrl';
                        }
                      },
                      fontSize: 10.0.sp,
                      borderRadius: 5,
                      fontColor: Colors.white,
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.deepPurple,
                    ),
                  ],
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
                //   fontSize: 10.0.sp,
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
