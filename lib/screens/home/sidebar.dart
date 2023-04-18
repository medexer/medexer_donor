// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/home/sub_screens/about_us_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/app_guide_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/contact_us_screen.dart';
import 'package:medexer_donor/screens/home/donor_pages/donor_centers.dart';
import 'package:medexer_donor/screens/home/sub_screens/home_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/notification_screen.dart';
import 'package:medexer_donor/screens/auth/donor_profile.dart/profile_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/rewards_wallet_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/settings_screen.dart';

import '../../widgets/buttons/custom_button.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 4.0.hp),
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/avatar__1.jpg'),
            ),
            title: Text('John Doe'),
            subtitle: Text('Profile'),
            onTap: () {
              Get.to(()=>ProfileScreen());
              debugPrint('[PROFILE]');
            },
          ),
          Divider(),
          ListTile(
            leading: ImageIcon(
              AssetImage('assets/icons/icon__home.png'),
              color: AppStyles.bgBlue,
            ),
            title: Text('Home'),
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
            title: Text('Donor Centers'),
            onTap: () {
              Get.to(() => DonorCentersScreen());
              debugPrint('[DONOR-CENTERS]');
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage('assets/icons/icon__info.png'),
              color: AppStyles.bgBlue,
            ),
            title: Text('Guide'),
            onTap: () {
              Get.to(() => AppGuideScreen());
              debugPrint('[APP-GUIDE]');
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage('assets/icons/icon__wallet.png'),
              color: AppStyles.bgBlue,
            ),
            title: Text('Rewards/Wallet'),
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
            title: Text('Contact Us'),
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
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children: [
                Text('Notification'),
                 CustomButton(
                  text: 'New',
                  width: 20.0.wp,                    
                  height: 5.0.hp,
                  onTapHandler: (){
                  },
                  fontSize: 10.0.sp,
                  fontColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  borderRadius: 30,
                  backgroundColor: AppStyles.bgPrimary),
              ],
            ),
            onTap: () {
              Get.to(() => NotificationScreen());
              debugPrint('[NOTIFICATIONS]');
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage('assets/icons/icon__favourite.png'),
              color: AppStyles.bgBlue,
            ),
            title: Text('About Us'),
            onTap: () {
              Get.to(() => AboutUsScreen());
              debugPrint('[ABOUT-US]');
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage('assets/icons/icon__settings.png'),
              color: AppStyles.bgBlue,
            ),
            title: Text('Settings'),
            onTap: () {
              Get.to(() => SettingsScreen());
              debugPrint('[SETTINGS]');
            },
          ),

          ListTile(
            leading: Icon(Icons.logout, color: AppStyles.bgPrimary,),
            title: Text('Log out', style: TextStyle(color: AppStyles.bgPrimary),),
            onTap: () {
              debugPrint('[LOG OUT]');
            },
          ),
        ],
      ),
    );
  }
}
