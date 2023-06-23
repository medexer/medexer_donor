// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/models/notification_model.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/services/donor_services.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

import '../../../network_services/network_error_message.dart';
import '../../../network_services/network_manager.dart';

class NotificationScreen extends StatefulWidget {
  final NotificationModel notification;
  const NotificationScreen({super.key, required this.notification});

  @override
  State<NotificationScreen> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final DonorServices donorServices = Get.find();
   final NetworkManageController _networkManageController = Get.find<NetworkManageController>();

  @override
  void initState() {
    super.initState();

    donorServices.readNotificationsController(widget.notification.pkid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      body: Obx(()=>(_networkManageController.connectionType.value == 0)?const NetworkErrorMessage():
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 2.5.hp,
                ),
                PageHeader(scaffoldKey: scaffoldKey),
                Container(
                  // height: screenHeight,
                  padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 0.5.hp,
                      ),
                      CustomTextWidget(
                        text: '${widget.notification.title}',
                        size: 12.0.sp,
                        weight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 2.0.hp,
                      ),
                      CustomTextWidget(
                        text: '${widget.notification.message}',
                        size: 11.0.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
