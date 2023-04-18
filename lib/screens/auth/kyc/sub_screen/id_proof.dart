import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../database/user_repository.dart';
import '../../../../services/auth_services.dart';
import '../../../../widgets/snackbars/custom_snackbar_container.dart';

class IdProofScreen extends StatefulWidget {
  const IdProofScreen({super.key});

  @override
  State<IdProofScreen> createState() => _IdProofScreenState();
}

class _IdProofScreenState extends State<IdProofScreen> {
  final AuthServices authServices = Get.find();
    final UserRepository userRepository = Get.find();
  TextEditingController identificationTypeController = TextEditingController();
  
 File? _image;
  final picker = ImagePicker();
  late File file;
  
  Future getImage()async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, maxHeight: 240, maxWidth: 240);
    // String url = base64.encode(File(pickedFile!.path).readAsBytesSync().toList());
      setState(() {
      // ignore: unnecessary_null_comparison
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Get.snackbar('Error', 'Please Provide Image');
      }
    });
}


Future<void> kycHandler() async {
    if (!identificationTypeController.text.trim().isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomSnackbarContainer(
            backgroundType: '',
            title: 'Info',
            description:
                'Please ensure your fill in all fields\n in the form as the are required.',
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      );
    } else {
      // Map data = {
      //  // userRepository.kycFormData.addAll(other)
      //   //"documentUploadCover":_image!=null?base64.encode(File(pickedFile!.path).readAsBytesSync().toList()):'',
      //   "identificationType":identificationTypeController.text.trim(),
      //   // "documentUploadRear":await MultipartFile..fromFile(_image?.path,
      //   //   fileName:_image.path.split('/').last ?? _image
      //   // )
      // };
      } 

      //debugPrint('[SIGNUP DTO] :: $data');
      
    
      debugPrint('[ERROR] :: ${authServices.authRequestError.value}');

      
      if (authServices.authRequestStatus.value == 'SUCCESS') {
        setState(() {
          authServices.authLoading.value = false;
          authServices.authRequestError.value = '';
          authServices.authRequestStatus.value = '';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const CustomSnackbarContainer(
              backgroundType: 'SUCCESS',
              title: 'Success',
              description:
                  'Registration successful, please refer to your phone number for your account verification OTP.',
            ),
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            backgroundColor: Colors.transparent,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 150,
            ),
          ),
        );

        setState(() {
          // bloodGroupController.clear();
          // genotypeController.clear();
          // donatedBloodController.clear();
          // lastTimeController.clear();
          // tattoosController.clear();
      });
    }
  }
  
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
                          fontColor: AppStyles.bgBlack, 
                          fontWeight: FontWeight.w300, 
                          borderRadius: 20, 
                          borderColor: AppStyles.bgBlue,
                          backgroundColor: Colors.white,
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
                                          onPressed: (){
                                            getImage();
                                          }, 
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
                                          onPressed: (){
                                            getImage();
                                            }, 
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
                        _image!=null?Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Image.file(
                              _image!, width:100, height: 100,)
                              ),
                        ):const Text('Select Image from Gallary '),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(4.0.wp),
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
                                padding: EdgeInsets.all(4.0.wp),
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