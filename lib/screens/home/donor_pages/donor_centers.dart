// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/screens/home/appointmentPages/appointments.dart';
import 'package:medexer_donor/screens/home/donor_pages/donation_centers.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class DonorCentersScreen extends StatefulWidget {
  const DonorCentersScreen({super.key});

  @override
  State<DonorCentersScreen> createState() => _DonorCentersScreenState();
}

class _DonorCentersScreenState extends State<DonorCentersScreen>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    TabController tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PageHeader(scaffoldKey: scaffoldKey),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            height: screenHeight,
            child: Column(
              children: [
                // PageHeader(scaffoldKey: scaffoldKey),
                // SizedBox(height: 2.0.hp),
                TabBar(
                  labelColor: AppStyles.bgWhite,
                  unselectedLabelColor: AppStyles.bgBlack,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppStyles.bgPrimary,
                  ),
                  indicatorPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    // vertical: 5,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  // indicatorColor: AppStyles.bgBlue,
                  controller: tabController,
                  tabs: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        // border: Border.all(color: AppStyles.bgBlue, width: 1),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 1.0.hp),
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomTextWidget(
                          text: "Centers",
                          // color: Colors.white,
                          size: 12.0.sp,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        // border: Border.all(color: AppStyles.bgBlue, width: 1),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 1.0.hp),
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomTextWidget(
                          text: "Appointments",
                          // color: Colors.white,
                          size: 12.0.sp,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: screenHeight * 0.82,
                  padding: EdgeInsets.only(top: 2.0.hp),
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      DonationCenters(height: screenHeight * 0.8),
                      Appointments(height: screenHeight * 0.8),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
