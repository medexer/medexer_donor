// ignore_for_file: prefer_const_constructors

import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/data/index.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/services/auth_services.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/buttons/custom_select_button.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:file_picker/file_picker.dart';
import 'package:medexer_donor/widgets/text/custom_formpassword_field.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/widgets/text/cutom_formtext_field.dart';
import 'package:medexer_donor/widgets/buttons/custom_date_picker_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime? _chosenDateTime;
  TextEditingController emailController = TextEditingController();
  TextEditingController nationalityController =
      TextEditingController(text: "Nigerian");
  TextEditingController genderController =
      TextEditingController(text: 'Gender');
  TextEditingController religionController =
      TextEditingController(text: 'Religion');
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
      emailController.text = "${userRepository.userData.value.email}";
      nationalityController.text =
          "${userRepository.userProfile.value.nationality}";
      genderController.text = "${userRepository.userProfile.value.gender}";
      religionController.text = "${userRepository.userProfile.value.religion}";
      addressController.text = "${userRepository.userProfile.value.address}";
      stateController.text = "${userRepository.userProfile.value.state}";
      cityProvinceController.text =
          "${userRepository.userProfile.value.cityProvince}";
      contactNumberController.text =
          "${userRepository.userProfile.value.contactNumber}";
      dateOfBirthController.text =
          "${userRepository.userProfile.value.dateOfBirth}";

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
                    Padding(
                      padding:
                          EdgeInsets.only(left: 10.0, top: screenHeight * 0.12),
                      child: CustomTextWidget(
                        text: '${userRepository.userData.value.fullName}',
                        color: Colors.white,
                        size: 20.0,
                        // weight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: CustomTextWidget(
                        text: 'ID: ${userRepository.userData.value.donorID}',
                        color: Colors.white,
                        size: 16.0,
                        // weight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.0.hp),
                    Stack(
                      children: [
                        Positioned(
                          // top: 5,
                          // padding: EdgeInsets.only(left: 2.0.hp),
                          child: ClipOval(
                            child: SizedBox(
                              width: screenWidth * 0.35,
                              height: screenHeight * 0.15,
                              child: Image.network(
                                '${userRepository.userProfile.value.userAvatar}',
                                // '${APIConstants.backendServerRootUrl}${userRepository.userData.value.avatar}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.5.hp, top: 12.0.hp),
                          child: GestureDetector(
                            onTap: () async {
                              debugPrint('[UPLOAD-AVATAR]');

                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: [
                                  'jpg',
                                  'jpeg',
                                ],
                              );

                              if (result!.files.isEmpty) return;

                              debugPrint(
                                  "${result.files[0].path} :: file path ");
                              debugPrint("[FILE-SIZE] ${result.files[0].size}");
                              if (result.files[0].size >= 500000) {
                                Get.snackbar(
                                  'Error',
                                  'File uploaded should be less than 500kb.',
                                  colorText: Colors.white,
                                  backgroundColor: AppStyles.bgBlue,
                                );
                              } else {
                                setState(() {
                                  newAvatar = true;
                                  avatar = result.files[0];
                                });

                                Map formData = {
                                  "avatar": avatar,
                                };

                                await authServices
                                    .updateProfileAvatarController(formData);
                              }
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: newAvatar
                                  ? AppStyles.bgBlack
                                  : AppStyles.bgBlue,
                              child: Icon(
                                Icons.add_a_photo,
                                size: 14.0,
                                color: Colors.white,
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
            authServices.authRequestStatus.value == 'PENDING'
                ? const CircularProgressIndicator()
                : CustomButton(
                    text: 'Submit',
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: screenHeight * 0.06,
                    onTapHandler: () async {
                      if (userRepository.userData.value.isEmailLogin == true) {
                        if (!emailController.text.trim().isNotEmpty ||
                            !nationalityController.text.trim().isNotEmpty ||
                            !genderController.text.trim().isNotEmpty ||
                            !religionController.text.trim().isNotEmpty ||
                            !stateController.text.trim().isNotEmpty ||
                            !cityProvinceController.text.trim().isNotEmpty ||
                            !addressController.text.trim().isNotEmpty ||
                            !dateOfBirthController.text.trim().isNotEmpty ||
                            !contactNumberController.text.trim().isNotEmpty) {
                          Get.snackbar(
                            'ERROR',
                            'All fields are required.',
                            colorText: Colors.white,
                            duration: Duration(seconds: 5),
                            backgroundColor:
                                AppStyles.bgBrightRed.withOpacity(0.5),
                          );
                        } else if (!emailPattern
                            .hasMatch(emailController.text.trim())) {
                          Get.snackbar(
                            'ERROR!',
                            'Invalid email address',
                            colorText: Colors.white,
                            duration: Duration(seconds: 5),
                            backgroundColor:
                                AppStyles.bgBrightRed.withOpacity(0.5),
                          );
                        } else {
                          Map formData = {
                            "nationality": nationalityController.text.trim(),
                            "gender": genderController.text.trim(),
                            "religion": religionController.text.trim(),
                            "address": addressController.text.trim(),
                            "state": stateController.text.trim(),
                            "city_province": cityProvinceController.text.trim(),
                            "contact_number":
                                contactNumberController.text.trim(),
                            "dateOfBirth": dateOfBirthController.text
                                .trim()
                                .substring(0, 10),
                            'email': emailController.text.trim(),
                            // 'avatar': avatar
                          };

                          debugPrint('[PAYLOAD] :: $formData');

                          await authServices
                              .updateProfileWithGoogleSigninController(
                            formData,
                          );
                        }
                      } else {
                        if (!emailController.text.trim().isNotEmpty ||
                            !passwordController.text.trim().isNotEmpty ||
                            !nationalityController.text.trim().isNotEmpty ||
                            !genderController.text.trim().isNotEmpty ||
                            !religionController.text.trim().isNotEmpty ||
                            !stateController.text.trim().isNotEmpty ||
                            !cityProvinceController.text.trim().isNotEmpty ||
                            !addressController.text.trim().isNotEmpty ||
                            !dateOfBirthController.text.trim().isNotEmpty ||
                            !contactNumberController.text.trim().isNotEmpty) {
                          Get.snackbar(
                            colorText: AppStyles.bgWhite,
                            backgroundColor: AppStyles.bgBlue,
                            'ERROR',
                            'All fields are required.',
                          );
                        } else {
                          if (newPasswordController.text.trim().isNotEmpty &&
                              confirmNewPasswordController.text
                                  .trim()
                                  .isNotEmpty &&
                              newPasswordController.text.trim() ==
                                  confirmNewPasswordController.text.trim()) {
                            Get.snackbar(
                              colorText: AppStyles.bgWhite,
                              backgroundColor: AppStyles.bgBlue,
                              'ERROR',
                              'Passwords do not match.',
                            );
                          } else if (newPasswordController.text
                                  .trim()
                                  .isNotEmpty &&
                              !passwordPattern.hasMatch(
                                  newPasswordController.text.trim())) {
                            Get.snackbar(
                              'ERROR!',
                              'Password must include a number, uppercase and lowercase alphabet',
                              colorText: Colors.white,
                              duration: Duration(seconds: 5),
                              backgroundColor:
                                  AppStyles.bgBrightRed.withOpacity(0.5),
                            );
                          } else {
                            Map formData = {
                              "nationality": nationalityController.text.trim(),
                              "gender": genderController.text.trim(),
                              "religion": religionController.text.trim(),
                              "address": addressController.text.trim(),
                              "state": stateController.text.trim(),
                              "city_province":
                                  cityProvinceController.text.trim(),
                              "contact_number":
                                  contactNumberController.text.trim(),
                              "dateOfBirth": dateOfBirthController.text
                                  .trim()
                                  .substring(0, 10),
                              'new_password': newPasswordController.text.trim(),
                              'password': passwordController.text.trim(),
                              'email': emailController.text.trim(),
                              // 'avatar': avatar
                            };

                            debugPrint('[PAYLOAD] :: $formData');

                            await authServices.updateProfileController(
                              formData,
                            );
                          }
                        }
                      }
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
                  child: userRepository.userData.value.isEmailLogin == true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              text: 'Email',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomFormTextField(
                              maxLines: 1,
                              fontSize: 14,
                              borderRadius: 15,
                              hintText: 'Email',
                              controller: emailController,
                              textColor: AppStyles.bgBlack,
                              background: Colors.white.withOpacity(0.4),
                              hintColor: Colors.black,
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'Nationality',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomFormTextField(
                              maxLines: 1,
                              readOnly: true,
                              borderRadius: 15,
                              fontSize: 14,
                              hintText: nationalityController.text,
                              controller: nationalityController,
                              textColor: AppStyles.bgBlack,
                              background: Colors.white.withOpacity(0.4),
                              hintColor: Colors.black,
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'Gender',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomSelectButton(
                              title: 'Gender',
                              height: screenHeight * 0.3,
                              borderRadius: 15,
                              textColor: AppStyles.bgBlack,
                              items: appGenders,
                              currentItem: genderController.text.toString(),
                              onChangeHandler: (int index) {
                                setState(() {
                                  genderController.text =
                                      appGenders[index]['name'];
                                });
                              },
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'Religion',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomSelectButton(
                              title: 'Religion',
                              height: screenHeight * 0.3,
                              borderRadius: 15,
                              textColor: AppStyles.bgBlack,
                              items: appReligions,
                              currentItem: religionController.text.toString(),
                              onChangeHandler: (int index) {
                                setState(() {
                                  religionController.text =
                                      appReligions[index]['name'];
                                });
                              },
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'Address',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomFormTextField(
                              maxLines: 1,
                              borderRadius: 15,
                              hintText: 'Address',
                              fontSize: 14,
                              controller: addressController,
                              textColor: AppStyles.bgBlack,
                              background: Colors.white.withOpacity(0.4),
                              hintColor: Colors.black,
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'State',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomSelectButton(
                              title: 'State',
                              height: screenHeight * 0.5,
                              borderRadius: 15,
                              textColor: AppStyles.bgBlack,
                              items: appStates,
                              currentItem: stateController.text.toString(),
                              onChangeHandler: (int index) {
                                setState(() {
                                  stateController.text =
                                      appStates[index]['name'];
                                });
                              },
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'City/Province',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomFormTextField(
                              maxLines: 1,
                              borderRadius: 15,
                              hintText: 'City/Province',
                              fontSize: 14,
                              controller: cityProvinceController,
                              textColor: AppStyles.bgBlack,
                              background: Colors.white.withOpacity(0.4),
                              hintColor: Colors.black,
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'Phone number',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomFormTextField(
                              maxLines: 1,
                              borderRadius: 15,
                              fontSize: 14,
                              hintText: 'Phone number',
                              keyboardType: TextInputType.number,
                              controller: contactNumberController,
                              textColor: AppStyles.bgBlack,
                              background: Colors.white.withOpacity(0.4),
                              hintColor: Colors.black,
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'Date of birth',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomDatePickerButton(
                              date: initialDate,
                              controller: dateOfBirthController,
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              text: 'Email',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomFormTextField(
                              maxLines: 1,
                              borderRadius: 15,
                              hintText: 'Email',
                              fontSize: 14,
                              controller: emailController,
                              textColor: AppStyles.bgBlack,
                              background: Colors.white.withOpacity(0.4),
                              hintColor: Colors.black,
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'Current Password',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomFormPasswordField(
                              borderRadius: 15,
                              controller: passwordController,
                              fontColor: AppStyles.bgBlack,
                              hintText: 'Current password',
                              suffixIcon: ImageIcon(
                                AssetImage('assets/icons/icon__eye.png'),
                                color: Colors.white,
                              ),
                              showPassword: showPassword,
                              background: Colors.white.withOpacity(0.4),
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'New Password (Optional)',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomFormPasswordField(
                              borderRadius: 15,
                              controller: newPasswordController,
                              fontColor: AppStyles.bgBlack,
                              hintText: 'New password',
                              suffixIcon: ImageIcon(
                                AssetImage('assets/icons/icon__eye.png'),
                                color: Colors.white,
                              ),
                              showPassword: showConfirmPassword,
                              background: Colors.white.withOpacity(0.4),
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'Confirm Password (Optional)',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomFormPasswordField(
                              borderRadius: 15,
                              controller: confirmNewPasswordController,
                              fontColor: AppStyles.bgBlack,
                              hintText: 'Confirm password',
                              suffixIcon: ImageIcon(
                                AssetImage('assets/icons/icon__eye.png'),
                                color: Colors.white,
                              ),
                              showPassword: showConfirmNewPassword,
                              background: Colors.white.withOpacity(0.4),
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'Nationality',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomFormTextField(
                              maxLines: 1,
                              readOnly: true,
                              borderRadius: 15,
                              fontSize: 14,
                              hintText: nationalityController.text,
                              controller: nationalityController,
                              textColor: AppStyles.bgBlack,
                              background: Colors.white.withOpacity(0.4),
                              hintColor: Colors.black,
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'Gender',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomSelectButton(
                              title: 'Gender',
                              height: screenHeight * 0.3,
                              borderRadius: 15,
                              textColor: AppStyles.bgBlack,
                              items: appGenders,
                              currentItem: genderController.text.toString(),
                              onChangeHandler: (int index) {
                                setState(() {
                                  genderController.text =
                                      appGenders[index]['name'];
                                });
                              },
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'Religion',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomSelectButton(
                              title: 'Religion',
                              height: screenHeight * 0.3,
                              borderRadius: 15,
                              textColor: AppStyles.bgBlack,
                              items: appReligions,
                              currentItem: religionController.text.toString(),
                              onChangeHandler: (int index) {
                                setState(() {
                                  religionController.text =
                                      appReligions[index]['name'];
                                });
                              },
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'Address',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomFormTextField(
                              maxLines: 1,
                              borderRadius: 15,
                              hintText: 'Address',
                              controller: addressController,
                              textColor: AppStyles.bgBlack,
                              background: Colors.white.withOpacity(0.4),
                              hintColor: Colors.black,
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'State',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomSelectButton(
                              title: 'State',
                              height: screenHeight * 0.5,
                              borderRadius: 15,
                              textColor: AppStyles.bgBlack,
                              items: appStates,
                              currentItem: stateController.text.toString(),
                              onChangeHandler: (int index) {
                                setState(() {
                                  stateController.text =
                                      appStates[index]['name'];
                                });
                              },
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'City/Province',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomFormTextField(
                              maxLines: 1,
                              fontSize: 14,
                              borderRadius: 15,
                              hintText: 'City/Province',
                              controller: cityProvinceController,
                              textColor: AppStyles.bgBlack,
                              background: Colors.white.withOpacity(0.4),
                              hintColor: Colors.black,
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'Phone Number',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomFormTextField(
                              maxLines: 1,
                              borderRadius: 15,
                              fontSize: 14,
                              hintText: 'Phone number',
                              keyboardType: TextInputType.number,
                              controller: contactNumberController,
                              textColor: AppStyles.bgBlack,
                              background: Colors.white.withOpacity(0.4),
                              hintColor: Colors.black,
                            ),
                            SizedBox(height: 2.0.hp),
                            CustomTextWidget(
                              text: 'Date of Birth',
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                            CustomDatePickerButton(
                              date: initialDate,
                              controller: dateOfBirthController,
                            ),
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

  void _showDatePicker(context) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        dateOrder: DatePickerDateOrder.ymd,
                        //dateOrder: DatePickerDateOrder.dmy,
                        use24hFormat: false,
                        initialDateTime: DateTime(1961, 1, 1),
                        onDateTimeChanged: (val) {
                          setState(() {
                            _chosenDateTime = val;
                          });
                        }),
                  ),
                ],
              ),
            ));
  }
}
