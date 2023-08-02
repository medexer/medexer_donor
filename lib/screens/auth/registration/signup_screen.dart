// ignore_for_file: prefer_const_constructors
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/models/signup_formdata_model.dart';
import 'package:medexer_donor/screens/auth/login_screen.dart';
import 'package:medexer_donor/screens/auth/registration/signup_steptwo_screen.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_formpassword_field.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/widgets/text/cutom_formtext_field.dart';
import 'package:medexer_donor/database/user_repository.dart';
import '../../../services/auth_services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool rememberMe = false;
  bool showPassword = true;
  bool showConfirmPassword = true;
  RegExp emailPattern = RegExp(r"[a-z0-9]+@[a-z]+\.[a-z]{2,3}");
  RegExp passwordPattern =
      RegExp(r"(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,60}$");
  final AuthServices authServices = Get.find();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Map dto = {};
  final UserRepository userRepository = Get.find();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signupHandler() async {
    // Get.to(() => SignupStepTwoScreen());
    if (!fullnameController.text.trim().isNotEmpty ||
        !emailController.text.trim().isNotEmpty ||
        !passwordController.text.trim().isNotEmpty ||
        !confirmPasswordController.text.trim().isNotEmpty) {
      Get.snackbar(
        'ERROR!',
        'Please ensure your fill in all fields in the form as the are required.',
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
      );
    } else if (!emailPattern.hasMatch(emailController.text.trim())) {
      Get.snackbar(
        'ERROR!',
        'Invalid email address',
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
      );
    } else if (confirmPasswordController.text.trim() !=
        passwordController.text.trim()) {
      Get.snackbar(
        'ERROR!',
        'Passwords do not match',
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
      );
    } else if (!passwordPattern.hasMatch(passwordController.text.trim())) {
      Get.snackbar(
        'ERROR!',
        'Password must include a number, uppercase and lowercase alphabet',
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
      );
    } else if (passwordController.text.trim().length <= 7) {
      Get.snackbar(
        'ERROR!',
        'Password must be at least 8 characters',
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
      );
    } else {
      Map<String, dynamic> data = {
        "fullName": fullnameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      debugPrint('[SIGNUP DTO] :: $data');
      userRepository.signupFormData.value = SignupFormDataModel.fromJson(data);

      Get.to(() => SignupStepTwoScreen());
      // await authServices.signupController(
      //   data,
      // );

      //   debugPrint('[ERROR] :: ${authServices.authRequestError.value}');

      //   if (authServices.authRequestError.value == 'Invalid email address.') {
      //     Get.snackbar(
      //         backgroundColor: AppStyles.bgPrimary,
      //         'ERROR!',
      //         authServices.authRequestError.value);
      //   }
      //   if (authServices.authRequestError.value ==
      //       'User with this Email Address already exists.') {
      //     Get.snackbar(
      //         backgroundColor: AppStyles.bgPrimary,
      //         'ERROR!',
      //         authServices.authRequestError.value);
      //   }
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
                      hintText: 'Fullname',
                      controller: fullnameController,
                      background: Colors.white.withOpacity(0.4),
                      hintColor: Colors.white,
                    ),
                    SizedBox(height: 3.0.hp),
                    CustomFormTextField(
                      maxLines: 1,
                      hintText: 'Email',
                      controller: emailController,
                      background: Colors.white.withOpacity(0.4),
                      hintColor: Colors.white,
                    ),
                    SizedBox(height: 3.0.hp),
                    CustomFormPasswordField(
                      controller: passwordController,
                      hintText: 'Password',
                      suffixIcon: ImageIcon(
                        AssetImage('assets/icons/icon__eye.png'),
                      ),
                      showPassword: showPassword,
                      background: Colors.white.withOpacity(0.4),
                    ),
                    SizedBox(height: 3.0.hp),
                    CustomFormPasswordField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm password',
                      suffixIcon: ImageIcon(
                        AssetImage('assets/icons/icon__eye.png'),
                      ),
                      showPassword: showConfirmPassword,
                      background: Colors.white.withOpacity(0.4),
                    ),
                    SizedBox(height: 3.0.hp),
                    authServices.authRequestStatus.value == 'PENDING'
                        ? CircularProgressIndicator()
                        : CustomButton(
                            text: 'Next',
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
                    SizedBox(height: 3.0.hp),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: AppStyles.bgGray),
                        ),
                        SizedBox(width: 4.0.wp),
                        CustomTextWidget(
                          text: 'Or signup with',
                          size: 16.0,
                          color: AppStyles.bgGray4,
                        ),
                        SizedBox(width: 4.0.wp),
                        Expanded(
                          child: Divider(color: AppStyles.bgGray),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.0.hp),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // OAUTH-GOOGLE: SIGNUP
                            debugPrint('[GOOGLE-SIGNIN]');
                            _googleSignIn.signOut();
                            _googleSignIn.signIn().then((value) {
                              String email = value!.email;
                              String fullName = '${value.displayName}';
                              String profilePicture = '${value.photoUrl}';

                              debugPrint('[EMAIL] :: ${email}');
                              debugPrint('[USERNAME] :: ${fullName}');
                              debugPrint(
                                  '[PROFILE-PICTURE] :: ${profilePicture}');
                              setState(() {
                                dto['email'] = email;
                                dto['password'] = email;
                                dto['fullName'] = fullName;
                              });

                              authServices.googleSigninController(dto);
                            });
                          },
                          child: Container(
                            width: screenWidth * 0.20,
                            height: screenHeight * 0.06,
                            decoration: BoxDecoration(
                              color: AppStyles.bgGray.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                  'assets/icons/icon__google.svg'),
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            // OAUTH-APPLE: SIGNUP
                            Get.snackbar(
                              'Message',
                              'Coming soon!',
                              colorText: Colors.white,
                              backgroundColor:
                                  AppStyles.bgBlue.withOpacity(0.4),
                            );
                          },
                          child: Container(
                            width: screenWidth * 0.20,
                            height: screenHeight * 0.06,
                            decoration: BoxDecoration(
                              color: AppStyles.bgGray.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                  'assets/icons/icon__apple.svg'),
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            // OAUTH-FACEBOOK: SIGNUP
                            Get.snackbar(
                              'Message',
                              'Coming soon!',
                              colorText: Colors.white,
                              backgroundColor:
                                  AppStyles.bgBlue.withOpacity(0.4),
                            );
                          },
                          child: Container(
                            width: screenWidth * 0.20,
                            height: screenHeight * 0.06,
                            decoration: BoxDecoration(
                              color: AppStyles.bgGray.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                  'assets/icons/icon__facebook.svg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5.0.hp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: 'Already have an account? ',
                      size: 16.0,
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
                        size: 16.0,
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
