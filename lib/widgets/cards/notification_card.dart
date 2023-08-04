import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/models/notification_model.dart';
import 'package:medexer_donor/screens/home/sub_screens/notification_screen.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/screens/home/sub_screens/single_notification_screen.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SingleNotificationScreen(notification: notification));
      },
      child: Container(
        // margin: EdgeInsets.only(bottom: 2.0.hp),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppStyles.bgGray.withOpacity(0.3),
            ),
          ),
        ),
        child: ListTile(
          leading: Icon(
            Icons.notifications,
            color: notification.isRead == true
                ? AppStyles.bgGray
                : AppStyles.bgPrimary,
          ),
          title: CustomTextWidget(
            text: '${notification.title}',
            size: 14.0,
            weight: FontWeight.w500,
          ),
          subtitle: CustomTextWidget(
            text: notification.message!.length > 50
                ? '${notification.message!.substring(0, 50)}...'
                : '${notification.message}',
            size: 12.0,
          ),
        ),
      ),
    );
  }
}
