// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

import '../../../network_services/network_error_message.dart';
import '../../../network_services/network_manager.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final NetworkManageController _networkManageController =
      Get.find<NetworkManageController>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
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
                      CustomTextWidget(
                        text: 'About Us',
                        weight: FontWeight.w600,
                      ),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        'Medexer seeks to increase the ease with which hospitals have access to blood and save lives by connecting hospitals directly to blood donors. We do this by utilizing two digital platforms, harnessing the power of geolocation technology (like Uber), for the hospitals and the donors, where the hospital in need of blood can search for and contact the closest matching donors, especially during cases of emergency, and donors can also search for, and book blood donation appointments with hospitals or blood banks.\n',
                                    size: 14.0,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        'At Medexer, we understand the critical role that blood transfusions play in saving lives. Unfortunately, the process of blood donation and transfusion can be complex, time-consuming, and sometimes even inaccessible for many people. Our platform seeks to change that by creating a convenient, easy-to-use, and secure platform where hospitals and blood donors can connect with ease.\n',
                                    size: 14.0,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        'Our platform allows you to easily search for, and book blood donation appointments at your convenience with just a few clicks.\n',
                                    size: 14.0,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        'Our platform allows hospitals to search for and identify donors who are eligible to donate blood. Hospitals can make requests to potential donors based on the donor\'s blood type, location, and other factors by identifying them via the desktop app and contacting them via phone call. Once a donor accepts the request, the platform will schedule an appointment and provide the necessary details, such as the location, time, and date of the donation.\n',
                                    size: 14,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        'For donors, our platform offers a convenient way to donate blood, with the flexibility to choose the location and time that work best for them. Donors can sign up on our platform, and we will notify them when a hospital needs their blood type. They can then choose to accept or reject the request, depending on their availability.\n',
                                    size: 14.0,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        'At Medexer, we prioritize the safety and security of our users. Our platform follows strict data protection guidelines, and we take all necessary measures to ensure that donor and hospital information is kept confidential. We will also try to ensure that blood donors are compensated properly to boost their morale to donate next time and save lives.\n',
                                    size: 14.0,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        'We are also committed to educating the public about the importance of blood donation and transfusion. Through our platform, we provide educational resources and materials that help potential donors understand the donation process, the benefits of blood donation, and the impact it can have on saving lives.\n',
                                    size: 14.0,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        'Join us today and be a part of our mission to save lives through blood donation and transfusion. Tell a friend to tell a friend to sign up on our platform as a donor or a hospital and help us make a difference in the world.\n',
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ])),
                ),
              ),
      ),
    );
  }
}
