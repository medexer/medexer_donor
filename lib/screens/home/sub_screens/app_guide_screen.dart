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
                        maxLines: 10,
                        text: "App Guide",
                        // size: 20.0.sp,
                        weight: FontWeight.w600,
                      ),
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
                      size: 14,
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
                      size: 14,
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
                          // SizedBox(height: 2.0.hp),
                          // PageHeader(scaffoldKey: scaffoldKey),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.0.wp,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(
                                  maxLines: 10,
                                  text: "Step 1: Download and Install the App",
                                  size: 16.0,
                                  weight: FontWeight.w600,
                                ),
                                CustomTextWidget(
                                  lineHeight: 2,
                                  maxLines: 100,
                                  text:
                                      "- Open your device's app store (Google Play Store for Android or Apple App Store for iOS). \n"
                                      '- Search for "Medexer" and find the official app.\n'
                                      '- Click "Install" to download and install the app on your device.',
                                  size: 14.0,
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                CustomTextWidget(
                                  maxLines: 10,
                                  text: "Step 2: Create an account",
                                  size: 16.0,
                                  weight: FontWeight.w600,
                                ),
                                CustomTextWidget(
                                  lineHeight: 2,
                                  maxLines: 100,
                                  text:
                                      '- Open the app and click on the "Sign Up" button. \n'
                                      "- Fill in your details, including name, email, and phone number.\n"
                                      "- Create a secure password and confirm it. \n"
                                      "- Alternatively, you can use your Google, Facebook or Apple accounts to sign up.",
                                  size: 14.0,
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                CustomTextWidget(
                                  maxLines: 10,
                                  text: "Step 3: Verify Your Account",
                                  size: 16.0,
                                  weight: FontWeight.w600,
                                ),
                                CustomTextWidget(
                                  lineHeight: 2,
                                  maxLines: 100,
                                  text:
                                      '- You will receive a verification code via email or SMS. \n'
                                      "- Enter the code in the app to verify your account.\n"
                                      "- Complete your KYC (Know Your Customer) process and get verified within 24 hours.",
                                  size: 14.0,
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                CustomTextWidget(
                                  maxLines: 10,
                                  text: "Step 4: Find Donation Centers",
                                  size: 16.0,
                                  weight: FontWeight.w600,
                                ),
                                CustomTextWidget(
                                  lineHeight: 2,
                                  maxLines: 100,
                                  text:
                                      '- When you are at the home page, Donation Centers near you will pop up on your map interface. \n'
                                      "- You can still click on the search bar and type in the name of the specific Donation Center you are looking for and the app will show you the list of centers that matches your search.\n"
                                      "- Alternatively, you can click on Donation Centers from the Menu and see the list of the ones within your axis.",
                                  size: 14.0,
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                CustomTextWidget(
                                  maxLines: 10,
                                  text: "Step 5: Schedule a Donation",
                                  size: 16.0,
                                  weight: FontWeight.w600,
                                ),
                                CustomTextWidget(
                                  lineHeight: 2,
                                  maxLines: 100,
                                  text:
                                      '- Select a Donation Center from the list of centers. \n'
                                      "- Confirm your appointment and submit.",
                                  size: 14.0,
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                CustomTextWidget(
                                  maxLines: 10,
                                  text: "Step 6: Donate Blood",
                                  size: 16.0,
                                  weight: FontWeight.w600,
                                ),
                                CustomTextWidget(
                                  lineHeight: 2,
                                  maxLines: 100,
                                  text:
                                      '- On the scheduled date, locate the chosen donation center by using the Center Location button after clicking on the donation center and follow the directions. \n'
                                      "- Show your app profile to the center staff for identification.\n"
                                      "- Follow the instructions given by the staff for the donation process.",
                                  size: 14.0,
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                CustomTextWidget(
                                  maxLines: 10,
                                  text: "Step 7: Track Your Donations",
                                  size: 16.0,
                                  weight: FontWeight.w600,
                                ),
                                CustomTextWidget(
                                  lineHeight: 2,
                                  maxLines: 100,
                                  text:
                                      '- The app will update your profile with the latest donation information with information provided by the Donation Center after you donate blood. You can access it by navigating to the menu and clicking on Medical History. \n'
                                      "- You can track your donation history and you will get notified instantly on how many lives you've impacted!",
                                  size: 14.0,
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                CustomTextWidget(
                                  maxLines: 10,
                                  text: "Step 8: Notifications",
                                  size: 16.0,
                                  weight: FontWeight.w600,
                                ),
                                CustomTextWidget(
                                  lineHeight: 2,
                                  maxLines: 100,
                                  text:
                                      '- Receive notifications about upcoming donation drives, events, appointments and urgent blood needs by navigating to Menu > Notifications. ',
                                  size: 14.0,
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                CustomTextWidget(
                                  maxLines: 10,
                                  text: "Step 9: Rewards and Compensation",
                                  size: 16.0,
                                  weight: FontWeight.w600,
                                ),
                                CustomTextWidget(
                                  lineHeight: 2,
                                  maxLines: 100,
                                  text:
                                      '- We have made arrangements with the Donation Centers to appropriately compensate all blood donors with at the very least, their transport fare. \n'
                                      "- We are working hard on more robust compensation packages by partnering with a number reward system providers who are impact focused, and mission driven!",
                                  size: 14.0,
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                CustomTextWidget(
                                  maxLines: 10,
                                  text: "Step 10: Share Your Experience",
                                  size: 16.0,
                                  weight: FontWeight.w600,
                                ),
                                CustomTextWidget(
                                  lineHeight: 2,
                                  maxLines: 100,
                                  text:
                                      '- Use the app to share your donation experience with others. \n'
                                      "- Encourage friends and family to join the Medexer blood donor community.",
                                  size: 14.0,
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                CustomTextWidget(
                                  lineHeight: 2,
                                  maxLines: 100,
                                  text:
                                      "Always keep in mind that your action today may be the difference between death and life for someone. Who knows? Have a fun-filled experience!",
                                  size: 14.0,
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                          )
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
