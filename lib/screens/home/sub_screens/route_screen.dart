// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/widgets/text/custom_search_widget.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
            height: screenHeight,
            child: Column(
              children: [
                SizedBox(height: 1.0.hp),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: ClipOval(
                        child: Container(
                          width: 40,
                          height: 40,
                          // padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppStyles.bgGray.withOpacity(0.2),
                          ),
                          child: Center(
                            child: CustomTextWidget(
                              text: 'x',
                              size: 14.0.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.0.wp),
                    CustomTextWidget(text: 'Your Route'),
                  ],
                ),
                SizedBox(height: 2.0.hp),
                CustomSearchField(
                  hintText: 'Your location',
                  controller: locationController,
                  icon: 'assets/icons/icon__location.png',
                  // background: Colors.white.withOpacity(0.4),
                ),
                SizedBox(height: 2.0.hp),
                CustomSearchField(
                  hintText: 'Search For Donation Center',
                  controller: destinationController,
                  icon: 'assets/icons/icon__search.png',
                  // background: Colors.white.withOpacity(0.4),
                ),
                SizedBox(height: 4.0.hp),
                Container(
                  height: 40.0.hp,
                  child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (_, index) {
                        return ListTile(
                          leading: SvgPicture.asset(
                            'assets/icons/icon__building.svg',
                            color: AppStyles.bgPrimary,
                          ),
                          title: CustomTextWidget(
                            text: 'Hospital ${index + 1}',
                            size: 14.0.sp,
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
