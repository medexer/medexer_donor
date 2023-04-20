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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            height: screenHeight,
            child: Column(
              children: [
                PageHeader(scaffoldKey: scaffoldKey),
                SizedBox(height: 2.0.hp),
                TabBar(
                    unselectedLabelColor:AppStyles.bgGray,
                    indicator: BoxDecoration(
                    borderRadius:BorderRadius.circular(50),
                    color: AppStyles.bgBlue
                    ),
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
                    indicatorColor: AppStyles.bgBlue,
                    controller: tabController,
                    tabs: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: AppStyles.bgBlue, width: 1)
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: CustomTextWidget(
                            text: "Centers",
                            color: AppStyles.bgBlack,
                            size: 12.0.sp,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: AppStyles.bgBlue, width: 1)
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: CustomTextWidget(
                            text: "Appointments",
                            color: AppStyles.bgBlack,
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
                      DonationCenters(),
                      Appointments(),
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
