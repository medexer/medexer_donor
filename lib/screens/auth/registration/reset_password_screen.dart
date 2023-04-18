// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/widgets/text/cutom_formtext_field.dart';
import 'package:medexer_donor/widgets/text/custom_formpassword_field.dart';
import '../../../services/auth_services.dart';
import '../../../widgets/snackbars/custom_snackbar_container.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool rememberMe = false;
  bool showPassword = true;
  bool showConfirmPassword = true;
  final AuthServices authServices = Get.find();
  TextEditingController otpController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  Future<void> resetPasswordHandler() async {
    if (!otpController.text.trim().isNotEmpty ||
        !newpasswordController.text.trim().isNotEmpty||
        !confirmNewPasswordController.text.trim().isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackbarContainer(
            backgroundType: '',
            title: 'Info',
            description:
                'Please ensure your fill in all fields\n in the form as the are required.',
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      );
    } else {
      Map data = {
        "otp": otpController.text.trim(),
        "newPassword": newpasswordController.text.trim(),
      };

      debugPrint('[SIGNUP DTO] :: $data');
      await authServices.resetPasswordController(
        data,
      );

      debugPrint('[ERROR] :: ${authServices.authRequestError.value}');

      if (authServices.authRequestError.value == 'Invalid email address.') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomSnackbarContainer(
              backgroundType: 'ERROR',
              title: 'Oh snap!',
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
      
      if (authServices.authRequestStatus.value == 'SUCCESS') {
        setState(() {
          authServices.authLoading.value = false;
          authServices.authRequestError.value = '';
          authServices.authRequestStatus.value = '';
        });

        setState(() {
          newpasswordController.clear();
          confirmNewPasswordController.clear();
         
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Obx(()=>
        SingleChildScrollView(
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
                          text: 'Reset Password',
                          size: 25.0.sp,
                          color: Colors.white,
                          weight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3.0.hp),
                      CustomFormTextField(
                        maxLines: 2,
                        hintText: 'OTP',
                        controller: otpController,
                        background: Colors.white.withOpacity(0.4),
                        hintColor: Colors.white,
                      ),
                      SizedBox(height: 3.0.hp),
                      CustomFormPasswordField(
                        controller: newpasswordController,
                        hintText: 'New password',
                        suffixIcon: ImageIcon(
                          AssetImage('assets/icons/icon__eye.png'),
                        ),
                        showPassword: showPassword,
                        background: Colors.white.withOpacity(0.4),
                      ),
                      SizedBox(height: 3.0.hp),
                      CustomFormPasswordField(
                        controller: confirmNewPasswordController,
                        hintText: 'Confirm new password',
                        suffixIcon: ImageIcon(
                          AssetImage('assets/icons/icon__eye.png'),
                        ),
                        showPassword: showConfirmPassword,
                        background: Colors.white.withOpacity(0.4),
                      ),
                      SizedBox(height: 3.0.hp),
                      authServices.authRequestStatus.value =='PENDING'?
                      CircularProgressIndicator():
                      CustomButton(
                        text: 'Reset Password',
                        width: double.maxFinite,
                        height: 6.0.hp,
                        onTapHandler: () {
                          resetPasswordHandler();
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
      ),
    );
  }
}
