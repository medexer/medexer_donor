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
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    PageHeader(scaffoldKey: scaffoldKey),
              
                    SizedBox(
                      height: 5.0.hp,
                    ),
                    CustomTextWidget(
                      text: "Guide on how\nto use the app",
                      size: 20.0.sp,
                      weight: FontWeight.w500,
                      ),
                    Padding(
                      padding: EdgeInsets.only(left:13.0.wp, top:4.0.hp,right: 10.0.wp),
                      child: CustomTextWidget(
                        text: "Medexer seeks to increase the ease with which hospitals have access to blood and saves lives by connecting hospitals directly to blood donors\n\nYou find and book appointments with blood donation centers by doing the following:" 
                        "\n*\tNavigate to Menu > Home\n*\tEnter the name of the hospital or donation centre on the search bar.\n*\tClick on the correct result that pops up. \n*\tMake a call or send SMS to the hospital or donation centre to book an appointment.\n*\tLocate the donation centre by following the map directions\n\nYour request to book an appointment will have to be approved by the donation centre before you can donate blood."
                        "\n Your request to book an appointment will have to be approved by the donation center before you can donate blood",
                        size: 9.0.sp,
                        weight: FontWeight.w600,
                          ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextWidget(
                          text: "Note: ",
                          size: 9.0.sp,
                          weight: FontWeight.bold,
                          ),

                        CustomTextWidget(
                          text: "You will have to wait for your KYC to be \napproved for you to fully use this app.",
                          size: 9.0.sp,
                          weight: FontWeight.w500,
                          ),
                      ],
                    ),

                    CustomTextWidget(
                      text: "ALWAYS MAKE SURE THE DONATION CENTER \nYOU WERE CONTRACTED BY IS VERIFIED ",
                      size: 9.0.sp,
                      weight: FontWeight.bold,
                    ),

                    CustomTextWidget(
                      text: "To do so:" 
                        "\n*\tNaviaget to Maun > Donation Centers \n*\tMake sure to see that it is a verified donation center or DO NOT GO.\nGot question?\nNaviagte to > Menu > Contact Us and send us a message or you can connect with us through any of our social media platforms.",
                      size: 9.0.sp,
                      //weight: FontWeight.bold,
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
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CustomTextWidget(
                        text: 'Made with',
                        size: 5.0.sp, 
                      ),
                    ),
                    Icon(Icons.favorite_border_outlined, color: AppStyles.bgPrimary),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CustomTextWidget(
                        text: 'in',
                        size: 5.0.sp,),
                    ),
                    
                    SizedBox(
                      width: 8,
                      height: 8,
                      child: Image.asset('assets/images/flagNigeria.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CustomTextWidget(
                        text: '&',
                        size: 5.0.sp,),
                    ),  
                    SizedBox(
                      width: 8,
                      height: 8,
                      child: Image.asset('assets/images/flagUs.png'),
                    ),
                      
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
