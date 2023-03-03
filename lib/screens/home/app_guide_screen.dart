// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/config/app_config.dart';

class AppGuideScreen extends StatefulWidget {
  const AppGuideScreen({super.key});

  @override
  State<AppGuideScreen> createState() => _AppGuideScreenState();
}

class _AppGuideScreenState extends State<AppGuideScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      body: SafeArea(
        child: Container(
          height: screenHeight,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    PageHeader(scaffoldKey: scaffoldKey),
              
                    SizedBox(
                      height: 10.0.hp,
                    ),
                    CustomTextWidget(
                      text: "Guide on how\nto use the app",
                      size: 20.0.sp,
                      weight: FontWeight.w500,
                      ),
                    Padding(
                      padding: EdgeInsets.only(left:15.0.wp, top:4.0.hp,right: 12.0.wp),
                      child: CustomTextWidget(
                        text: "Medexer seeks to increase the ease with\nwhich hospitals have access to blood and saves lives by connecting hospitals directly to blood donors\n\nYou find and book appointments with blood\ndonation centers by entering the name",
                        size: 9.0.sp,
                        weight: FontWeight.w600,
                          ),
                    ),
              
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: 'Made with',
                      size: 5.0.sp, 
                    ),
                    Icon(Icons.favorite_border_outlined, color: Colors.red,),
                    CustomTextWidget(
                      text: 'in',
                      size: 5.0.sp,),
                    Icon(Icons.flag),
                    CustomTextWidget(
                      text: '&',
                      size: 5.0.sp,),
                      Icon(Icons.flag),
                  ],
               ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
