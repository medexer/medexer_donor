// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/services/donor_services.dart';
import 'package:medexer_donor/widgets/cards/notification_card.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final DonorServices donorServices = Get.find();
  final UserRepository userRepository = Get.find();

  @override
  void initState() {
    super.initState();

    donorServices.fetchNotificationsController();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Container(
              // height: screenHeight,
              padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
              child: Column(
                children: [
                  SizedBox(
                    height: 2.5.hp,
                  ),
                  PageHeader(scaffoldKey: scaffoldKey),
                  CustomTextWidget(
                    text: 'Notifications',
                    size: 16.0.sp,
                    weight: FontWeight.w600,
                  ),
                  userRepository.notifications.isEmpty
                      ? Container(
                          child: Lottie.asset(
                              'assets/animations/animation__1.json'),
                        )
                      : Container(
                          height: screenHeight * 0.85,
                          child: ListView.builder(
                              itemCount: userRepository.notifications.length,
                              itemBuilder: (context, index) {
                                return NotificationCard(
                                    notification:
                                        userRepository.notifications[index]);
                              }),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
