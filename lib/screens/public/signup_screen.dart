// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/public/login_screen.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_formpassword_field.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/widgets/text/cutom_formtext_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool rememberMe = false;
  bool showPassword = true;
  bool showConfirmPassword = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void signupHandler() async {}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          padding: EdgeInsets.symmetric(
            vertical: AppLayout.getHeight(50),
            horizontal: AppLayout.getWidth(40),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash__1.jpg'),
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
                      text: 'Sign Up',
                      size: 30.0.sp,
                      color: Colors.white,
                      weight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.0.hp),
                  CustomFormTextField(
                    hintText: 'Username',
                    controller: usernameController,
                    background: Colors.white,
                  ),
                  SizedBox(height: 3.0.hp),
                  CustomFormTextField(
                    hintText: 'Email',
                    controller: emailController,
                    background: Colors.white,
                  ),
                  SizedBox(height: 3.0.hp),
                  CustomFormPasswordField(
                    controller: passwordController,
                    hintText: 'Password',
                    suffixIcon: ImageIcon(
                      AssetImage('assets/icons/icon__eye.png'),
                    ),
                    showPassword: showPassword,
                    background: Colors.white,
                  ),
                  SizedBox(height: 3.0.hp),
                  CustomFormPasswordField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm password',
                    suffixIcon: ImageIcon(
                      AssetImage('assets/icons/icon__eye.png'),
                    ),
                    showPassword: showConfirmPassword,
                    background: Colors.white,
                  ),
                  SizedBox(height: 3.0.hp),
                  CustomButton(
                    text: 'Signup',
                    width: double.maxFinite,
                    height: 6.0.hp,
                    onTapHandler: () {
                      signupHandler();
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
                        text: 'Or signup with',
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
                          // OAUTH-GOOGLE: SIGNUP
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
                          // OAUTH-APPLE: SIGNUP
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
                          // OAUTH-FACEBOOK: SIGNUP
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
              SizedBox(height: 10.0.hp),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextWidget(
                    text: 'Already have an account? ',
                    size: 12.0.sp,
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
    );
  }
}
