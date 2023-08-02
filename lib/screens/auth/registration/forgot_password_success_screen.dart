// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/auth/login_screen.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class ForgotPasswordSuccessScreen extends StatefulWidget {
  const ForgotPasswordSuccessScreen({super.key});

  @override
  State<ForgotPasswordSuccessScreen> createState() =>
      _ForgotPasswordSuccessScreenState();
}

class _ForgotPasswordSuccessScreenState
    extends State<ForgotPasswordSuccessScreen> {
  bool showPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: double.maxFinite,
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
              ImageIcon(
                AssetImage('assets/icons/icon__verified__1.png'),
                color: AppStyles.bgBlue,
                size: 80.0.sp,
              ),
              SizedBox(height: 2.0.hp),
              CustomTextWidget(
                text: 'Password has been reset successfully!',
                color: Colors.white,
              ),
              SizedBox(height: 2.0.hp),
              CustomButton(
                text: 'Back to Login',
                width: double.maxFinite,
                height: 6.0.hp,
                onTapHandler: () {
                  Get.to(() => LoginScreen());
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
      ),
    );
  }
}
