// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/home/about_us_screen.dart';
import 'package:medexer_donor/screens/home/app_guide_screen.dart';
import 'package:medexer_donor/screens/home/contact_us_screen.dart';
import 'package:medexer_donor/screens/home/donor_centers.dart';
import 'package:medexer_donor/screens/home/home_screen.dart';
import 'package:medexer_donor/screens/home/notification_screen.dart';
import 'package:medexer_donor/screens/home/rewards_wallet_screen.dart';
import 'package:medexer_donor/screens/home/settings_screen.dart';

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
            title: Text('Notification'),
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
        ],
      ),
    );
  }
}
