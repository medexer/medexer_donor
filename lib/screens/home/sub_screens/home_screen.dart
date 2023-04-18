// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/home/route_screen.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/screens/map/trialMap.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
          height: 12.0.hp,
          child: Column(
            children: [
              SizedBox(height: 1.0.hp),
              Center(
                child: Container(
                  width: 40,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppStyles.bgGray.withOpacity(0.5),
                  ),
                ),
              ),
              SizedBox(height: 2.0.hp),
              GestureDetector(
                onTap: () {
                  Get.to(
                    transition: Transition.downToUp,
                    duration: Duration(milliseconds: 500),
                    () => RouteScreen(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 1.2.hp,
                    horizontal: 2.0.wp,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppStyles.bgGray.withOpacity(0.2),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      CustomTextWidget(
                        text: 'Search for a Donation Center',
                        size: 14.0.sp,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: screenHeight,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  height: screenHeight,
                  child:GoogleMapTrial() 
                  // Image.asset(
                  //   'assets/images/map__1.jpg',
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              Positioned(
                top: 0,
                width: screenWidth,
                child: PageHeader(scaffoldKey: scaffoldKey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
