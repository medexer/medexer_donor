// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/models/user_model.dart';
import 'package:medexer_donor/screens/auth/kyc/kyc_screen.dart';
import 'package:medexer_donor/screens/home/search_donation_centers_screen.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/screens/map/final_map.dart';
import 'package:medexer_donor/screens/map/trialMap.dart';
import 'package:medexer_donor/services/donor_services.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final authStorage = GetStorage();
  final DonorServices donorServices = Get.find();
  final UserRepository userRepository = Get.find();

  void initializeState() async {
    if (userRepository.userData.value.fullName == null) {
      userRepository.userData.value =
          UserModel.fromJson(authStorage.read('MDX-USER'));
    }
    await Future.delayed(Duration(seconds: 3));

    if (userRepository.userData.value.isKycUpdated == false) {
      Get.to(
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 500),
        () => KycScreen(),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    initializeState();
  }

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
                  height: 0.6.hp,
                  decoration: BoxDecoration(
                    color: AppStyles.bgBlack,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 2.0.hp),
              GestureDetector(
                onTap: () {
                  Get.to(
                    transition: Transition.downToUp,
                    duration: Duration(milliseconds: 500),
                    () => SearchDonationCentersScreen(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 1.2.hp,
                    horizontal: 4.0.wp,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppStyles.bgGray.withOpacity(0.1),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 18,
                      ),
                      SizedBox(width: 2.0.wp),
                      CustomTextWidget(
                        text: 'Search for donation center(s)',
                        size: 12.0.sp,
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
                child: InteractiveViewer(
                  child: Container(
                    height: screenHeight,
                    child: FinalMap(),
                  ),
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
