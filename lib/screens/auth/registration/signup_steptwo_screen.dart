// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/data/index.dart';
import 'package:medexer_donor/screens/auth/login_screen.dart';
import 'package:medexer_donor/screens/auth/registration/legal_webview_screen.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/buttons/custom_select_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/widgets/text/cutom_formtext_field.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/services/auth_services.dart';

class SignupStepTwoScreen extends StatefulWidget {
  const SignupStepTwoScreen({super.key});

  @override
  State<SignupStepTwoScreen> createState() => _SignupStepTwoScreenState();
}

class _SignupStepTwoScreenState extends State<SignupStepTwoScreen> {
  bool rememberMe = false;
  bool acceptTerms = false;
  bool showPassword = true;
  bool acceptPrivacyPolicy = false;
  bool showConfirmPassword = true;
  final AuthServices authServices = Get.find();
  TextEditingController nationalityController =
      TextEditingController(text: "Nigerian");
  TextEditingController genderController =
      TextEditingController(text: 'Gender');
  //TextEditingController religionController =TextEditingController(text: 'Religion');
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController(text: 'State');
  TextEditingController cityProvinceController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  Map dto = {};
  final UserRepository userRepository = Get.find();

  Future<void> signupHandler() async {
    if (!nationalityController.text.trim().isNotEmpty ||
        !genderController.text.trim().isNotEmpty ||
        //!religionController.text.trim().isNotEmpty ||
        !stateController.text.trim().isNotEmpty ||
        !cityProvinceController.text.trim().isNotEmpty ||
        !addressController.text.trim().isNotEmpty ||
        !contactNumberController.text.trim().isNotEmpty) {
      Get.snackbar(
          backgroundColor: AppStyles.bgPrimary,
          'ERROR!',
          'Please ensure your fill in all fields in the form as the are required.');
    } else {
      Map data = {
        "email": userRepository.signupFormData.value.email,
        "fullName": userRepository.signupFormData.value.fullName,
        "password": userRepository.signupFormData.value.password,
        "nationality": nationalityController.text.trim(),
        "gender": genderController.text.trim(),
        //"religion": religionController.text.trim(),
        "address": addressController.text.trim(),
        "state": stateController.text.trim(),
        "city_province": cityProvinceController.text.trim(),
        "contact_number": contactNumberController.text.trim(),
      };

      debugPrint('[SIGNUP DTO] :: $data');
      await authServices.signupController(
        data,
      );

      debugPrint('[ERROR] :: ${authServices.authRequestError.value}');

      if (authServices.authRequestError.value == 'Invalid email address.') {
        Get.snackbar(
            backgroundColor: AppStyles.bgPrimary,
            'ERROR!',
            authServices.authRequestError.value);
      }
      if (authServices.authRequestError.value ==
          'User with this Email Address already exists.') {
        Get.snackbar(
            backgroundColor: AppStyles.bgPrimary,
            'ERROR!',
            authServices.authRequestError.value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            height: screenHeight,
            padding: EdgeInsets.symmetric(
              vertical: AppLayout.getHeight(50),
              horizontal: AppLayout.getWidth(40),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash__1.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Center(
                      child: CustomTextWidget(
                        text: 'Sign Up',
                        size: 35.0,
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.0.hp),
                    CustomFormTextField(
                      maxLines: 1,
                      readOnly: true,
                      hintText: nationalityController.text,
                      controller: nationalityController,
                      textColor: AppStyles.bgWhite,
                      background: Colors.white.withOpacity(0.4),
                      hintColor: Colors.black,
                    ),
                    SizedBox(height: 1.0.hp),
                    CustomSelectButton(
                      title: 'Gender',
                      height: 30.0.hp,
                      items: appGenders,
                      currentItem: genderController.text.toString(),
                      onChangeHandler: (int index) {
                        setState(() {
                          genderController.text = appGenders[index]['name'];
                        });
                      },
                    ),
                    SizedBox(height: 1.0.hp),
                    // CustomSelectButton(
                    //   title: 'Religion',
                    //   height: 30.0.hp,
                    //   items: appReligions,
                    //   currentItem: religionController.text.toString(),
                    //   onChangeHandler: (int index) {
                    //     setState(() {
                    //       religionController.text = appReligions[index]['name'];
                    //     });
                    //   },
                    // ),
                    // SizedBox(height: 1.0.hp),
                    CustomFormTextField(
                      maxLines: 1,
                      hintText: 'Address',
                      controller: addressController,
                      background: Colors.white.withOpacity(0.4),
                      hintColor: Colors.white,
                    ),
                    SizedBox(height: 1.0.hp),
                    CustomSelectButton(
                      title: 'State',
                      height: 65.0.hp,
                      items: appStates,
                      currentItem: stateController.text.toString(),
                      onChangeHandler: (int index) {
                        setState(() {
                          stateController.text = appStates[index]['name'];
                        });
                      },
                    ),
                    SizedBox(height: 1.0.hp),
                    CustomFormTextField(
                      maxLines: 1,
                      hintText: 'City/Province',
                      controller: cityProvinceController,
                      background: Colors.white.withOpacity(0.4),
                      hintColor: Colors.white,
                    ),
                    SizedBox(height: 1.0.hp),
                    CustomFormTextField(
                      maxLines: 1,
                      maxLength: 11,
                      keyboardType: TextInputType.number,
                      hintText: 'Phone number',
                      controller: contactNumberController,
                      background: Colors.white.withOpacity(0.4),
                      hintColor: Colors.white,
                    ),
                    SizedBox(height: 2.0.hp),
                    Wrap(
                      children: [
                        CustomTextWidget(
                          text: "By creating an account you accept Medexer's ",
                          color: AppStyles.bgWhite,
                          size: 13,
                        ),
                        GestureDetector(
                          onTap: () {
                            // https://medexer.com.ng/donor-terms-of-service
                            Get.to(
                              () => LegalWebViewScreen(
                                url:
                                    "https://medexer.com.ng/donor-terms-of-service",
                              ),
                            );
                          },
                          child: CustomTextWidget(
                            text: "Terms of Service ",
                            color: AppStyles.bgBlue,
                            size: 13,
                          ),
                        ),
                        CustomTextWidget(
                          text: "and ",
                          color: AppStyles.bgWhite,
                          size: 13,
                        ),
                        GestureDetector(
                          onTap: () {
                            // https://medexer.com.ng/donor-privacy-policy
                            Get.to(
                              () => LegalWebViewScreen(
                                url:
                                    "https://medexer.com.ng/donor-privacy-policy",
                              ),
                            );
                          },
                          child: CustomTextWidget(
                            text: "Privacy Policy",
                            color: AppStyles.bgBlue,
                            size: 13,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.0.hp),
                    authServices.authRequestStatus.value == 'PENDING'
                        ? CircularProgressIndicator()
                        : CustomButton(
                            text: 'Signup',
                            width: double.maxFinite,
                            height: screenHeight * 0.06,
                            onTapHandler: () {
                              signupHandler();
                            },
                            fontSize: 16.0,
                            borderRadius: 5,
                            fontColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            backgroundColor: AppStyles.bgPrimary,
                          ),
                    // SizedBox(height: 3.0.hp),
                  ],
                ),
                SizedBox(height: screenWidth * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: 'Already have an account? ',
                      size: 13.0,
                      color: AppStyles.bgGray4,
                    ),
                    GestureDetector(
                      onTap: () {
                        // GO-TO: SIGNUP
                        Get.to(
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 800),
                          () => LoginScreen(),
                        );
                      },
                      child: CustomTextWidget(
                        text: 'Login',
                        size: 13.0,
                        color: AppStyles.bgBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
