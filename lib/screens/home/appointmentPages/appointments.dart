// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/services/donor_services.dart';

class Appointments extends StatefulWidget {
  final double height;
  const Appointments({super.key, required this.height});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  final UserRepository userRepository = Get.find();
  final DonorServices donorServices = Get.put(DonorServices());

  @override
  void initState() {
    super.initState();

    donorServices.fetchAppointmentsController();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Obx(
        () => userRepository.appointments.isEmpty
            ? Container(
                child: Lottie.asset('assets/animations/animation__2.json'),
              )
            : Container(
                // height: widget.height,
                height: screenHeight * 0.8,
                child: ListView.builder(
                  itemCount: userRepository.appointments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading:
                          CustomTextWidget(text: '${index + 1}', size: 8.0.sp),
                      title: CustomTextWidget(
                        text:
                            '${userRepository.appointments[index].hospitalInfo.hospitalName}',
                        size: 12.0.sp,
                      ),
                      subtitle: CustomTextWidget(
                        text:
                            '${userRepository.appointments[index].hospitalInfo.location}',
                        size: 8.0.sp,
                      ),
                      trailing: CustomTextWidget(
                        text:
                            '${userRepository.appointments[index].date ?? ''}',
                        color: Colors.green,
                        size: 8.0.sp,
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
