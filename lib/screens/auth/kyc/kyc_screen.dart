// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/models/kyc_formdata_model.dart';
import 'package:medexer_donor/models/user_model.dart';
import 'package:medexer_donor/screens/auth/kyc/sub_screen/id_proof.dart';
import 'package:medexer_donor/screens/auth/kyc/sub_screen/personal_detail.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/services/auth_services.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:medexer_donor/models/kyc_personal_data_model.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final authStorage = GetStorage();
  final AuthServices authServices = Get.find();
  final UserRepository userRepository = Get.find();

  // PAYLOAD
  String genotype = '';
  String hasTattos = '';
  String tobaccoUsage = '';
  String isRecentVaccineRecipient = '';
  String bloodGroup = '';
  String previouslyDonatedBlood = '';
  String previouslyDonatedBloodTimeline = '';

  TabController? tabController;
  late PlatformFile documentRear;
  late PlatformFile documentCover;
  bool isDocumentRearUploaded = false;
  bool isDocumentCoverUploaded = false;
  String identificationType = "Voter's Card";

  String currentPage = "ONE";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userRepository.kycPersonalData.value = KYCPersonalDataModel.fromJson({});
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        authStorage.remove('MDX-USER');

        userRepository.userData.value = UserModel.fromJson({});

        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppStyles.bgWhite,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.05),
                color: AppStyles.bgWhite,
                child: Center(
                  child: CustomTextWidget(
                    text: 'Upload KYC',
                    size: 20,
                    color: AppStyles.bgBlack,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.008),
              TabBar(
                labelColor: AppStyles.bgWhite,
                unselectedLabelColor: AppStyles.bgBlack,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppStyles.bgPrimary,
                ),
                indicatorColor: AppStyles.bgPrimary,
                controller: tabController,
                isScrollable: false,
                tabs: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      // border: Border.all(color: AppStyles.bgBlue, width: 1),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 1.0.hp),
                    child: CustomTextWidget(
                      text: "Personal Details",
                      // color: AppStyles.bgWhite,
                      size: 14,
                      weight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      // border: Border.all(color: AppStyles.bgBlue, width: 1),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 1.0.hp),
                    child: CustomTextWidget(
                      text: "ID Proof",
                      // color: AppStyles.bgWhite,
                      size: 14,
                      weight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: currentPage == "ONE"
            ? Container(
                height: screenHeight * 0.08,
                color: AppStyles.bgWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomButton(
                      text: 'Next',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.06,
                      onTapHandler: () async {
                        print(
                            "[PAYLOAD]  ::  ${userRepository.kycPersonalData.value.tobaccoUsage}");
                        if (userRepository.kycPersonalData.value.tobaccoUsage ==
                            null) {
                          Get.snackbar(
                            'Error',
                            'Please affirm if you smoke or not.',
                            colorText: Colors.white,
                            backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
                          );
                        } else if (userRepository.kycPersonalData.value
                                .isRecentVaccineRecipient ==
                            null) {
                          Get.snackbar(
                            'Error',
                            'Please affirm if you have been vaccinated recently or not.',
                            colorText: Colors.white,
                            backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
                          );
                        } else if (userRepository
                                .kycPersonalData.value.previouslyDonatedBlood ==
                            null) {
                          Get.snackbar(
                            'Error',
                            'Blood donation history is required.',
                            colorText: Colors.white,
                            backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
                          );
                        } else if (userRepository
                                .kycPersonalData.value.hasTattos ==
                            null) {
                          Get.snackbar(
                            'Error',
                            'Please validation is you have tattoos.',
                            colorText: Colors.white,
                            backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
                          );
                        } else {
                          Map<String, dynamic> formData = {
                            'bloodGroup': userRepository
                                    .kycPersonalData.value.bloodGroup ??
                                "",
                            'genotype':
                                userRepository.kycPersonalData.value.genotype ??
                                    "",
                            'haveDonatedBlood': userRepository.kycPersonalData
                                        .value.previouslyDonatedBlood ==
                                    'YES'
                                ? true
                                : false,
                            'lastBloodDonationTime': userRepository
                                    .kycPersonalData
                                    .value
                                    .previouslyDonatedBloodTimeline ??
                                "",
                            'hasTattos': userRepository
                                        .kycPersonalData.value.hasTattos ==
                                    'YES'
                                ? true
                                : false,
                            'tobaccoUsage': userRepository
                                        .kycPersonalData.value.tobaccoUsage ==
                                    'YES'
                                ? true
                                : false,
                            'isRecentVaccineRecipient': userRepository
                                        .kycPersonalData
                                        .value
                                        .isRecentVaccineRecipient ==
                                    'YES'
                                ? true
                                : false,
                          };

                          userRepository.kycFormData.value =
                              KYCFormDataModel.fromJson(formData);

                          setState(() {
                            currentPage = "TWO";
                            tabController?.animateTo(1);
                          });
                        }
                      },
                      fontSize: 16.0,
                      borderRadius: 15,
                      fontColor: AppStyles.bgWhite,
                      fontWeight: FontWeight.bold,
                      backgroundColor: AppStyles.bgPrimary,
                    ),
                  ],
                ),
              )
            : Container(
                height: screenHeight * 0.08,
                color: AppStyles.bgWhite,
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
                              height: screenHeight * 0.06,
                              onTapHandler: () async {
                                if (userRepository.kycPersonalData.value
                                        .isDocumentCoverUploaded ==
                                    false) {
                                  Get.snackbar(
                                    'Error',
                                    'Document cover is required',
                                    colorText: Colors.white,
                                    backgroundColor:
                                        AppStyles.bgBlue.withOpacity(0.8),
                                  );
                                }
                                if (userRepository.kycPersonalData.value
                                        .isDocumentRearUploaded ==
                                    false) {
                                  Get.snackbar(
                                    'Error',
                                    'Document rear is required',
                                    colorText: Colors.white,
                                    backgroundColor:
                                        AppStyles.bgBlue.withOpacity(0.8),
                                  );
                                }

                                Map formData = {
                                  'bloodGroup': userRepository
                                      .kycFormData.value.bloodGroup,
                                  'genotype':
                                      userRepository.kycFormData.value.genotype,
                                  'haveDonatedBlood': userRepository
                                      .kycFormData.value.haveDonatedBlood,
                                  'lastBloodDonationTime': userRepository
                                      .kycFormData.value.lastBloodDonationTime,
                                  'hasTattos': userRepository
                                      .kycFormData.value.hasTattos,
                                  'tobaccoUsage': userRepository
                                      .kycFormData.value.tobaccoUsage,
                                  'isRecentVaccineRecipient': userRepository
                                      .kycFormData
                                      .value
                                      .isRecentVaccineRecipient,
                                  'documentUploadRear': userRepository
                                      .kycPersonalData.value.documentRear,
                                  'documentUploadCover': userRepository
                                      .kycPersonalData.value.documentCover,
                                  'identificationType': userRepository
                                              .kycPersonalData
                                              .value
                                              .identificationType ==
                                          "Voter's Card"
                                      ? 'VOTERCARD'
                                      : 'NATIONALIDENTITYCARD',
                                };

                                await authServices
                                    .kycCaptureController(formData);
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight * 0.85,
                    padding: EdgeInsets.only(top: 2.0.hp),
                    color: AppStyles.bgWhite,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [
                        PersonalDetailScreen(
                          genotype: genotype,
                          hasTattos: hasTattos,
                          tobaccoUsage: tobaccoUsage,
                          isRecentVaccineRecipient: isRecentVaccineRecipient,
                          bloodGroup: bloodGroup,
                          previouslyDonatedBlood: previouslyDonatedBlood,
                          previouslyDonatedBloodTimeline:
                              previouslyDonatedBloodTimeline,
                        ),
                        IdProofScreen(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            //   ),
          ),
        ),
      ),
    );
  }
}
