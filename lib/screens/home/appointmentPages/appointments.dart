import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/models/donor_activity_model.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

import '../../../database/user_repository.dart';
import '../../../services/donor_activity_service.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {

  final UserRepository userRepository = Get.find();
  final DonorActivityService donorActivityServices = Get.put(DonorActivityService());
  
  @override
  void initState(){
    super.initState();
    donorActivityServices.fetchHospitalController();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => 
        donorActivityServices.donorActivityLoading.value?
        const CircularProgressIndicator():
        ListView.builder(
          itemCount: donorActivityServices.hospitalScreenModel?.donorActivityModel?.length??0,
          itemBuilder: (context, index) {
            return ListTile(
                leading: SvgPicture.asset(
                  'assets/icons/icon__building.svg',
                  color: AppStyles.bgPrimary,
                ),
                title: CustomTextWidget(
                  text: donorActivityServices.hospitalScreenModel?.donorActivityModel![index].hospital??'no hospital found',
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
          } 
        )
      )
      );
  

      // return FutureBuilder<HospitalScreenModel>(
        
        // builder: ((context, snapshot){
        //   if(snapshot.hasData){
        //     return ListView.builder(
        //       itemCount: userRepository.hospitalData.value.length,
        //       itemBuilder: ((context, index) => ),
           

    // return ListView.builder(
    //         itemCount: userRepository.hospitalData.value.length,
    //         itemBuilder: (_, index) {
    //           return ListTile(
    //             leading: SvgPicture.asset(
    //               'assets/icons/icon__building.svg',
    //               color: AppStyles.bgPrimary,
    //             ),
    //             title: CustomTextWidget(
    //               text: 'Hospital ${index + 1}',
    //               size: 12.0.sp,
    //             ),
    //             subtitle: CustomTextWidget(
    //               text: 'No 1. Lorem Impsum Street...',
    //               size: 8.0.sp,
    //             ),
    //             trailing: CustomTextWidget(
    //               text: 'Approved',
    //               color: Colors.green,
    //               size: 8.0.sp,
    //             ),
    //           );
    //         });
            // SizedBox(height: 2.0.hp,),
            // // CustomButton(
            //   text: 'Book an Appointment', 
            //   width: 60.0.wp, 
            //   height: 6.0.hp, 
            //   onTapHandler: (){
            //     const ViewAppointmentScreen();
            //   }, 
            //   fontSize: 13.0.sp, 
            //   fontColor: Colors.white, 
            //   fontWeight: FontWeight.bold, 
            //   borderRadius: 20, 
            //   backgroundColor: AppStyles.bgBlue
           // );
    
  }
}
