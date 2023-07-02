// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/models/user_model.dart';
import 'package:medexer_donor/screens/auth/kyc/sub_screen/id_proof.dart';
import 'package:medexer_donor/screens/auth/kyc/sub_screen/personal_detail.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final authStorage = GetStorage();
  final UserRepository userRepository = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    TabController tabController = TabController(length: 2, vsync: this);

    return WillPopScope(
      onWillPop: () async {
        authStorage.remove('MDX-USER');

        userRepository.userData.value = UserModel.fromJson({});

        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.0.hp),
                Padding(
                  padding: EdgeInsets.all(2.0.hp),
                  child: CustomTextWidget(
                    text: 'Upload KYC',
                    size: 20.0.sp,
                    // weight: FontWeight.bold,
                  ),
                ),
                // SizedBox(height: 2.0.hp),
                TabBar(
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
                  indicatorColor: AppStyles.bgBlue,
                  controller: tabController,
                  tabs: [
                    CustomTextWidget(
                      text: "Personal Details",
                      color: AppStyles.bgBlack,
                      size: 14.0.sp,
                    ),
                    CustomTextWidget(
                      text: "ID Proof",
                      color: AppStyles.bgBlack,
                      size: 14.0.sp,
                    )
                  ],
                ),
                Container(
                  height: screenHeight * 0.85,
                  padding: EdgeInsets.only(top: 2.0.hp),
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      PersonalDetailScreen(tabController: tabController),
                      IdProofScreen(),
                    ],
                  ),
                )
              ],
            ),
          ),
          //   ),
        ),
      ),
    );
  }
}
