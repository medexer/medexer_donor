// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/auth/login_screen.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_formpassword_field.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/widgets/text/cutom_formtext_field.dart';
import '../../services/auth_services.dart';
import '../../widgets/snackbars/custom_snackbar_container.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool rememberMe = false;
  bool showPassword = true;
  bool showConfirmPassword = true;
    final AuthServices authServices = Get.find();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // void signupHandler() async {
  //   debugPrint('SIGNUP');
  //   Get.to(
  //     transition: Transition.rightToLeft,
  //     duration: Duration(milliseconds: 800),
  //     () => LoginScreen(),
  //   );
  // }

  Future<void> signupHandler() async {
    if(!usernameController.text.trim().isNotEmpty||
    !emailController.text.trim().isNotEmpty||
    !passwordController.text.trim().isNotEmpty
    ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackbarContainer(
            backgroundType: '',
            title: 'Info',
            description:
                'Please ensure your fill in all fields in the form as the are required.',
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      );
    } 
    else if(confirmPasswordController==passwordController){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackbarContainer(
            backgroundType: '',
            title: 'Info',
            description:
                'Enter thesame Password',
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      );
    }else {
      Map data = {
        "fullName": usernameController.text.trim(),
        "email":emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      debugPrint('[SIGNUP DTO] :: $data');
      await authServices.signupController(
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
      if (authServices.authRequestError.value ==
          'User with this Email Address already exists.') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomSnackbarContainer(
              backgroundType: 'ERROR',
              title: 'DUPLICATE',
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

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomSnackbarContainer(
              backgroundType: 'SUCCESS',
              title: 'Success',
              description:
                  'Registration successful.',
            ),
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            backgroundColor: Colors.transparent,
            margin: EdgeInsets.only(
              // ignore: use_build_context_synchronously
              bottom: MediaQuery.of(context).size.height - 150,
            ),
          ),
        );
        setState(() {
          usernameController.clear();
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
                      maxLines: 2,
                      hintText: 'Username',
                      controller: usernameController,
                      background: Colors.white.withOpacity(0.4),
                      hintColor: Colors.white,
                    ),
                    SizedBox(height: 3.0.hp),
                    CustomFormTextField(
                      maxLines: 2,
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
                    authServices.authRequestStatus.value =='PENDING'?
                    CircularProgressIndicator():
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
      ),
    );
  }
}
