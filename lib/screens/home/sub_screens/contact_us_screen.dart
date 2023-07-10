// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/data/index.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/screens/home/sub_screens/web_view.dart';
import 'package:medexer_donor/services/donor_services.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medexer_donor/network_services/network_error_message.dart';
import 'package:medexer_donor/network_services/network_manager.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/cutom_formtext_field.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/social_media_Index.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final NetworkManageController _networkManageController =
      Get.find<NetworkManageController>();

  final DonorServices donorServices = Get.find();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  late final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: Container(
          margin: EdgeInsets.only(top: 2.0.hp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PageHeader(scaffoldKey: scaffoldKey),
            ],
          ),
        ),
      ),
      body: Obx(
        () => (_networkManageController.connectionType.value == 0)
            ? const NetworkErrorMessage()
            : SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height: screenHeight,
                    padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                    child: Column(
                      children: [
                        // SizedBox(height: 2.0.hp),
                        // PageHeader(scaffoldKey: scaffoldKey),
                        SizedBox(height: 8.0.hp),
                        CustomTextWidget(
                          text: 'Reach out to us. We\'re always happy to help!',
                          size: 14.0.sp,
                          weight: FontWeight.w500,
                          alignment: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            socialMedia.length,
                            (index) => GestureDetector(
                              onTap: () {
                                Get.to(WebViewPage(
                                    socialmedia: socialMedia[index]));
                                // launchSocialMedia(
                                //     url: "${appSocials[index]['url']}");
                              },
                              child: Container(
                                  height: 6.0.hp,
                                  width: 25.0.wp,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 1.0.hp,
                                    horizontal: 2.0.wp,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.grey.shade300.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      socialMedia[index].icon,
                                      color: AppStyles.bgBlue,
                                      width: socialMedia[index].type ==
                                              //appSocials[index]['type'] ==
                                              'LINKEDIN'
                                          ? 22.0.sp
                                          : socialMedia[index].type ==
                                                  //appSocials[index]['type'] ==
                                                  'TWITTER'
                                              ? 22.0.sp
                                              : 12.0.sp,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 2.0.hp),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(color: AppStyles.bgPrimary),
                                ),
                                SizedBox(width: 4.0.wp),
                                CustomTextWidget(
                                  text: 'Or fill the form below\n to send us an email),',
                                  size: 12.0.sp,
                                  color: AppStyles.bgBlack,
                                ),
                                SizedBox(width: 4.0.wp),
                                Expanded(
                                  child: Divider(color: AppStyles.bgPrimary),
                                ),
                              ],
                            ),
                          ],
                        ),
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
                          borderRadius: 15,
                          fontColor: Colors.white,
                          fontWeight: FontWeight.bold,
                          backgroundColor: AppStyles.bgPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  launchSocialMedia({required String url}) async {
    var urllaunchable = await canLaunchUrl(
        Uri.parse(url)); //canLaunch is from url_launcher package
    if (urllaunchable) {
      await launchUrl(
        Uri.parse(url),
      ); //launch is from url_launcher package to launch URL
    } else {
      debugPrint("URL can't be launched.");
    }
  }
}
