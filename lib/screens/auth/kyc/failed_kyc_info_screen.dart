// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/auth/login_screen.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class FailedKycInfoScreen extends StatefulWidget {
  const FailedKycInfoScreen({super.key});

  @override
  State<FailedKycInfoScreen> createState() => _FailedKycInfoScreenState();
}

class _FailedKycInfoScreenState extends State<FailedKycInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0.wp),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo__1.png',
                scale: 1.5,
              ),
              SizedBox(height: 4.0.hp),
              CustomTextWidget(
                text:
                    'We appreciate your efforts to want to embark on this noble journey to become a blood donor!',
                size: 14.0.sp,
                alignment: TextAlign.center,
              ),
              SizedBox(height: 1.0.hp),
              CustomTextWidget(
                text:
                    'Unfortunately, having a tattoo makes you medically unfit to donate. However, you can spread the good news of blood donation to your family and friends!',
                size: 14.0.sp,
                alignment: TextAlign.center,
              ),
              SizedBox(height: 1.0.hp),
              CustomTextWidget(
                text: 'We wish you all the best in your future endeavours!',
                size: 14.0.sp,
                alignment: TextAlign.center,
              ),
              SizedBox(height: 6.0.hp),
              CustomButton(
                text: 'Done',
                width: double.maxFinite,
                height: 6.0.hp,
                onTapHandler: () {
                  Get.to(() => LoginScreen());
                },
                fontSize: 12.0.sp,
                borderRadius: 5,
                fontColor: Colors.white,
                fontWeight: FontWeight.bold,
                backgroundColor: AppStyles.bgBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
