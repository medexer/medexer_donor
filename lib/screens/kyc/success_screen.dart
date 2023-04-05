// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/auth/login_screen.dart';
import 'package:medexer_donor/screens/kyc/kyc_page.dart';
import 'package:medexer_donor/screens/kyc/thanks_registration.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class KycSuccessScreen extends StatefulWidget {
  const KycSuccessScreen({super.key});

  @override
  State<KycSuccessScreen> createState() =>_KycSuccessScreenState();
}

class _KycSuccessScreenState
    extends State<KycSuccessScreen> {
  

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5.0.hp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.0.hp,),
                ImageIcon(
                  AssetImage('assets/icons/icon__verified__1.png'),
                  color: Colors.green,
                  size: 120.0.sp,
                ),
                SizedBox(height: 2.0.hp),
                CustomTextWidget(
                  text: 'Submitted successfully!',
                  weight: FontWeight.bold,
                ),
                SizedBox(height: 2.0.hp),
                CustomTextWidget(
                  text: 'We have started reviewing your details which will take up to 24 hours and you will be notified after the process is completed\n\nRemember, ALWAYS verify a donation center before going to donate blood!',
                  size: 11.0.sp,
                ),
                SizedBox(height: 3.0.hp),
                
                CustomButton(
                  text: 'Go to Dashboard',
                  width: double.maxFinite,
                  height: 6.0.hp,
                  onTapHandler: () {
                    Get.to(() => ThanksRegistrationScreen());
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
