// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/services/auth_services.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/widgets/snackbars/custom_snackbar_container.dart';

class IdProofScreen extends StatefulWidget {
  final TabController tabController;
  const IdProofScreen({
    super.key,
    required this.tabController,
  });

  @override
  State<IdProofScreen> createState() => _IdProofScreenState();
}

class _IdProofScreenState extends State<IdProofScreen> {
  late PlatformFile documentRear;
  late PlatformFile documentCover;
  bool isDocumentRearUploaded = false;
  bool isDocumentCoverUploaded = false;
  String identificationType = "Voter's Card";

  final AuthServices authServices = Get.find();
  final UserRepository userRepository = Get.find();
  TextEditingController identificationTypeController = TextEditingController();

  Future handleFileChange(String position) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
      ],
    );

    if (result!.files.isEmpty) return;

    debugPrint("${result.files[0].path} :: file path ");
    if (result.files[0].size >= 500000) {
      Get.snackbar(
        'Error',
        'File uploaded should be less than 500kb.',
        colorText: Colors.white,
        backgroundColor: AppStyles.bgBlue,
      );
    } else {
      if (position == 'COVER') {
        setState(() {
          isDocumentCoverUploaded = true;
          documentCover = result.files[0];
        });
      } else {
        setState(() {
          isDocumentRearUploaded = true;
          documentRear = result.files[0];
        });
      }
    }
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: screenHeight * 0.08,
        // color: Colors.amber,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              authServices.authRequestStatus.value == 'PENDING'
                  ? CircularProgressIndicator()
                  : CustomButton(
                      text: 'Submit',
                      width: screenWidth * 0.9,
                      height: 6.0.hp,
                      onTapHandler: () async {
                        if (!isDocumentCoverUploaded) {
                          Get.snackbar(
                            'Error',
                            'Document cover is required',
                            colorText: Colors.white,
                            backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
                          );
                        }
                        if (!isDocumentRearUploaded) {
                          Get.snackbar(
                            'Error',
                            'Document rear is required',
                            colorText: Colors.white,
                            backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
                          );
                        }

                        Map formData = {
                          'bloodGroup':
                              userRepository.kycFormData.value.bloodGroup,
                          'genotype': userRepository.kycFormData.value.genotype,
                          'haveDonatedBlood':
                              userRepository.kycFormData.value.haveDonatedBlood,
                          'lastBloodDonationTime': userRepository
                              .kycFormData.value.lastBloodDonationTime,
                          'hasTattos':
                              userRepository.kycFormData.value.hasTattos,
                          'tobaccoUsage':
                              userRepository.kycFormData.value.tobaccoUsage,
                          'isRecentVaccineRecipient': userRepository
                              .kycFormData.value.isRecentVaccineRecipient,
                          'documentUploadRear': documentRear,
                          'documentUploadCover': documentCover,
                          'identificationType':
                              identificationType == "Voter's Card"
                                  ? 'VOTERCARD'
                                  : 'NATIONALIDENTITYCARD',
                        };

                        await authServices.kycCaptureController(formData);
                      },
                      fontSize: 16.0,
                      borderRadius: 15,
                      fontColor: AppStyles.bgWhite,
                      fontWeight: FontWeight.bold,
                      backgroundColor: AppStyles.bgPrimary,
                    ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        color: AppStyles.bgWhite,
        margin: EdgeInsets.symmetric(horizontal: 2.0.wp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      text: 'Voter\'s Card',
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.1,
                      onTapHandler: () {
                        setState(() {
                          identificationType = "Voter's Card";
                        });
                      },
                      fontSize: 14.0,
                      fontColor: identificationType == "Voter's Card"
                          ? AppStyles.bgWhite
                          : AppStyles.bgWhite,
                      fontWeight: FontWeight.w500,
                      borderRadius: 20,
                      backgroundColor: identificationType == "Voter's Card"
                          ? AppStyles.bgBlue
                          : AppStyles.bgBlack.withOpacity(0.3),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      text: 'National Identity Card',
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.1,
                      onTapHandler: () {
                        setState(() {
                          identificationType = "National Identity Card";
                        });
                      },
                      fontSize: 10.0.sp,
                      fontColor: identificationType == "National Identity Card"
                          ? AppStyles.bgWhite
                          : AppStyles.bgWhite,
                      fontWeight: FontWeight.w500,
                      borderRadius: 20,
                      backgroundColor:
                          identificationType == "National Identity Card"
                              ? AppStyles.bgBlue
                              : AppStyles.bgBlack.withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 4.0.hp),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                  child: CustomTextWidget(
                    text:
                        'Upload or take a picture of your identity card preferrable on a plain background. Make sure the edge are visible and file is less than 500kb.',
                    size: 16.0,
                    color: AppStyles.bgBlack.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 4.0.hp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          handleFileChange('COVER');
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            borderOnForeground: true,
                            shadowColor: Colors.grey.withOpacity(0.3),
                            elevation: 10,
                            color: isDocumentCoverUploaded
                                ? Colors.blueGrey.shade400
                                : Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  color: isDocumentCoverUploaded
                                      ? AppStyles.bgWhite
                                      : AppStyles.bgBlue,
                                ),
                                SizedBox(height: 1.0.hp),
                                CustomTextWidget(
                                  text: 'Front',
                                  size: 14.0,
                                  color: isDocumentCoverUploaded
                                      ? AppStyles.bgWhite
                                      : AppStyles.bgBlack,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          handleFileChange('REAR');
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            borderOnForeground: true,
                            shadowColor: Colors.grey.withOpacity(0.3),
                            elevation: 5,
                            color: isDocumentRearUploaded
                                ? Colors.blueGrey.shade400
                                : Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  color: isDocumentRearUploaded
                                      ? AppStyles.bgWhite
                                      : AppStyles.bgBlue,
                                ),
                                SizedBox(height: 1.0.hp),
                                CustomTextWidget(
                                  text: 'Back',
                                  size: 14.0,
                                  color: isDocumentRearUploaded
                                      ? AppStyles.bgWhite
                                      : AppStyles.bgBlack,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
