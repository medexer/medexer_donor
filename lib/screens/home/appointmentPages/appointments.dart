import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            itemCount: 5,
            itemBuilder: (_, index) {
              return ListTile(
                leading: SvgPicture.asset(
                  'assets/icons/icon__building.svg',
                  color: AppStyles.bgPrimary,
                ),
                title: CustomTextWidget(
                  text: 'Hospital ${index + 1}',
                  size: 12.0.sp,
                ),
                subtitle: CustomTextWidget(
                  text: 'No 1. Lorem Impsum Street...',
                  size: 8.0.sp,
                ),
                trailing: CustomTextWidget(
                  text: 'Approved',
                  color: Colors.green,
                  size: 8.0.sp,
                ),
              );
            });
    //         SizedBox(height: 2.0.hp,),
    //         CustomButton(
    //           text: 'Book an Appointment', 
    //           width: 60.0.wp, 
    //           height: 6.0.hp, 
    //           onTapHandler: (){
    //             const ViewAppointmentScreen();
    //           }, 
    //           fontSize: 13.0.sp, 
    //           fontColor: Colors.white, 
    //           fontWeight: FontWeight.bold, 
    //           borderRadius: 20, 
    //           backgroundColor: AppStyles.bgBlue
    //         ),
    //   ],
    // );
  }
}
