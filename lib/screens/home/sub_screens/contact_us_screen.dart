// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/data/index.dart';
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
  final NetworkManageController _networkManageController =
      Get.find<NetworkManageController>();

  final DonorServices donorServices = Get.find();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: SizedBox(
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
                        SizedBox(height: 10.0.hp),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            appSocials.length,
                            (index) => GestureDetector(
                              onTap: () {
                                launchSocialMedia(
                                    url: appSocials[index]['url']);
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
                                      appSocials[index]['icon'],
                                      color: AppStyles.bgBlue,
                                      width: appSocials[index]['type'] ==
                                              'LINKEDIN'
                                          ? 22.0.sp
                                          : appSocials[index]['type'] ==
                                                  'TWITTER'
                                              ? 22.0.sp
                                              : 12.0.sp,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.0.hp),
                        CustomTextWidget(
                          text: 'Reach out to us. We\'re always happy to help!',
                          size: 14.0.sp,
                          weight: FontWeight.w500,
                          alignment: TextAlign.center,
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
    // if (!await launchUrl(Uri.parse(url))) {
    //   throw 'could not';
    // }

    var urllaunchable = await canLaunchUrl(
        Uri.parse(url)); //canLaunch is from url_launcher package
    if (urllaunchable) {
      await launchUrl(
          Uri.parse(url)); //launch is from url_launcher package to launch URL
    } else {
      debugPrint("URL can't be launched.");
    }
  }
}
