// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/network_services/network_manager.dart';
import 'package:medexer_donor/screens/home/sub_screens/about_us_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/app_guide_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/contact_us_screen.dart';
import 'package:medexer_donor/screens/home/donor_pages/donor_centers.dart';
import 'package:medexer_donor/screens/home/sub_screens/home_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/notifications_screen.dart';
import 'package:medexer_donor/screens/home/donor_profile.dart/profile_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/pending_reward_screen.dart';
import 'package:medexer_donor/services/auth_services.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'sub_screens/medical_history_screen.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final authStorage = GetStorage();
  final UserRepository userRepository = Get.find();
  final AuthServices authServices = Get.find();
  final NetworkManageController _networkManageController =
      Get.find<NetworkManageController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.65,
      child: ListView(
        padding: EdgeInsets.only(top: 5.0.hp),
        children: [
          Obx(
            () => ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: AppStyles.bgWhite,
                backgroundImage: NetworkImage(
                    '${userRepository.userProfile.value.userAvatar}'),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: CustomTextWidget(
                      maxLines: 2,
                      text: '${userRepository.userData.value.fullName}',
                      // size: 14.0,
                      size: 14,
                    ),
                  ),
                  // CustomTextWidget(
                  //   text: _networkManageController.connectionType.value == 1
                  //       ? "online"
                  //       : _networkManageController.connectionType.value == 2
                  //           ? 'online'
                  //           : 'offline',
                  //   size: 8.0.sp,
                  //   // style: TextStyle(
                  //   //     fontSize: 8, color: AppStyles.bgPrimary),
                  // ),
                  // GetBuilder(builder:(builder)=>CustomTextWidget(text:'${_networkManageController.connectionType}'))
                  // ?:Icon(Icons.online_prediction, color:Colors.green))
                  // onTap: () async {
                  //   debugPrint('[LOG OUT]');

                  //   await authServices.signoutController();
                  // },
                ],
              ),
              subtitle: CustomTextWidget(
                text: 'Profile',
                // size: 14.0,
                size: 14,
                // size: MediaQuery.of(context).size.width * 0.034,
              ),
              onTap: () {
                Get.to(() => ProfileScreen());
                debugPrint('[PROFILE]');
              },
            ),
          ),
          Divider(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          GestureDetector(
            onTap: () {
              Get.to(() => HomeScreen());
              debugPrint('[FAV]');
            },
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                SvgPicture.asset(
                  'assets/icons/icon__home.svg',
                  color: AppStyles.bgPrimary,
                  width: 16.0.sp,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                CustomTextWidget(
                  text: 'Home',
                  size: 14.0,
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          GestureDetector(
            onTap: () {
              Get.to(() => DonorCentersScreen());
              debugPrint('[DONOR-CENTERS]');
            },
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                SvgPicture.asset(
                  'assets/icons/icon__location.svg',
                  color: AppStyles.bgPrimary,
                  width: 18.0.sp,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                CustomTextWidget(
                  text: 'Donation Centers',
                  size: 14.0,
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          GestureDetector(
            onTap: () {
              Get.to(() => MedicalHistoryScreen());
              debugPrint('[MEDICAL-HISTORY]');
            },
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                SvgPicture.asset(
                  'assets/icons/icon__virus.svg',
                  color: AppStyles.bgPrimary,
                  width: 18.0.sp,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                CustomTextWidget(
                  text: 'Medical History',
                  size: 14.0,
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          GestureDetector(
            onTap: () {
              Get.to(() => AppGuideScreen());
              debugPrint('[APP-GUIDE]');
            },
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                SvgPicture.asset(
                  'assets/icons/icon__file.svg',
                  color: AppStyles.bgPrimary,
                  width: 18.0.sp,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                CustomTextWidget(
                  text: 'Guide',
                  size: 14.0,
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          GestureDetector(
            onTap: () {
              Get.to(() => PendingRewardScreen());
              // Get.to(() => RewardsWalletScreen());
              debugPrint('[REWARDS-WALLET]');
            },
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                SvgPicture.asset(
                  'assets/icons/icon__wallet.svg',
                  color: AppStyles.bgPrimary,
                  width: 16.0.sp,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                CustomTextWidget(
                  text: 'Rewards',
                  size: 14.0,
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          GestureDetector(
            onTap: () {
              Get.to(() => ContactUsScreen());
              // Get.to(() => RewardsWalletScreen());
              debugPrint('[CONTACT-US]');
            },
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                SvgPicture.asset(
                  'assets/icons/icon__call.svg',
                  color: AppStyles.bgPrimary,
                  width: 18.0.sp,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                CustomTextWidget(
                  text: 'Contact Us',
                  size: 14.0,
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          GestureDetector(
            onTap: () {
              Get.to(() => NotificationsScreen());
              debugPrint('[NOTIFICATIONS]');
            },
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                SvgPicture.asset(
                  'assets/icons/icon__message.svg',
                  color: AppStyles.bgPrimary,
                  width: 18.0.sp,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                CustomTextWidget(
                  text: 'Notification',
                  size: 14.0,
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          GestureDetector(
            onTap: () {
              Get.to(() => AboutUsScreen());
              debugPrint('[ABOUT-US]');
            },
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                SvgPicture.asset(
                  'assets/icons/icon__heart.svg',
                  color: AppStyles.bgPrimary,
                  width: 18.0.sp,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                CustomTextWidget(
                  text: 'About Us',
                  size: 14.0,
                ),
              ],
            ),
          ),
          // Row(),
          // Row(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.035),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          GestureDetector(
            onTap: () async {
              debugPrint('[LOG OUT]');

              await authServices.signoutController();
            },
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                Icon(
                  Icons.logout,
                  color: AppStyles.bgBrightRed,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                CustomTextWidget(
                  text: 'Log out',
                  size: 14.0,
                  color: AppStyles.bgBrightRed,
                  // style: TextStyle(color: AppStyles.bgBrightRed),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
