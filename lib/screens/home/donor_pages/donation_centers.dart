//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
//import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/home/appointmentPages/book_appointment.dart';
import 'package:medexer_donor/screens/home/appointmentPages/reschedule_appointment.dart';
import 'package:medexer_donor/screens/home/appointmentPages/view_appointment.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/card/custom_message_card.dart';
import 'package:medexer_donor/widgets/text/custom_search_widget.dart';
//import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class DonationCenters extends StatefulWidget {
  const DonationCenters({super.key});

  @override
  State<DonationCenters> createState() => _DonationCentersState();
}

class _DonationCentersState extends State<DonationCenters> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(
            padding: EdgeInsets.all(2.0.hp),
            child: CustomTextWidget(
                text: 'Enter the phone number or ID of the donation center here',
                size: 10.0.sp,
               ),
          ),  
          
                Padding(
                  padding: EdgeInsets.all(4.0.wp),
                  child: CustomSearchField(
                    hintText: 'Search For Donation Center',
                    controller: searchController,
                    icon: 'assets/icons/icon__search.png',
                    // background: Colors.white.withOpacity(0.4),
                  ),
                ),
            SizedBox(height: 2.0.hp,),
            CustomButton(
              text: '     Comfirm Donor Center', 
              width: 60.0.wp, 
              height: 5.0.hp, 
              onTapHandler: (){
               Get.to(const ViewAppointmentScreen());
              }, 
              fontSize: 10.0.sp, 
              fontColor: Colors.white, 
              fontWeight:FontWeight.bold, 
              borderRadius: 20.0, 
              backgroundColor: AppStyles.bgBlue),
            Padding(
              padding: EdgeInsets.all(20.0.sp),
              child: CustomTextWidget(
                text:'List of verified centers near you',
                size:13.0.sp,
                weight: FontWeight.bold,
              ),
            ),
           Expanded(
             child: ListView.builder(
              itemCount: 20,
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
                  trailing: GestureDetector(
                    onTap: () {
                      Get.to(const BookAppointmentScreen());
                      //debugPrint('[BOOK-APPOINTMENT]');
                    },
                    child: CustomButton(
                      text: 'Book an Apointment',
                      borderRadius: 20,
                      fontColor: Colors.white,
                      backgroundColor: AppStyles.bgBlue,
                      fontSize: 8.0.sp,
                      onTapHandler: (){
                        Get.to(const BookAppointmentScreen());
                      },
                      fontWeight: FontWeight.bold,
                      height: 5.0.hp,
                      width: 35.0.wp,

                      )
                  ),
                );
              }),
           ),
           SizedBox(height: 2.0.hp,),
           CustomButton(
            text: 'Search for more centers', 
            width: 60.0.wp, 
            height: 6.0.hp, 
            onTapHandler: (){

            }, 
            fontSize: 12.0.sp, 
            fontColor: Colors.white, 
            fontWeight: FontWeight.bold, 
            borderRadius: 20, 
            backgroundColor: AppStyles.bgBlue)

      ],
        
    );
  }
}

