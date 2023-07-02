// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/models/medical_history_model.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class MedicalHistoryItemScreen extends StatefulWidget {
  final MedicalHistoryModel medicalHistoryItem;
  const MedicalHistoryItemScreen({super.key, required this.medicalHistoryItem});

  @override
  State<MedicalHistoryItemScreen> createState() =>
      _MedicalHistoryItemScreenState();
}

class _MedicalHistoryItemScreenState extends State<MedicalHistoryItemScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.25),
        child: Container(
          decoration: BoxDecoration(
            color: AppStyles.bgPrimary,
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: 'Medical History',
                size: 15.0.sp,
                color: AppStyles.bgWhite,
                weight: FontWeight.w600,
              ),
              CustomTextWidget(
                text:
                    'Appointment ID: ${widget.medicalHistoryItem.appointmentInfo!.appointmentID}',
                size: 11.0.sp,
                color: AppStyles.bgWhite,
                // weight: FontWeight.w600,
              ),
              CustomTextWidget(
                text:
                    'Centre Name: ${widget.medicalHistoryItem.hospitalProfile!.hospitalName}',
                size: 11.0.sp,
                color: AppStyles.bgWhite,
                // weight: FontWeight.w600,
              ),
              CustomTextWidget(
                text: 'Uploaded On: ${widget.medicalHistoryItem.createdAt}',
                size: 10.0.sp,
                color: AppStyles.bgWhite,
                // weight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView(
            children: [
              ListTile(
                leading: CustomTextWidget(
                  text: '1',
                  size: 10.0.sp,
                ),
                title: CustomTextWidget(
                  text: 'HIV 1/2',
                  size: 13.0.sp,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 11.0.sp,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.hiv}',
                      size: 11.0.sp,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '2',
                  size: 10.0.sp,
                ),
                title: CustomTextWidget(
                  text: 'Hepatitis B',
                  size: 13.0.sp,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 11.0.sp,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.hepatitisB}',
                      size: 11.0.sp,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '3',
                  size: 10.0.sp,
                ),
                title: CustomTextWidget(
                  text: 'Hepatitis C',
                  size: 13.0.sp,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 11.0.sp,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.hepatitisC}',
                      size: 11.0.sp,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '4',
                  size: 10.0.sp,
                ),
                title: CustomTextWidget(
                  text: 'VDRL (Venereal Disease Research Laboratory)',
                  size: 13.0.sp,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 11.0.sp,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.vdrl}',
                      size: 11.0.sp,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '5',
                  size: 10.0.sp,
                ),
                title: CustomTextWidget(
                  text: 'Blood Pressure',
                  size: 13.0.sp,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 11.0.sp,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.bloodPressure}',
                      size: 11.0.sp,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '6',
                  size: 10.0.sp,
                ),
                title: CustomTextWidget(
                  text: 'Body Temperature',
                  size: 13.0.sp,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 11.0.sp,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.bodyTemperature}',
                      size: 11.0.sp,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '7',
                  size: 10.0.sp,
                ),
                title: CustomTextWidget(
                  text: 'Genotype',
                  size: 13.0.sp,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 11.0.sp,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.genotype}',
                      size: 11.0.sp,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '8',
                  size: 10.0.sp,
                ),
                title: CustomTextWidget(
                  text: 'Blood Group',
                  size: 13.0.sp,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 11.0.sp,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.bloodGroup}',
                      size: 11.0.sp,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '9',
                  size: 10.0.sp,
                ),
                title: CustomTextWidget(
                  text: 'PCV (Packed Cell Volume)',
                  size: 13.0.sp,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 11.0.sp,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.pcv}',
                      size: 11.0.sp,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '10',
                  size: 10.0.sp,
                ),
                title: CustomTextWidget(
                  text: 'Weight',
                  size: 13.0.sp,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 11.0.sp,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.weight}',
                      size: 11.0.sp,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '11',
                  size: 10.0.sp,
                ),
                title: CustomTextWidget(
                  text: 'Weight',
                  size: 13.0.sp,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 11.0.sp,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.height}',
                      size: 11.0.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.0.hp),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
