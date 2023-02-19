// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/widgets/text/cutom_formtext_field.dart';
import 'package:medexer_donor/screens/auth/reset_password_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool showPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void forgotPasswordHandler() async {
    Get.to(() => ResetPasswordScreen());
  }

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
              image: AssetImage('assets/images/splash__1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/icon__lock__1.png'),
              SizedBox(height: 2.0.hp),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 6.0.hp,
                  horizontal: 2.0.wp,
                ),
                decoration: BoxDecoration(
                  // color: Colors.white.withOpacity(0.2),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.13),
                      Colors.white.withOpacity(0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Center(
                      child: CustomTextWidget(
                        text: 'Forgot Password',
                        size: 25.0.sp,
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3.0.hp),
                    Center(
                      child: CustomTextWidget(
                        text:
                            'Enter your email to recover your password. An OTP would be sent to you valid email',
                        size: 12.0.sp,
                        alignment: TextAlign.center,
                        color: Colors.white,
                        // weight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.0.hp),
                    CustomFormTextField(
                      hintText: 'Email address',
                      controller: emailController,
                      background: Colors.white.withOpacity(0.4),
                    ),
                    SizedBox(height: 3.0.hp),
                    CustomButton(
                      text: 'Send OTP',
                      width: double.maxFinite,
                      height: 6.0.hp,
                      onTapHandler: () {
                        forgotPasswordHandler();
                      },
                      fontSize: 12.0.sp,
                      borderRadius: 5,
                      fontColor: Colors.white,
                      fontWeight: FontWeight.bold,
                      backgroundColor: AppStyles.bgPrimary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
