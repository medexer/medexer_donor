import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/auth/kyc/kyc_screen.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/text/custom_text_widget.dart';

class ThanksRegistrationScreen extends StatefulWidget {
 
  ThanksRegistrationScreen({super.key});

  @override
  State<ThanksRegistrationScreen> createState() =>_ThanksRegistrationScreenState();
}
class _ThanksRegistrationScreenState extends State<ThanksRegistrationScreen> {
  bool checkedIn=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Padding(
          padding: EdgeInsets.all(20.0.sp),
          child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 5.0.hp,),
                    Container(
                      width: 20.0.wp,
                      height: 25.0.hp,
                      child:Image.asset('assets/images/logo__1.png'), 
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0.hp),
                      child: CustomTextWidget(
                        text: 'Thanks for registering!',
                        weight: FontWeight.bold,
                        size: 13.0.sp,
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CustomTextWidget(
                        text: 'We will need you to tell us a few things about yourself, so we\'ll know how to help you on your blood donation journey!',
                        size: 13.0.sp,

                        ),
                    ),
                    SizedBox(height: 3.0.hp,),
                    Column(
                      children: [
                        Row(
                          children:  [
                            Checkbox(
                              value: checkedIn, 
                            onChanged: (newValue){
                                setState(() {
                                  checkedIn=newValue!;
                                });
                            }),
                            CustomTextWidget(
                              text: 'I have agreed to Medexer\'s' ,
                              size: 13.0.sp,
                              ),
                            
                          ],
                        ),
                        Row(
                          children: [
                            CustomTextWidget(
                              text: 'Usage of Data ',
                              size: 13.0.sp,
                              color: AppStyles.bgBlue,
                              weight: FontWeight.w300,
                            ),
                            CustomTextWidget(
                              text: 'and',
                              size: 13.0.sp,
                            ),
                            CustomTextWidget(
                              text: 'Terms of Use',
                              size: 13.0.sp,
                              color: AppStyles.bgBlue,
                              weight: FontWeight.w300,
                            ),
                          ],
                        )
                       
                      ],
                    ),
                    SizedBox(height: 10.0.hp,),
                    CustomButton(
                        text: 'Lets Do This', 
                        width: double.maxFinite,
                        height: 6.0.hp, 
                        fontSize: 15.0.sp, 
                        fontColor: Colors.white, 
                        fontWeight:FontWeight.normal, 
                        borderRadius: 20, 
                        backgroundColor: AppStyles.bgBlue, 
                        onTapHandler: (){
                          if(checkedIn=true){
                            Get.to(const KycScreen());
                          }
                          else{
                            return null;
                          }
                        },
                    ),
                        
               ],
             ),
        ),    
      ),
    );
  }
}

class CheckModal{
  String title;
  bool value;
  CheckModal({required this.title, this.value=false});

}
