// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/services/donor_services.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../network_services/network_error_message.dart';
import '../../../network_services/network_manager.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/text/cutom_formtext_field.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final NetworkManageController _networkManageController = Get.find<NetworkManageController>();

  final DonorServices donorServices = Get.find();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      body: Obx(()=>(_networkManageController.connectionType.value == 0)?const NetworkErrorMessage():
        SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: screenHeight,
              child: Column(
                children: [
                  SizedBox(
                    height: 2.0.hp,
                  ),
                  PageHeader(scaffoldKey: scaffoldKey),
                  SizedBox(
                    height: 10.0.hp,
                  ),
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
                      // width: 70.0.wp,
                      margin: EdgeInsets.symmetric(horizontal: 4.0.wp),
                      child: Column(
                        children: [
                          Column(children: [
                            SizedBox(height: 6.0.hp),
                            CustomFormTextField(
                              hintText: 'Subject',
                              controller: subjectController,
                              background: Colors.white,
                              borderRadius: 10,
                              textColor: AppStyles.bgBlack,
                              hintColor: AppStyles.bgBlack,
                              maxLines: 1,
                            ),
                            SizedBox(height: 4.0.hp),
                            CustomFormTextField(
                              hintText: 'Message',
                              maxLines: 6,
                              paddingLeft: 10,
                              paddingRight: 10,
                              height: 14.0.hp,
                              borderRadius: 10,
                              textColor: AppStyles.bgBlack,
                              controller: messageController,
                              background: Colors.white.withOpacity(0.4),
                              hintColor: AppStyles.bgBlack,
                            ),
                            SizedBox(height: 3.0.hp),
                            CustomButton(
                              text: 'Send Message',
                              width: double.maxFinite,
                              height: 6.0.hp,
                              onTapHandler: () async {
                                if (subjectController.text.trim() == '') {
                                  Get.snackbar(
                                    'Error',
                                    'Subject is required',
                                    colorText: Colors.white,
                                    backgroundColor:
                                        AppStyles.bgBlue.withOpacity(0.8),
                                  );
                                }
                                if (messageController.text.trim() == '') {
                                  Get.snackbar(
                                    'Error',
                                    'Message is required',
                                    colorText: Colors.white,
                                    backgroundColor:
                                        AppStyles.bgBlue.withOpacity(0.8),
                                  );
                                }
      
                                Map formData = {
                                  "subject": subjectController.text.trim(),
                                  "message": messageController.text.trim(),
                                };
      
                                await donorServices.contactUsController(formData);
                              },
                              fontSize: 12.0.sp,
                              borderRadius: 20,
                              fontColor: Colors.white,
                              fontWeight: FontWeight.bold,
                              backgroundColor: AppStyles.bgBlue,
                            ),
                          ]),
                          SizedBox(height: 3.0.hp,),
                          CustomButton(text: 's', width: 100, height: 30, 
                          onTapHandler: (){
                            launchSocialMedia(url:'https://www.medexer.com.ng/' );
                          },
                          fontSize: 10, fontColor: AppStyles.bgWhite, fontWeight: FontWeight.bold, borderRadius: 30, backgroundColor: AppStyles.bgBlue),
                          SizedBox(height: 3.0.hp,),
                          CustomButton(text: 'linkedIn', width: 50, height: 30, 
                          onTapHandler: (){
                            launchSocialMedia(url:'https://www.bing.com/search?q=medexer+linkedin&cvid=73fd860f90534b04bbd25f3c2db3420f&aqs=edge..69i57j69i64.14909j0j4&FORM=ANWAB1&PC=U531' );
                          },
                          fontSize: 10, fontColor: AppStyles.bgWhite, fontWeight: FontWeight.bold, borderRadius: 30, backgroundColor: AppStyles.bgBlue),
                        
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  launchSocialMedia({required String url})async{
    if(!await launchUrl(Uri.parse(url))){
      throw 'could not';
    }
  }
}
