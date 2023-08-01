import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/models/appointment_model.dart';
import 'package:medexer_donor/screens/home/appointmentPages/appointment_center_location_screen.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class ViewAppointmentScreen extends StatefulWidget {
  final AppointmentModel appointment;
  const ViewAppointmentScreen({
    super.key,
    required this.appointment,
  });

  @override
  State<ViewAppointmentScreen> createState() => _ViewAppointmentScreenState();
}

class _ViewAppointmentScreenState extends State<ViewAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: 'Center Location',
              height: screenHeight * 0.06,
              width: MediaQuery.of(context).size.width * 0.9,
              onTapHandler: () {
                Get.to(
                  () => AppointmentCenterLocationScreen(
                    appointmentCenter: widget.appointment,
                  ),
                );
              },
              fontSize: 14.0,
              fontColor: Colors.white,
              fontWeight: FontWeight.bold,
              borderRadius: 10,
              backgroundColor: widget.appointment.isDonated == true
                  ? Colors.green.shade600
                  : AppStyles.bgPrimary,
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.35),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
          color: widget.appointment.isDonated == true
              ? Colors.green.shade600
              : AppStyles.bgPrimary,
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
                      '${widget.appointment.hospitalProfile!.hospitalLogo}',
                    ),
                  ),
                ],
              ),
              CustomTextWidget(
                text: 'Appointment',
                size: 16.0,
                color: AppStyles.bgWhite,
                weight: FontWeight.w600,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     CustomTextWidget(
              //       text: '${widget.appointment.appointmentID}',
              //       size: 12.0,
              //       color: AppStyles.bgWhite,
              //       // weight: FontWeight.w600,
              //     ),
              //   ],
              // ),
              CustomTextWidget(
                text: 'Appointment ID: ${widget.appointment.appointmentID}',
                size: 14.0,
                color: AppStyles.bgWhite,
                // weight: FontWeight.w600,
              ),
              CustomTextWidget(
                text:
                    'Center Name: ${widget.appointment.hospitalInfo!.hospitalName}',
                size: 14.0,
                color: AppStyles.bgWhite,
                // weight: FontWeight.w600,
              ),
              CustomTextWidget(
                text: 'Address: ${widget.appointment.hospitalInfo!.location}',
                size: 12.0,
                color: AppStyles.bgWhite,
                // weight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView(
              children: [
                SizedBox(height: 4.0.hp),
                ListTile(
                  leading: CustomTextWidget(
                    text: '-',
                    size: 12.0,
                  ),
                  title: CustomTextWidget(
                    text: 'Appointment Date',
                    size: 14.0,
                    weight: FontWeight.w500,
                  ),
                  trailing: CustomTextWidget(
                    text: '${widget.appointment.date ?? 'PENDING'}',
                    size: 14.0,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: CustomTextWidget(
                    text: '-',
                    size: 12.0,
                  ),
                  title: CustomTextWidget(
                    text: 'Donation Type',
                    size: 14.0,
                    weight: FontWeight.w500,
                  ),
                  trailing: CustomTextWidget(
                    text: widget.appointment.isForAdult == true
                        ? 'ADULT'
                        : 'CHILD',
                    size: 14.0,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: CustomTextWidget(
                    text: '-',
                    size: 12.0,
                  ),
                  title: CustomTextWidget(
                    text: 'Receive Notification',
                    size: 14.0,
                    weight: FontWeight.w500,
                  ),
                  trailing: CustomTextWidget(
                    text: widget.appointment.getNotifiedOnBloodUse == true
                        ? 'ENABLED'
                        : 'DISABLED',
                    size: 14.0,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: CustomTextWidget(
                    text: '-',
                    size: 12.0,
                  ),
                  title: CustomTextWidget(
                    text: 'Donated',
                    size: 14.0,
                    weight: FontWeight.w500,
                  ),
                  trailing: CustomTextWidget(
                    text: widget.appointment.isDonated == true ? 'YES' : 'NO',
                    size: 14.0,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: CustomTextWidget(
                    text: '-',
                    size: 12.0,
                  ),
                  title: CustomTextWidget(
                    text: 'Donation Date',
                    size: 14.0,
                    weight: FontWeight.w500,
                  ),
                  trailing: CustomTextWidget(
                    text: widget.appointment.donationDate ?? '-',
                    size: 14.0,
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
