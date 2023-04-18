// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/auth/registration/forgot_password_screen.dart';
import 'package:medexer_donor/screens/auth/registration/signup_screen.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_formpassword_field.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/widgets/text/cutom_formtext_field.dart';
import '../../database/user_repository.dart';
import '../../services/auth_services.dart';
import '../../widgets/snackbars/custom_snackbar_container.dart';
import 'registration/reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  bool showPassword = true;
  final AuthServices authServices = Get.find();
  final UserRepository userRepository = Get.find();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signinHandler() async {
    if (!emailController.text.trim().isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackbarContainer(
            backgroundType: 'ERROR',
            title: 'Oh Snap!',
            description: 'Email field is required',
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      );
    } else if (!passwordController.text.trim().isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackbarContainer(
            backgroundType: 'ERROR',
            title: 'Oh Snap!',
            description: 'Password field is required',
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      );
    } else {
      Map data = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };
      await authServices.signinController(
        data,
      );

      if (authServices.authRequestError.value == 'Incorrect password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomSnackbarContainer(
              backgroundType: 'ERROR',
              title: 'Validation Error',
              description: authServices.authRequestError.value,
            ),
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            backgroundColor: Colors.transparent,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 150,
            ),
          ),
        );
      }
      if (authServices.authRequestError.value == 'Email is not registered!') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomSnackbarContainer(
              backgroundType: 'ERROR',
              title: 'Validation Error',
              description: authServices.authRequestError.value,
            ),
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            backgroundColor: Colors.transparent,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 150,
            ),
          ),
        );
      }

      if (authServices.authRequestError.value == 'ACCOUNT UNVERIFIED') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomSnackbarContainer(
              backgroundType: '',
              title: 'Account Unverified',
              description:
                  'Please check your mail for an activation\n token to activate your account.',
            ),
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            duration: Duration(milliseconds: 5000),
            backgroundColor: Colors.transparent,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 150,
            ),
          ),
        );
      }

      if (authServices.authRequestStatus.value == 'SUCCESS') {
        setState(() {
          emailController.clear();
          passwordController.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              children: [
                Column(
                  children: [
                    Center(
                      child: CustomTextWidget(
                        text: 'Login',
                        size: 30.0.sp,
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.0.hp),
                    CustomFormTextField(
                      hintText: 'Email',
                      maxLines: 2,
                      controller: emailController,
                      background: Colors.white.withOpacity(0.4),
                      hintColor: Colors.white,
                    ),
                    SizedBox(height: 3.0.hp),
                    CustomFormPasswordField(
                      controller: passwordController,
                      hintText: 'Enter your password',
                      suffixIcon: ImageIcon(
                        AssetImage('assets/icons/icon__eye.png'),
                      ),
                      showPassword: showPassword,
                      background: Colors.white.withOpacity(0.4),
                    ),
                    Row(
                      children: [
                        Switch(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = !rememberMe;
                            });

                            debugPrint('[REMEMBER ME] :: $rememberMe');
                          },
                          inactiveTrackColor: AppStyles.bgGray,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              transition: Transition.zoom,
                              duration: Duration(milliseconds: 500),
                              () => ForgotPasswordScreen(),
                            );
                          },
                          child: CustomTextWidget(
                            text: 'Forgot password?',
                            size: 12.0.sp,
                            color: AppStyles.bgGray4,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.0.hp),
                    authServices.authRequestStatus.value == 'PENDING'
                        ? CircularProgressIndicator()
                        : CustomButton(
                            text: 'Login',
                            width: double.maxFinite,
                            height: 6.0.hp,
                            onTapHandler: () {
                              signinHandler();
                            },
                            fontSize: 12.0.sp,
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
                          text: 'Or login with',
                          size: 12.0.sp,
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
                            // OAUTH-GOOGLE: LOGIN
                          },
                          child: Container(
                            width: 20.0.wp,
                            height: 6.0.hp,
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
                            // OAUTH-APPLE: LOGIN
                          },
                          child: Container(
                            width: 20.0.wp,
                            height: 6.0.hp,
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
                            // OAUTH-FACEBOOK: LOGIN
                          },
                          child: Container(
                            width: 20.0.wp,
                            height: 6.0.hp,
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
                SizedBox(height: 20.0.hp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: 'Don\'t have an account? ',
                      size: 12.0.sp,
                      color: AppStyles.bgGray4,
                    ),
                    GestureDetector(
                      onTap: () {
                        // GO-TO: SIGNUP
                        Get.to(
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 800),
                          () => SignupScreen(),
                        );
                      },
                      child: CustomTextWidget(
                        text: 'Signup',
                        size: 12.0.sp,
                        color: AppStyles.bgPrimary,
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
