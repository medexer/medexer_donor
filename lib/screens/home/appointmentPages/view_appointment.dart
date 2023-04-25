import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/home/appointmentPages/reschedule_appointment.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

import '../../../database/user_repository.dart';
import '../../../services/donor_services.dart';
import '../../../widgets/page_header.dart';
import '../sidebar.dart';

class ViewAppointmentScreen extends StatefulWidget {
  const ViewAppointmentScreen({super.key});

  @override
  State<ViewAppointmentScreen> createState() => _ViewAppointmentScreenState();
}

class _ViewAppointmentScreenState extends State<ViewAppointmentScreen> {
  final DonorServices DonorServicess = Get.find();
  final UserRepository userRepository = Get.find();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // DonorServicess.fetchAppointmentDataController();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Obx(() => Scaffold(
          key: scaffoldKey,
          drawer: const SideBar(),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PageHeader(scaffoldKey: scaffoldKey),
                SizedBox(
                  height: 2.0.hp,
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        CustomTextWidget(
                          text: 'Hospital 1',
                          color: AppStyles.bgBlack,
                          size: 20.0.sp,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(height: 1.0.hp),
                        CustomTextWidget(
                          text: "No.1 Lorem Impsum Street, Xyz City",
                          size: 10.0.sp,
                        ),
                        SizedBox(
                          height: 1.0.hp,
                        ),
                        CustomButton(
                            text: 'See Direction',
                            width: 50.0.wp,
                            height: 5.0.hp,
                            onTapHandler: () {},
                            fontSize: 11.0.sp,
                            fontColor: Colors.white,
                            fontWeight: FontWeight.w200,
                            borderRadius: 20,
                            backgroundColor: AppStyles.bgBlue),
                        SizedBox(height: 1.0.hp),
                        CustomTextWidget(
                          text: 'You are scheduled to donate blood on:',
                          color: Colors.green,
                          size: 10.0.sp,
                        ),
                        CustomTextWidget(
                          text: "Message",
                          color: Colors.green,
                          size: 10.0.sp,
                        ),
                        CustomTextWidget(
                          text: 'Donation Message',
                          // text:'${userRepository.donorData.value.message}',
                          color: Colors.green,
                          size: 10.0.sp,
                        ),
                        SizedBox(
                          height: 2.0.hp,
                        ),
                        CustomButton(
                            text: 'Request Reschedule',
                            width: 80.0.wp,
                            height: 6.0.hp,
                            onTapHandler: () {
                              Get.to(const ReschedulAppointmentScreen());
                            },
                            fontSize: 15.0.sp,
                            fontColor: Colors.white,
                            fontWeight: FontWeight.w200,
                            borderRadius: 15,
                            backgroundColor: AppStyles.bgBlue)
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
