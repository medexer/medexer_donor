import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class IdProofScreen extends StatefulWidget {
  const IdProofScreen({super.key});

  @override
  State<IdProofScreen> createState() => _IdProofScreenState();
}

class _IdProofScreenState extends State<IdProofScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextWidget(
                text: 'Choose Document Type',
                color: AppStyles.bgBlack,
                weight: FontWeight.bold,
                size: 15.0.sp,
                ),
                SizedBox(height: 2.0.hp,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        text: 'Voter\'s Card', 
                        width: 35.0.wp, 
                        height:6.0.hp, 
                        onTapHandler: (){}, 
                        fontSize: 10.0.sp, 
                        fontColor: Colors.white, 
                        fontWeight: FontWeight.w300, 
                        borderRadius: 20, 
                        backgroundColor: AppStyles.bgBlue
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        text: 'Nationa Identity Card', 
                        width: 50.0.wp, 
                        height:6.0.hp, 
                        onTapHandler: (){}, 
                        fontSize: 10.0.sp, 
                        fontColor: Colors.white, 
                        fontWeight: FontWeight.w300, 
                        borderRadius: 20, 
                        backgroundColor: AppStyles.bgBlue,
                      ),
                    ),
                  ]
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextWidget(
                        text:'Take or upload a poto of your Voter\'s Card',
                        weight: FontWeight.bold,
                        color: AppStyles.bgBlack,
                        size: 10.0.sp, 
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0.wp),
                        child: CustomTextWidget(
                          text: 'Upload or take a picture of your Voter\'s Card preferrable on a plain background.\'nMake sure the edge are visible',
                          size:10.0.sp
                         ),
                      ),
                      SizedBox(height: 2.0.hp,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 40.0.wp,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)
                                ),
                                borderOnForeground: true,
                                shadowColor: Colors.grey,
                                elevation: 5,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                        IconButton(
                                          onPressed: (){}, 
                                          icon: Icon(Icons.add_a_photo_outlined, 
                                          color: AppStyles.bgBlue,
                                          ),
                                        ),
                                        CustomTextWidget(
                                          text: 'Front',
                                          color: AppStyles.bgBlack,
                                          size: 16.0.sp,
                                        ),
                                  ],
                                ),  
                              ),
                            ),
                            Container(
                              width: 40.0.wp,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)
                                ),
                                borderOnForeground: true,
                                shadowColor: Colors.grey,
                                elevation: 5,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                          IconButton(
                                          onPressed: (){}, 
                                          icon: Icon(Icons.add_a_photo_outlined, color: AppStyles.bgBlue,
                                          ),
                                        ),
                                        CustomTextWidget(
                                          text: 'Back',
                                          color: AppStyles.bgBlack,
                                          size: 16.0.sp,
                                          )
                                  ],
                                ),  
                              ),
                            ),
                          ]
                        ),
                        SizedBox(height: 10.0.hp,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0.wp),
                                child: CustomButton(
                                  text: 'Previous', 
                                  width: 30.0.wp, 
                                  height: 5.0.hp, 
                                  onTapHandler: (){}, 
                                  fontSize: 13.0.sp, 
                                  fontWeight: FontWeight.bold, 
                                  borderRadius: 5, 
                                  backgroundColor: AppStyles.bgBlue, fontColor: Colors.white,),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0.wp),
                                child: CustomButton(
                                  text: 'Submit', 
                                  width: 30.0.wp, 
                                  height: 5.0.hp, 
                                  onTapHandler: (){}, 
                                  fontSize: 13.0.sp, 
                                  fontWeight: FontWeight.bold, 
                                  borderRadius: 5, 
                                  backgroundColor: AppStyles.bgBlue, fontColor: Colors.white),
                              )
                        ],
                      )
                    ],
                  )
                ],
              )
        ),
    );
  }
}