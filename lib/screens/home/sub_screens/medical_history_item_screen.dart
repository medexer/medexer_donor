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
            Size.fromHeight(MediaQuery.of(context).size.height * 0.35),
        child: Container(
          decoration: BoxDecoration(
            color: AppStyles.bgPurpleDark,
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
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
                      '${widget.medicalHistoryItem.hospitalProfile!.hospitalLogo}',
                    ),
                  ),
                ],
              ),
              CustomTextWidget(
                text: 'Medical History',
                size: 16.0,
                color: AppStyles.bgWhite,
                weight: FontWeight.w600,
              ),
              CustomTextWidget(
                text:
                    'Appointment ID: ${widget.medicalHistoryItem.appointmentInfo!.appointmentID}',
                size: 14.0,
                color: AppStyles.bgWhite,
                // weight: FontWeight.w600,
              ),
              CustomTextWidget(
                text:
                    'Centre Name: ${widget.medicalHistoryItem.hospitalProfile!.hospitalName}',
                size: 14.0,
                color: AppStyles.bgWhite,
                // weight: FontWeight.w600,
              ),
              CustomTextWidget(
                text: 'Uploaded On: ${widget.medicalHistoryItem.createdAt}',
                size: 12.0,
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
                  size: 12.0,
                ),
                title: CustomTextWidget(
                  text: 'HIV 1/2',
                  size: 14.0,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 12.0,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.hiv}',
                      size: 12.0,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '2',
                  size: 12.0,
                ),
                title: CustomTextWidget(
                  text: 'Hepatitis B',
                  size: 14.0,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 12.0,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.hepatitisB}',
                      size: 12.0,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '3',
                  size: 12.0,
                ),
                title: CustomTextWidget(
                  text: 'Hepatitis C',
                  size: 14.0,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 12.0,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.hepatitisC}',
                      size: 12.0,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '4',
                  size: 12.0,
                ),
                title: CustomTextWidget(
                  text: 'VDRL (Venereal Disease Research Laboratory)',
                  size: 14.0,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 12.0,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.vdrl}',
                      size: 12.0,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '5',
                  size: 12.0,
                ),
                title: CustomTextWidget(
                  text: 'Blood Pressure',
                  size: 14.0,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 12.0,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.bloodPressure}',
                      size: 12.0,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '6',
                  size: 12.0,
                ),
                title: CustomTextWidget(
                  text: 'Body Temperature',
                  size: 14.0,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 12.0,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.bodyTemperature}',
                      size: 12.0,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '7',
                  size: 12.0,
                ),
                title: CustomTextWidget(
                  text: 'Genotype',
                  size: 14.0,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 12.0,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.genotype}',
                      size: 12.0,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '8',
                  size: 12.0,
                ),
                title: CustomTextWidget(
                  text: 'Blood Group',
                  size: 14.0,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 12.0,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.bloodGroup}',
                      size: 12.0,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '9',
                  size: 12.0,
                ),
                title: CustomTextWidget(
                  text: 'PCV (Packed Cell Volume)',
                  size: 14.0,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 12.0,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.pcv}',
                      size: 12.0,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '10',
                  size: 12.0,
                ),
                title: CustomTextWidget(
                  text: 'Weight',
                  size: 14.0,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 12.0,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.weight}',
                      size: 12.0,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                leading: CustomTextWidget(
                  text: '11',
                  size: 12.0,
                ),
                title: CustomTextWidget(
                  text: 'Height',
                  size: 14.0,
                  weight: FontWeight.w500,
                ),
                subtitle: Row(
                  children: [
                    CustomTextWidget(
                      text: 'Status: ',
                      size: 12.0,
                    ),
                    // SizedBox(width: 2.0.wp),
                    CustomTextWidget(
                      text: '${widget.medicalHistoryItem.height}',
                      size: 12.0,
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
