// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/data/index.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/screens/home/donor_profile.dart/edit_profile.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/services/auth_services.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/buttons/custom_select_button.dart';
//import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medexer_donor/widgets/text/custom_formpassword_field.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/widgets/text/cutom_formtext_field.dart';
import 'package:medexer_donor/widgets/buttons/custom_date_picker_button.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  File? file;
  DateTime? _chosenDateTime;
  TextEditingController emailController = TextEditingController();
  TextEditingController nationalityController =
      TextEditingController(text: "Nigerian");
  TextEditingController genderController =
      TextEditingController(text: 'Gender');
  //TextEditingController religionController = TextEditingController(text: 'Religion');
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController(text: 'State');
  TextEditingController cityProvinceController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  bool newAvatar = false;
  DateTime initialDate = DateTime(1980);
  bool showPassword = true;
  bool showConfirmPassword = true;
  bool showConfirmNewPassword = true;
  RegExp emailPattern = RegExp(r"[a-z0-9]+@[a-z]+\.[a-z]{2,3}");
  RegExp passwordPattern =
      RegExp(r"(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,60}$");
  late PlatformFile avatar;
  final AuthServices authServices = Get.find();
  final UserRepository userRepository = Get.find();

  @override
  void initState() {
    super.initState();

    setState(() {
      emailController.text = "${userRepository.userData.value.email ?? ""}";
      nationalityController.text =
          "${userRepository.userProfile.value.nationality ?? ""}";
      genderController.text =
          "${userRepository.userProfile.value.gender ?? ""}";
      // religionController.text =
      //     "${userRepository.userProfile.value.religion ?? ""}";
      addressController.text =
          "${userRepository.userProfile.value.address ?? ""}";
      stateController.text = "${userRepository.userProfile.value.state ?? ""}";
      cityProvinceController.text =
          "${userRepository.userProfile.value.cityProvince ?? ""}";
      contactNumberController.text =
          "${userRepository.userProfile.value.contactNumber ?? ""}";
      dateOfBirthController.text =
          "${userRepository.userProfile.value.dateOfBirth ?? ""}";

      if (userRepository.userProfile.value.dateOfBirth != null) {
        initialDate = DateTime.parse(
          "${userRepository.userProfile.value.dateOfBirth}",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.35),
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
          // color: AppStyles.bgPrimary,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: screenHeight * 0.28,
                padding: EdgeInsets.only(top: 2.0.hp),
                decoration: BoxDecoration(
                  color: AppStyles.bgPurpleDark,
                ),
                child: Column(
                  children: [
                    PageHeader(scaffoldKey: scaffoldKey),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                // padding: EdgeInsets.only(left: 25.0.wp, top: 14.0.hp),
                child: Column(
                  children: [
                    // Padding(
                    //   padding:
                    //       EdgeInsets.only(left: 10.0, top: screenHeight * 0.12),
                    //   child: CustomTextWidget(
                    //     text: '${userRepository.userData.value.fullName}',
                    //     color: Colors.white,
                    //     size: 20.0,
                    //     // weight: FontWeight.bold,
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10.0),
                    //   child: CustomTextWidget(
                    //     text: 'ID: ${userRepository.userData.value.donorID}',
                    //     color: Colors.white,
                    //     size: 16.0,
                    //     // weight: FontWeight.bold,
                    //   ),
                    // ),
                    SizedBox(height: screenHeight * 0.1),
                    Stack(
                      children: [
                        Positioned(
                          // top: 5,
                          // padding: EdgeInsets.only(left: 2.0.hp),
                          child: ClipOval(
                            child: SizedBox(
                              width: screenWidth * 0.5,
                              height: screenHeight * 0.25,
                              child: Image.network(
                                '${userRepository.userProfile.value.userAvatar}',
                                // '${APIConstants.backendServerRootUrl}${userRepository.userData.value.avatar}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: 'Update',
              width: MediaQuery.of(context).size.width * 0.9,
              height: screenHeight * 0.06,
              onTapHandler: () async {
                Get.to(() => EditProfileScreen());
              },
              fontSize: 16.0,
              borderRadius: 15,
              fontColor: Colors.white,
              fontWeight: FontWeight.bold,
              backgroundColor: AppStyles.bgPurpleDark,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileItemContainer(
                          title: 'Fullname',
                          content: "${userRepository.userData.value.fullName}",
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        ProfileItemContainer(
                          title: 'Donor ID',
                          content: "${userRepository.userData.value.donorID}",
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        ProfileItemContainer(
                          title: 'Email',
                          content: emailController.text,
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        ProfileItemContainer(
                          title: 'Gender',
                          content: genderController.text,
                        ),
                        // SizedBox(height: screenHeight * 0.005),
                        // ProfileItemContainer(
                        //   title: 'Religion',
                        //   content: religionController.text,
                        // ),
                        SizedBox(height: screenHeight * 0.005),
                        ProfileItemContainer(
                          title: 'Nationality',
                          content: nationalityController.text,
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        ProfileItemContainer(
                          title: 'Address',
                          content: addressController.text,
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        ProfileItemContainer(
                          title: 'State',
                          content: stateController.text,
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        ProfileItemContainer(
                          title: 'City/Province',
                          content: cityProvinceController.text,
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        ProfileItemContainer(
                          title: 'Phone number',
                          content: contactNumberController.text,
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        ProfileItemContainer(
                          title: 'Date of Birth',
                          content: dateOfBirthController.text,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileItemContainer extends StatelessWidget {
  final String title;
  final String content;
  const ProfileItemContainer({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.maxFinite,
      height: screenHeight * 0.09,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppStyles.bgBlack.withOpacity(0.05),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: AppStyles.bgWhite,
                  border: Border.all(
                    color: AppStyles.bgBlack.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 3,
                      color: AppStyles.bgBlack.withOpacity(0.1),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4.0.wp),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: title,
                    size: 15.0,
                    weight: FontWeight.w600,
                  ),
                  CustomTextWidget(
                    text: content,
                    size: 14.0,
                    // weight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
