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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
        child: Container(
          margin: EdgeInsets.only(top: 0.5.hp),
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
                         
                            SizedBox(height: 2.0.hp),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        'Medexer seeks to increase the ease with which hospitals have access \n to blood and save lives by connecting hospitals directly to blood donors.',
                                    size: 16,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        'You an find and book appointments with blood donation centres by doing the following:\n',
                                    size: 16,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        ' 1. Navigate to Menu > Home \n 2. Enter the name of the hospital or donation centre on the search bar. \n 3. Click on the correct result that pops up. \n 4. Make a call or send an SMS to the hospital or donation centre to book an appointment. \n 5. Locate the donation centre by following the map directions.',
                                    size: 16,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        '\nYour request to book an appointment will have to be approved by the donation centre before you can donate blood. Note: You will have to wait for your KYC to be approved for you to fully use this app.',
                                    size:16,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        'Note: You will have to wait for your KYC to be approved for you to fully use this app.',
                                    size: 16,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        '\nALWAYS MAKE SURE THE DONATION CENTER YOU WERE CONTACTED BY IS VERIFIED!',
                                    size: 16,
                                    weight: FontWeight.w600,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text: 'To do so',
                                    size: 16,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        'Navigate to Menu > Donation Centers \nClick on Centers and paste the ID or phone number of the donation center. \nMake sure to see that it is a verified donation center, or DO NOT GO.',
                                    size:16,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text: '\nGot questions?',
                                    size: 16,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text:
                                        'Navigate to Menu > Contact Us and send us a message or \nyou can connect with us through any of \nour social media platforms.',
                                    size:16,
                                  ),
                                  CustomTextWidget(
                                    maxLines: 100,
                                    text: '',
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ]
                        )
                      ),
                ),
              ),
      ),
    );
  }
}
