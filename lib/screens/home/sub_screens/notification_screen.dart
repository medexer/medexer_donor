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
  final NetworkManageController _networkManageController =
      Get.find<NetworkManageController>();

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
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: Container(
          margin: EdgeInsets.only(top: 2.0.hp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PageHeader(scaffoldKey: scaffoldKey),
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
                      // PageHeader(scaffoldKey: scaffoldKey),
                      SizedBox(height: 1.5.hp),
                      Container(
                        // height: screenHeight,
                        padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 0.5.hp,
                            ),
                            Container(
                              width: double.maxFinite,
                              child: Center(
                                child: Expanded(
                                  child: CustomTextWidget(
                                    text: '${widget.notification.title}',
                                    size: 14,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.0.hp,
                            ),
                            CustomTextWidget(
                              text: '${widget.notification.message}',
                              size: 14,
                              lineHeight: 2.5,
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
