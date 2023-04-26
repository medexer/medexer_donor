// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medexer_donor/config/api_config.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/screens/auth/login_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/about_us_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/app_guide_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/contact_us_screen.dart';
import 'package:medexer_donor/screens/home/donor_pages/donor_centers.dart';
import 'package:medexer_donor/screens/home/sub_screens/home_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/notifications_screen.dart';
import 'package:medexer_donor/screens/home/donor_profile.dart/profile_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/rewards_wallet_screen.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final authStorage = GetStorage();
  final UserRepository userRepository = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 4.0.hp),
        children: [
          Obx(
            () => ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    '${APIConstants.backendServerRootUrl}${userRepository.userData.value.avatar}'),
                // backgroundImage: AssetImage('assets/images/avatar__1.jpg'),
              ),
              title: Text('${userRepository.userData.value.fullName}'),
              subtitle: Text('Profile'),
              onTap: () {
                Get.to(() => ProfileScreen());
                debugPrint('[PROFILE]');
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: ImageIcon(
              AssetImage('assets/icons/icon__home.png'),
              color: AppStyles.bgBlue,
            ),
            title: CustomTextWidget(
              text: 'Home',
              size: 12.0.sp,
            ),
            onTap: () {
              Get.to(() => HomeScreen());
              debugPrint('[FAV]');
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage('assets/icons/icon__location.png'),
              color: AppStyles.bgBlue,
            ),
            title: CustomTextWidget(
              text: 'Donor Centers',
              size: 12.0.sp,
            ),
            onTap: () {
              Get.to(() => DonorCentersScreen());
              debugPrint('[DONOR-CENTERS]');
            },
          ),
          // ListTile(
          //   leading: ImageIcon(
          //     AssetImage('assets/icons/icon__info.png'),
          //     color: AppStyles.bgBlue,
          //   ),
          //   title: CustomTextWidget(
          //     text: 'Guide',
          //     size: 12.0.sp,
          //   ),
          //   onTap: () {
          //     Get.to(() => AppGuideScreen());
          //     debugPrint('[APP-GUIDE]');
          //   },
          // ),
          ListTile(
            leading: ImageIcon(
              AssetImage('assets/icons/icon__wallet.png'),
              color: AppStyles.bgBlue,
            ),
            title: CustomTextWidget(
              text: 'Rewards/Wallet',
              size: 12.0.sp,
            ),
            onTap: () {
              Get.to(() => RewardsWalletScreen());
              debugPrint('[REWARDS-WALLET]');
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage('assets/icons/icon__call.png'),
              color: AppStyles.bgBlue,
            ),
            title: CustomTextWidget(
              text: 'Contact Us',
              size: 12.0.sp,
            ),
            onTap: () {
              Get.to(() => ContactUsScreen());
              debugPrint('[CONTACT-US]');
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage('assets/icons/icon__notification.png'),
              color: AppStyles.bgBlue,
            ),
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextWidget(
                  text: 'Notification',
                  size: 12.0.sp,
                ),
                SizedBox(width: 1.0.wp),
                ClipOval(
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: AppStyles.bgPrimary,
                    ),
                    child: Center(
                      child: CustomTextWidget(
                        text: 'New',
                        size: 8.0.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.to(() => NotificationsScreen());
              debugPrint('[NOTIFICATIONS]');
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage('assets/icons/icon__favourite.png'),
              color: AppStyles.bgBlue,
            ),
            title: CustomTextWidget(
              text: 'About Us',
              size: 12.0.sp,
            ),
            onTap: () {
              Get.to(() => AboutUsScreen());
              debugPrint('[ABOUT-US]');
            },
          ),
          // ListTile(
          //   leading: ImageIcon(
          //     AssetImage('assets/icons/icon__settings.png'),
          //     color: AppStyles.bgBlue,
          //   ),
          //   title: CustomTextWidget(
          //     text: 'Settings',
          //     size: 12.0.sp,
          //   ),
          //   onTap: () {
          //     Get.to(() => SettingsScreen());
          //     debugPrint('[SETTINGS]');
          //   },
          // ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: AppStyles.bgPrimary,
            ),
            title: Text(
              'Log out',
              style: TextStyle(color: AppStyles.bgPrimary),
            ),
            onTap: () async {
              debugPrint('[LOG OUT]');

              await authStorage.remove('MDX-USER');

              Get.to(
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 500),
                () => LoginScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}
