import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import '../../../database/user_repository.dart';
import '../../../services/donor_activity_service.dart';
import '../../../widgets/text/custom_text_widget.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final DonorActivityService donorActivityServices =Get.find();
  final UserRepository userRepository = Get.find();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //TextEditingController searchController = TextEditingController();
  //TextEditingController hospitalController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  Future<void> donorActivityHandler() async {
    if(!messageController.text.trim().isNotEmpty) {
      Get.snackbar(
        backgroundColor: AppStyles.bgPrimary,
        'ERROR!', 
        'Please ensure your fill in all fields in the form as the are required.'
    
      );
     } 
    else {
      Map data = {
        'hospital':3,
        'message':messageController.text.trim()
      };

      debugPrint('[BOOKANAPPOINTMENT DTO] ::: $data');
      await donorActivityServices.appointmentController(
        data,
      );

      debugPrint('[ERROR] ::: ${donorActivityServices.donorActivityError.value}');
      
      if (donorActivityServices.donorActivityStatus.value == 'SUCCESS') {
        setState(() {
          donorActivityServices.donorActivityLoading.value = false;
          donorActivityServices.donorActivityError.value = '';
          donorActivityServices.donorActivityStatus.value = '';
        });

        showDialog(context: context, 
            builder: (BuildContext context){
              return AlertDialog(
                content: const Text("Successfully Booked an Appoinment"),
                actions: [
                  CustomButton(text: 'OK', 
                  width: 15.0.wp, 
                  height:2.0.hp, 
                  onTapHandler: (){
                    Get.back();
                  }, fontSize: 13.0.sp, 
                  fontColor: Colors.white, 
                  fontWeight: FontWeight.w300, 
                  borderRadius: 10, 
                  backgroundColor: AppStyles.bgBlue)
                ],
              );
            });
        setState(() {
          messageController.clear();
        });
      }
    }
   }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,   
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15.0.hp,),
              Padding(
                padding: EdgeInsets.all(2.0.wp),
                child: Column(
                  children: [
                    CustomTextWidget(
                      text: 'Book Appointment',
                      size: 15.0.sp,
                      weight: FontWeight.bold,
                      ),
                    SizedBox(height: 3.0.hp,),
                    Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Container(
                    //         height: 8.0.hp,
                    //         child: TextFormField(
                    //     controller: hospitalController,
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //            borderRadius: BorderRadius.circular(20.0)
                    //         ),
                    //         hintText: 'Redplate Hospital',
                    //         labelText:'Hosptal'
                    //     ),     
                    //   ),
                    //       ),
                    // ),
                    SizedBox(height: 4.0.hp,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 12.0.hp,
                        child: TextFormField(
                          maxLines: 2,
                          controller: messageController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20.0)
                            ),
                            hintText: 'I would love to come for my checkup tomorrow',
                            labelText:'Message'
                          ), 
                        ),
                      ),
                    ),
                    SizedBox(height: 2.0.hp,),
                    CustomButton(
                      text: 'Book Appointment', 
                      height: 6.0.hp,
                      width: 60.0.wp, 
                      onTapHandler: (){
                        donorActivityHandler();
                      }, 
                      fontSize: 10.0.sp, 
                      fontColor: Colors.white, 
                      fontWeight:FontWeight.bold, 
                      borderRadius: 20, 
                      backgroundColor: AppStyles.bgBlue
                      ),
                  ]
                ),

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
