// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/widgets/card/custom_message_card.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/text/cutom_formtext_field.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          child: Column(
            children: [
              PageHeader(scaffoldKey: scaffoldKey),
              SizedBox(height: 10.0.hp,),
              Expanded(
                flex: 1,
                    child: CustomTextWidget(
                      text: 'Reach out to us. We\'re \n always happy to help!',
                      size: 10.0.sp,
                      weight: FontWeight.w700,
                      ),
                  ),
              Expanded(
                flex: 6,
                child: Container(
                  width: 70.0.wp,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                            // OAUTH-GOOGLE: LOGIN
                            },
                          child: Container(
                            width: 20.0.wp,
                            height: 6.0.hp,
                            decoration: BoxDecoration(
                              color: AppStyles.bgGray4.withOpacity(0.8),
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
                                  color: AppStyles.bgGray4.withOpacity(0.8),
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
                                  color: AppStyles.bgGray4.withOpacity(0.8),
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
                      SizedBox(height: 5.0.hp),
                      Row(
                        children: [
                         Expanded(
                          child: Divider(color: AppStyles.bgBlack),
                        ),
                      SizedBox(width: 4.0.wp),
                      CustomTextWidget(
                        text: 'Or fill the form below\n to send us an email',
                        size: 12.0.sp,
                        color: AppStyles.bgBlack,
                        ),
                      SizedBox(width: 4.0.wp),
                      Expanded(
                        child: Divider(color: AppStyles.bgBlack),
                      ),
                    ],
                  ),
                  Column(
                children: [  
                 SizedBox(height: 6.0.hp),
                  CustomFormTextField(
                    hintText: 'Subject',
                    controller: subjectController,
                    background: AppStyles.bgGray4.withOpacity(0.4),
                    hintColor:AppStyles.bgBlack,
                    maxLines: 2,
                  ),
                  
                  SizedBox(height: 4.0.hp),
                  CustomFormTextField(
                    hintText: 'Message',
                    maxLines: 8,
                    controller: messageController,
                    background:AppStyles.bgGray4.withOpacity(0.4),
                    hintColor: AppStyles.bgBlack,
                  ),

                  SizedBox(height: 3.0.hp),
                  CustomButton(
                    text: 'Send Message',
                    width: double.maxFinite,
                    height: 6.0.hp,
                    onTapHandler: () {
                    },
                    fontSize: 12.0.sp,
                    borderRadius: 20,
                    fontColor: Colors.white,
                    fontWeight: FontWeight.bold,
                    backgroundColor: AppStyles.bgBlue,
                  ),
                ]
              ),

                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
 }
}
