// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: AppStyles.bgBlack,),
          onPressed: (() {
            Get.back();
          }),
          ),
        actions: [
        
        ]),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 4.0.hp,),
                CustomTextWidget(
                  text: 'Notification',
                  size: 15.0.sp,
                  color: AppStyles.bgBlack,
                  weight: FontWeight.bold,
                  ),
                SizedBox(height: 15.0.hp,),
                CustomTextWidget(
                  text: 'You don\'t have any notification yet',
                  color: AppStyles.bgGray4,
                  size: 13.0.sp,
                  ),
                  notification(context)
              ]
                      //Text('Notifications'),
            ),
          ),
        ),
    );
  }

  Widget notification(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
            children: [
              SizedBox(height: 4.0.hp,),
                    CustomTextWidget(
                      text: 'Notification',
                      size: 15.0.sp,
                      color: AppStyles.bgBlack,
                      weight: FontWeight.bold,
                      ),
                    SizedBox(height: 15.0.hp,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.notifications_none_sharp, color: Colors.red,),
                    CustomTextWidget(
                      text: 'Your schedule request has been approved by \nExample Hospital. You will be contacted soon \nfor more details on your appointment.',
                      size: 10.0.sp,
                    ),
                  ],
                ),
              
              Divider(),
              
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.notifications_none_sharp, color: AppStyles.bgPrimary,),
                    CustomTextWidget(
                      text: 'Your schedule request has been approved by \nExample Hospital. You will be contacted soon \nfor more details on your appointment.',
                      size: 10.0.sp,
                    ),
                  ],
                
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.notifications_none_sharp, color: AppStyles.bgBlue,),
                    CustomTextWidget(
                      text: 'There is an update available. Install the \nupdate to enjoy fixes and new features',
                      size: 10.0.sp,
                    ),
                  ],
                ),
              ),
          
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.notifications_none_sharp, color: AppStyles.bgPrimary,),
                    CustomTextWidget(
                      text: 'Your schedule request has succesfully sent to \nExample Hospital. You will be contacted soon \nfor more details on your appointment.',
                      size: 10.0.sp,
                    ),
                  ],
                ),
          
              Divider(),
              Row(
                children: [
                  Icon(Icons.notifications_none_sharp, color: AppStyles.bgPrimary,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: 'Appointment status',
                        size: 10.0.sp,
                        weight: FontWeight.bold,
                      ),

                    CustomTextWidget(
                      text: 'Your schedule request has been approved by\nExample Hospital. You will be contacted soon \nfor more details on your appointment.\n\nRemember to always confirm the verification\nstatus of any donation center for your own\nsafety.',
                      size: 10.0.sp,
                    ),
                    ],
                  ),
                  
                ],
              ),
            ],
          ),
      ),
    );

  }
}
