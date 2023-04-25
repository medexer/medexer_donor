import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import '../../../database/user_repository.dart';
import '../../../services/donor_services.dart';
import '../../../widgets/snackbars/custom_snackbar_container.dart';
import '../../../widgets/text/custom_text_widget.dart';

class ReschedulAppointmentScreen extends StatefulWidget {
  const ReschedulAppointmentScreen({super.key});

  @override
  State<ReschedulAppointmentScreen> createState() =>
      _ReschedulAppointmentScreenState();
}

class _ReschedulAppointmentScreenState
    extends State<ReschedulAppointmentScreen> {
  final DonorServices DonorServicess = Get.find();
  final UserRepository userRepository = Get.find();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  // Future<void> donorActivityHandler() async {
  //   if(!hospitalController.text.trim().isNotEmpty||
  //   !messageController.text.trim().isNotEmpty
  //   ) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: CustomSnackbarContainer(
  //           backgroundType: '',
  //           title: 'Info',
  //           description:
  //               'Please ensure your fill in all fields in the form as the are required.',
  //         ),
  //         behavior: SnackBarBehavior.floating,
  //         elevation: 0,
  //         backgroundColor: Colors.transparent,
  //       ),
  //     );
  //   }
  //   else {
  //     Map data = {
  //       "message": messageController.text.trim(),
  //       "hospital":hospitalController.text.trim(),
  //       'donor':'5',
  //       "date": DateTime.now(),
  //     };

  //     debugPrint('[BOOKANAPPOINTMENT DTO] :: $data');
  //     await DonorServicess.bookAppointmentController(
  //       data,
  //     );

  //     debugPrint('[ERROR] :: ${DonorServicess.donorRequestError.value}');

  //     if (DonorServicess.donorRequestStatus.value == 'SUCCESS') {
  //       setState(() {
  //         DonorServicess.donorRequestLoading.value = false;
  //         DonorServicess.donorRequestError.value = '';
  //         DonorServicess.donorRequestStatus.value = '';
  //       });

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: const CustomSnackbarContainer(
  //             backgroundType: 'SUCCESS',
  //             title: 'Success',
  //             description:
  //                 'Book successful.',
  //           ),
  //           behavior: SnackBarBehavior.floating,
  //           elevation: 0,
  //           backgroundColor: Colors.transparent,
  //           margin: EdgeInsets.only(
  //             // ignore: use_build_context_synchronously
  //             bottom: MediaQuery.of(context).size.height - 150,
  //           ),
  //         ),
  //       );
  //       setState(() {
  //         messageController.clear();
  //         hospitalController.clear();
  //       });
  //     }
  //   }
  //  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.0.hp,
            ),
            Padding(
              padding: EdgeInsets.all(2.0.wp),
              child: Column(
                children: [
                  CustomTextWidget(
                    text: 'Book Appointment',
                    size: 15.0.sp,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 3.0.hp,
                  ),
                  Form(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 8.0.hp,
                              child: TextFormField(
                                controller: hospitalController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    hintText: 'Redplate Hospital',
                                    labelText: 'Hosptal'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.0.hp,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 12.0.hp,
                              child: TextFormField(
                                maxLines: 2,
                                controller: messageController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    hintText:
                                        'I would love to come for my checkup tomorrow',
                                    labelText: 'Message'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.0.hp,
                          ),
                          CustomButton(
                              text: 'Reschedule Appointment',
                              height: 6.0.hp,
                              width: 60.0.wp,
                              onTapHandler: () {
                                //donorActivityHandler();
                              },
                              fontSize: 10.0.sp,
                              fontColor: Colors.white,
                              fontWeight: FontWeight.bold,
                              borderRadius: 20,
                              backgroundColor: AppStyles.bgBlue),
                        ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
