import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/models/donation_center_model.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/widgets/text/cutom_formtext_field.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/services/donor_services.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

import '../../../network_services/network_error_message.dart';
import '../../../network_services/network_manager.dart';

class BookAppointmentScreen extends StatefulWidget {
  final DonationCenterModel donationCenter;
  const BookAppointmentScreen({super.key, required this.donationCenter});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final DonorServices donorServices = Get.find();
  final UserRepository userRepository = Get.find();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController messageController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();

  bool isForAdult = false;
  bool getNotifiedOnBloodUse = false;

  final NetworkManageController _networkManageController =
      Get.find<NetworkManageController>();

  Future<void> submitHandler() async {
    if (!messageController.text.trim().isNotEmpty) {
      Get.snackbar(
        'ERROR',
        backgroundColor: AppStyles.bgBrightRed.withOpacity(0.5),
        'Message is required.',
      );
    } else {
      Map formData = {
        'hospital': widget.donationCenter.pkid,
        'message': messageController.text.trim(),
        'getNotifiedOnBloodUse': getNotifiedOnBloodUse,
        'isForAdult': isForAdult,
      };

      debugPrint('[BOOK-APPOINTMENT-DTO] ::: $formData');
      await donorServices.bookAppointmentController(
        formData,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.35),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
          color: AppStyles.bgPrimary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppStyles.bgWhite,
                    backgroundImage: NetworkImage(
                      '${widget.donationCenter.hospitalProfile!.hospitalLogo}',
                    ),
                  ),
                ],
              ),
              CustomTextWidget(
                text: 'Book Appointment',
                size: 16.0,
                color: AppStyles.bgWhite,
                weight: FontWeight.w600,
              ),
              CustomTextWidget(
                text: '${widget.donationCenter.hospitalName}',
                size: 14.0,
                color: AppStyles.bgWhite,
                // weight: FontWeight.w600,
              ),
              CustomTextWidget(
                text: '${widget.donationCenter.centerAddress}',
                size: 14.0,
                color: AppStyles.bgWhite,
                // weight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              donorServices.donorRequestStatus.value == 'PENDING'
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      text: 'Submit',
                      height: screenHeight * 0.06,
                      width: MediaQuery.of(context).size.width * 0.9,
                      onTapHandler: () {
                        submitHandler();
                      },
                      fontSize: 14.0,
                      fontColor: Colors.white,
                      fontWeight: FontWeight.bold,
                      borderRadius: 10,
                      backgroundColor: AppStyles.bgPrimary,
                    ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: 15.0.hp,
              // ),
              Padding(
                  padding: EdgeInsets.all(2.0.wp),
                  child: Obx(() => _networkManageController
                              .connectionType.value ==
                          0
                      ? const NetworkErrorMessage()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 4.0.hp,
                            ),
                            Form(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomFormTextField(
                                      maxLines: 8,
                                      paddingLeft: 10,
                                      paddingTop: 5,
                                      paddingRight: 10,
                                      height: screenHeight * 0.25,
                                      borderRadius: 10,
                                      hintText:
                                          'Write a short message to the hospital',
                                      textColor: AppStyles.bgBlack,
                                      controller: messageController,
                                      background: Colors.white.withOpacity(0.4),
                                      hintColor: AppStyles.bgGray4,
                                    ),
                                    Row(
                                      children: [
                                        CustomTextWidget(
                                          text:
                                              'Are you donating for an adult?',
                                          size: 12.3,
                                        ),
                                        Switch(
                                          // thumb color (round icon)
                                          activeColor: AppStyles.bgPrimary,
                                          activeTrackColor: AppStyles.bgBlue,
                                          inactiveThumbColor:
                                              Colors.blueGrey.shade600,
                                          inactiveTrackColor:
                                              Colors.grey.shade400,
                                          splashRadius: 50.0,
                                          // boolean variable value
                                          value: isForAdult,
                                          // changes the state of the switch
                                          onChanged: (bool value) => setState(
                                              () => isForAdult = value),
                                        ),
                                      ],
                                    ),
                                    // SizedBox(height: 1.0.hp),
                                    Row(
                                      children: [
                                        CustomTextWidget(
                                          text:
                                              'Get notification when blood is used?',
                                          size: 12.3,
                                        ),
                                        Switch(
                                          // thumb color (round icon)
                                          activeColor: AppStyles.bgPrimary,
                                          activeTrackColor: AppStyles.bgBlue,
                                          inactiveThumbColor:
                                              Colors.blueGrey.shade600,
                                          inactiveTrackColor:
                                              Colors.grey.shade400,
                                          splashRadius: 50.0,
                                          // boolean variable value
                                          value: getNotifiedOnBloodUse,
                                          // changes the state of the switch
                                          onChanged: (bool value) => setState(
                                              () => getNotifiedOnBloodUse =
                                                  value),
                                        ),
                                      ],
                                    ),
                                    // SizedBox(height: 2.0.hp),
                                    // CustomButton(
                                    //   text: 'Book Appointment',
                                    //   height: 6.0.hp,
                                    //   width: double.maxFinite,
                                    //   onTapHandler: () {
                                    //     submitHandler();
                                    //   },
                                    //   fontSize: 10.0.sp,
                                    //   fontColor: Colors.white,
                                    //   fontWeight: FontWeight.bold,
                                    //   borderRadius: 10,
                                    //   backgroundColor: AppStyles.bgPrimary,
                                    // ),
                                  ]),
                            ),
                          ],
                        )))
            ],
          ),
        ),
      ),
    );
  }
}
