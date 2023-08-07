import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/models/notification_model.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/services/donor_services.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

import 'package:medexer_donor/network_services/network_error_message.dart';
import 'package:medexer_donor/network_services/network_manager.dart';

class SingleNotificationScreen extends StatefulWidget {
  final NotificationModel notification;
  const SingleNotificationScreen({super.key, required this.notification});

  @override
  State<SingleNotificationScreen> createState() =>
      _SingleNotificationScreenState();
}

class _SingleNotificationScreenState extends State<SingleNotificationScreen> {
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
        child: Obx(
          () => (_networkManageController.connectionType.value == 0)
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
      body: Obx(
        () => (_networkManageController.connectionType.value == 0)
            ? const NetworkErrorMessage()
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // PageHeader(scaffoldKey: scaffoldKey),
                      // SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                      Container(
                        // height: screenHeight,
                        padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                        child: Column(
                          children: [
                            // SizedBox(
                            //   height: 0.5.hp,
                            // ),
                            Container(
                              width: double.maxFinite,
                              child: Center(
                                child: Expanded(
                                  child: CustomTextWidget(
                                    text: '${widget.notification.title}',
                                    size: 16,
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
