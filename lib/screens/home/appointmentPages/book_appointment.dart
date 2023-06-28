import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/models/donation_center_model.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
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
  bool visitRecipient = false;

  final NetworkManageController _networkManageController =
      Get.find<NetworkManageController>();

  Future<void> submitHandler() async {
    if (!messageController.text.trim().isNotEmpty) {
      Get.snackbar(
        'ERROR',
        backgroundColor: AppStyles.bgPrimary,
        'Message field is required.',
      );
    } else {
      Map formData = {
        'hospital': widget.donationCenter.pkid,
        'message': messageController.text.trim(),
        'isForAdult':isForAdult,
        'visitRecipient':visitRecipient,
      };

      debugPrint('[BOOK-APPOINTMENT-DTO] ::: $formData');
      await donorServices.bookAppointmentController(
        formData,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.0.hp,
              ),
              Padding(
                  padding: EdgeInsets.all(2.0.wp),
                  child: Obx(() => _networkManageController
                              .connectionType.value ==
                          0
                      ? const NetworkErrorMessage()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              text: 'Book Appointment',
                              size: 15.0.sp,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: 3.0.hp,
                            ),
                            Form(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomFormTextField(
                                      maxLines: 1,
                                      readOnly: true,
                                      borderRadius: 10,
                                      textColor: AppStyles.bgBlack,
                                      controller: TextEditingController(
                                          text:
                                              '${widget.donationCenter.hospitalName}'),
                                      background: Colors.white.withOpacity(0.4),
                                      hintColor: AppStyles.bgBlack,
                                    ),
                                    SizedBox(height: 2.0.hp),
                                    CustomFormTextField(
                                      maxLines: 1,
                                      readOnly: true,
                                      borderRadius: 10,
                                      textColor: AppStyles.bgBlack,
                                      controller: TextEditingController(
                                          text:
                                              '${widget.donationCenter.centerAddress}'),
                                      background: Colors.white.withOpacity(0.4),
                                      hintColor: AppStyles.bgBlack,
                                    ),
                                    SizedBox(height: 2.0.hp),
                                    CustomFormTextField(
                                      maxLines: 6,
                                      paddingLeft: 10,
                                      paddingTop: 5,
                                      paddingRight: 10,
                                      height: 14.0.hp,
                                      borderRadius: 10,
                                      hintText:
                                          'Write a short message to the hospial',
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
                                          size: 12.0.sp,
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
                                          text: 'Visit Donation Recipient?',
                                          size: 12.0.sp,
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
                                          value: visitRecipient,
                                          // changes the state of the switch
                                          onChanged: (bool value) => setState(
                                              () => visitRecipient = value),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2.0.hp),
                                    CustomButton(
                                        text: 'Book Appointment',
                                        height: 6.0.hp,
                                        width: double.maxFinite,
                                        onTapHandler: () {
                                          submitHandler();
                                        },
                                        fontSize: 10.0.sp,
                                        fontColor: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        borderRadius: 10,
                                        backgroundColor: AppStyles.bgBlue),
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
