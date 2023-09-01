// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/auth/registration/forgot_password_screen.dart';
import 'package:medexer_donor/screens/auth/registration/signup_screen.dart';
import 'package:medexer_donor/screens/home/sub_screens/home_screen.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_formpassword_field.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/widgets/text/cutom_formtext_field.dart';
import '../../database/user_repository.dart';
import '../../services/auth_services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  bool showPassword = true;
  final authStorage = GetStorage();
  final AuthServices authServices = Get.find();
  final UserRepository userRepository = Get.find();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Google Signin
  Map dto = {};
  var googleSignin = false.obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signinHandler() async {
    if (!emailController.text.trim().isNotEmpty ||
        !passwordController.text.trim().isNotEmpty) {
      Get.snackbar(
        'ERROR!',
        'Please ensure your fill in all fields in the form as the are required.',
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
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
        Get.snackbar(
          'ERROR!',
          authServices.authRequestError.value,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
          backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
        );
      }
      if (authServices.authRequestError.value == 'Email is not registered!') {
        Get.snackbar(
          'ERROR!',
          authServices.authRequestError.value,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
          backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
        );
      }

      if (authServices.authRequestError.value == 'ACCOUNT UNVERIFIED') {
        Get.snackbar(
          'ERROR!',
          'Please check your mail for an activation token to activate your account.',
          colorText: Colors.white,
          duration: Duration(seconds: 5),
          backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        if (await authStorage.read('MDX-USER') == null) {
          Get.to(() => LoginScreen());
        }
        return true;
      },
      child: Scaffold(
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
                          text: 'Login',
                          size: 35.0,
                          color: Colors.white,
                          weight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.0.hp),
                      CustomFormTextField(
                        hintText: 'Email',
                        maxLines: 1,
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
                      SizedBox(height: 0.5.hp),
                      Row(
                        children: [
                          // Switch(
                          //   value: rememberMe,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       rememberMe = !rememberMe;
                          //     });

                          //     debugPrint('[REMEMBER ME] :: $rememberMe');
                          //   },
                          //   inactiveTrackColor: AppStyles.bgGray,
                          // ),
                          Container(),
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
                              size: 14.0,
                              color: AppStyles.bgGray4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.0.hp),
                      authServices.authLoading.value == true
                          ? CircularProgressIndicator()
                          : CustomButton(
                              text: 'Login',
                              width: double.maxFinite,
                              height: screenHeight * 0.06,
                              onTapHandler: () {
                                signinHandler();
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
                            text: 'Or login with',
                            size: 14.0,
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
                              // width: 20.0.wp,
                              // height: 6.0.hp,
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
                              // width: 20.0.wp,
                              height: screenHeight * 0.06,
                              // height: 6.0.hp,
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
                              // width: 20.0.wp,
                              height: screenHeight * 0.06,
                              // height: 6.0.hp,
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
                        text: 'Don\'t have an account? ',
                        size: 14.0,
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
                          size: 14.0,
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
      ),
    );
  }
}
