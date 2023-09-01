// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/services/auth_services.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/widgets/snackbars/custom_snackbar_container.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class IdProofScreen extends StatefulWidget {
  const IdProofScreen({super.key});

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
    debugPrint("[FILE] :: ${result.files[0].name}");
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String targetPath = '${appDocDir.path}/${result.files[0].name}';

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      "${result.files[0].path}",
      targetPath,
      quality: 15,
    );

    File newImage = File(compressedFile!.path);
    // PlatformFile platformFile=PlatformFile(name: 'peter.jpg', size: file!.lengthSync());
    PlatformFile platformFile = PlatformFile(
      name: "position.jpg",
      path: newImage.path,
      size: newImage.lengthSync(),
    );

    debugPrint("[FILE-SIZE] :: ${platformFile.toString()} ");
    debugPrint("[FILE-SIZE] :: ${platformFile.size} ");
    if (platformFile.size >= 500000) {
      Get.snackbar(
        'Error',
        'File uploaded should be less than 500kb.',
        colorText: Colors.white,
        backgroundColor: AppStyles.bgBlue,
      );
    } else {
      if (position == 'COVER') {
        setState(() {
          userRepository.kycPersonalData.value.isDocumentCoverUploaded = true;
          userRepository.kycPersonalData.value.documentCover = platformFile;
        });
      } else {
        setState(() {
          userRepository.kycPersonalData.value.isDocumentRearUploaded = true;
          userRepository.kycPersonalData.value.documentRear = platformFile;
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
    } else {}

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
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userRepository.kycPersonalData.value.identificationType = "Voter's Card";
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // bottomNavigationBar:
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            color: AppStyles.bgWhite,
            height: screenHeight * 0.8,
            margin: EdgeInsets.symmetric(horizontal: 2.0.wp),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                          textAlignment: TextAlign.center,
                          text: 'Voter\'s \n Card',
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.1,
                          onTapHandler: () {
                            setState(() {
                              // identificationType = "Voter's Card";
                              userRepository.kycPersonalData.value
                                  .identificationType = "Voter's Card";
                            });
                          },
                          fontSize: 14.0,
                          fontColor: userRepository.kycPersonalData.value
                                      .identificationType ==
                                  "Voter's Card"
                              ? AppStyles.bgWhite
                              : AppStyles.bgWhite,
                          fontWeight: FontWeight.w500,
                          borderRadius: 20,
                          backgroundColor: userRepository.kycPersonalData.value
                                      .identificationType ==
                                  "Voter's Card"
                              ? AppStyles.bgBlue
                              : AppStyles.bgBlack.withOpacity(0.3),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                          textAlignment: TextAlign.center,
                          text: 'National Identity \n Card',
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.1,
                          onTapHandler: () {
                            setState(() {
                              userRepository.kycPersonalData.value
                                      .identificationType =
                                  "National Identity Card";
                            });
                          },
                          fontSize: 10.0.sp,
                          fontColor: userRepository.kycPersonalData.value
                                      .identificationType ==
                                  "National Identity Card"
                              ? AppStyles.bgWhite
                              : AppStyles.bgWhite,
                          fontWeight: FontWeight.w500,
                          borderRadius: 20,
                          backgroundColor: userRepository.kycPersonalData.value
                                      .identificationType ==
                                  "National Identity Card"
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
                            'Upload or take a picture of your identity card preferrable on a plain background. Please ensure that the edges are visible.',
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
                                color: userRepository.kycPersonalData.value
                                            .isDocumentCoverUploaded ==
                                        true
                                    ? Colors.blueGrey.shade400
                                    : Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo_outlined,
                                      color: userRepository
                                                  .kycPersonalData
                                                  .value
                                                  .isDocumentCoverUploaded ==
                                              true
                                          ? AppStyles.bgWhite
                                          : AppStyles.bgBlue,
                                    ),
                                    SizedBox(height: 1.0.hp),
                                    CustomTextWidget(
                                      text: 'Front',
                                      size: 14.0,
                                      color: userRepository
                                                  .kycPersonalData
                                                  .value
                                                  .isDocumentCoverUploaded ==
                                              true
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
                                color: userRepository.kycPersonalData.value
                                            .isDocumentRearUploaded ==
                                        true
                                    ? Colors.blueGrey.shade400
                                    : Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo_outlined,
                                      color: userRepository
                                                  .kycPersonalData
                                                  .value
                                                  .isDocumentRearUploaded ==
                                              true
                                          ? AppStyles.bgWhite
                                          : AppStyles.bgBlue,
                                    ),
                                    SizedBox(height: 1.0.hp),
                                    CustomTextWidget(
                                      text: 'Back',
                                      size: 14.0,
                                      color: userRepository
                                                  .kycPersonalData
                                                  .value
                                                  .isDocumentRearUploaded ==
                                              true
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
          ),
        ),
      ),
    );
  }
}
