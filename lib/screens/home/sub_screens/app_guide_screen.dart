// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/config/app_config.dart';

import '../../../network_services/network_error_message.dart';
import '../../../network_services/network_manager.dart';

class AppGuideScreen extends StatefulWidget {
  const AppGuideScreen({super.key});

  @override
  State<AppGuideScreen> createState() => _AppGuideScreenState();
}

class _AppGuideScreenState extends State<AppGuideScreen> {
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
      bottomNavigationBar: Obx(
        () => _networkManageController.connectionType.value == 0
            ? Container()
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      maxLines: 10,
                      text: 'Made with',
                      size: 16,
                    ),
                    SizedBox(width: 2.0.wp),
                    Icon(
                      Icons.favorite_border_outlined,
                      color: AppStyles.bgBrightRed.withOpacity(0.4),
                    ),
                    SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      maxLines: 10,
                      text: 'in',
                      size: 16,
                    ),
                    SizedBox(width: 2.0.wp),
                    Container(
                      width: 6.0.wp,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/flagNigeria.png'),
                        ),
                      ),
                      // child: Image.asset(),
                    ),
                  ],
                ),
              ),
      ),
      body: Obx(
        () => (_networkManageController.connectionType.value == 0)
            ? const NetworkErrorMessage()
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 2.5.hp,
                          ),
                          CustomTextWidget(
                            maxLines: 10,
                            text: "Guide on how to use the app",
                            // size: 20.0.sp,
                            weight: FontWeight.w600,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 3.0.wp,
                                        top: .0.hp,
                                        right: 3.0.wp),
                                    child: CustomTextWidget(
                                      maxLines: 10,
                                      text:
                                          "Medexer seeks to increase the ease with which hospitals have access to blood and saves lives by connecting hospitals directly to blood donors.\n\nYou find and book appointments with blood donation centers by doing the following:"
                                          "\n*\tNavigate to Menu > Home\n*\tEnter the name of the hospital or donation centre on the search bar.\n*\tClick on the correct result that pops up. \n*\tMake a call or send SMS to the hospital or donation centre to book an appointment.\n*\tLocate the donation centre by following the map directions\n\nYour request to book an appointment will have to be approved by the donation centre before you can donate blood."
                                          "\n Your request to book an appointment will have to be approved by the donation center before you can donate blood",
                                      size: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.0.hp,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Wrap(
                                      children: [
                                        CustomTextWidget(
                                          maxLines: 10,
                                          text: "Note: ",
                                          size: 16,
                                          weight: FontWeight.bold,
                                        ),
                                        CustomTextWidget(
                                          maxLines: 10,
                                          text:
                                              "You will have to wait for your KYC to be approved for you to fully use this app.",
                                          size: 16,
                                          weight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(children: [
                                      CustomTextWidget(
                                        maxLines: 10,
                                        text:
                                            "ALWAYS MAKE SURE THE DONATION CENTER YOU WERE CONTRACTED BY IS VERIFIED",
                                        size: 16,
                                        weight: FontWeight.w600,
                                      ),
                                      CustomTextWidget(
                                        maxLines: 10,
                                        text: "To do so: "
                                            "Navigate to Main > Donation Centers \n*\tMake sure to see that it is a verified donation center or  DO NOT GO.\n \nGot questions?\nNaviagte to > Menu > Contact Us and send us a message or you can connect with us through any of our social media platforms.",
                                        size: 16,
                                        //weight: FontWeight.bold,
                                      ),
                                    ]),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
