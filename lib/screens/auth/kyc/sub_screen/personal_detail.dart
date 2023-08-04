import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/data/index.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/models/kyc_formdata_model.dart';
import 'package:medexer_donor/widgets/buttons/custom_affirmation_button.dart';
import 'package:medexer_donor/widgets/buttons/custom_blood_donation_timeline_button.dart';
import 'package:medexer_donor/widgets/buttons/custom_bloodgroup_button.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/buttons/custom_genotype_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class PersonalDetailScreen extends StatefulWidget {
  final TabController tabController;
  const PersonalDetailScreen({super.key, required this.tabController});

  @override
  State<PersonalDetailScreen> createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<PersonalDetailScreen> {
  String genotype = '';
  String hasTattos = '';
  String tobaccoUsage = '';
  String isRecentVaccineRecipient = '';
  String bloodGroup = '';
  String previouslyDonatedBlood = '';
  String previouslyDonatedBloodTimeline = '';

  final UserRepository userRepository = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: Container(
        height: screenHeight * 0.12,
        color: AppStyles.bgWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
              text: 'Next',
              width: screenWidth * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              onTapHandler: () async {
                if (tobaccoUsage == '') {
                  Get.snackbar(
                    'Error',
                    'Please affirm if you smoke or not.',
                    colorText: Colors.white,
                    backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
                  );
                } else if (isRecentVaccineRecipient == '') {
                  Get.snackbar(
                    'Error',
                    'Please affirm if you have been vaccinated recently or not.',
                    colorText: Colors.white,
                    backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
                  );
                } else if (previouslyDonatedBlood == '') {
                  Get.snackbar(
                    'Error',
                    'Blood donation history is required.',
                    colorText: Colors.white,
                    backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
                  );
                } else if (hasTattos == '') {
                  Get.snackbar(
                    'Error',
                    'Please validation is you have tattoos.',
                    colorText: Colors.white,
                    backgroundColor: AppStyles.bgBlue.withOpacity(0.8),
                  );
                } else {
                  Map<String, dynamic> formData = {
                    'bloodGroup': bloodGroup,
                    'genotype': genotype,
                    'haveDonatedBlood':
                        previouslyDonatedBlood == 'YES' ? true : false,
                    'lastBloodDonationTime': previouslyDonatedBloodTimeline,
                    'hasTattos': hasTattos == 'YES' ? true : false,
                    'tobaccoUsage': tobaccoUsage == 'YES' ? true : false,
                    'isRecentVaccineRecipient':
                        isRecentVaccineRecipient == 'YES' ? true : false,
                  };

                  userRepository.kycFormData.value =
                      KYCFormDataModel.fromJson(formData);

                  widget.tabController.animateTo(1);
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
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          margin: EdgeInsets.symmetric(horizontal: 4.0.wp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: 'What is your blood group? (Optional)',
                size: 14,
              ),
              SizedBox(height: 0.5.hp),
              CustomBloodGroupButton(
                items: appBloodGroups,
                currentItem: bloodGroup,
                onChangeHandler: (int index) {
                  setState(() {
                    bloodGroup = appBloodGroups[index]['name'];
                  });
                },
              ),
              SizedBox(height: 2.0.hp),
              CustomTextWidget(
                text: 'What is your genotype? (Optional)',
                size: 14,
              ),
              SizedBox(height: 0.5.hp),
              CustomGenotypeButton(
                items: appGenotypes,
                currentItem: genotype,
                onChangeHandler: (int index) {
                  setState(() {
                    genotype = appGenotypes[index]['name'];
                  });
                },
              ),
              SizedBox(height: 2.0.hp),
              CustomTextWidget(
                text: 'Have you ever donated blood before?',
                size: 14,
              ),
              SizedBox(height: 0.5.hp),
              CustomAffirmationButton(
                title: 'Have you ever donated blood before?',
                items: appAfirmations,
                currentItem: previouslyDonatedBlood,
                onChangeHandler: (int index) {
                  setState(() {
                    previouslyDonatedBlood = appAfirmations[index]['name'];
                  });
                },
              ),
              SizedBox(height: 2.0.hp),
              CustomTextWidget(
                text: 'If yes, when was the last time?',
                size: 14,
              ),
              SizedBox(height: 0.5.hp),
              CustomBloodDonationTimelineButton(
                items: appBloodDonationTimeline,
                currentItem: previouslyDonatedBloodTimeline,
                onChangeHandler: (int index) {
                  setState(() {
                    previouslyDonatedBloodTimeline =
                        appBloodDonationTimeline[index]['name'];
                  });
                },
              ),
              SizedBox(height: 2.0.hp),
              CustomTextWidget(
                text: 'Do you have any tattoos?',
                size: 14,
              ),
              SizedBox(height: 0.5.hp),
              CustomAffirmationButton(
                title: 'Do you have any tattos?',
                items: appAfirmations,
                currentItem: hasTattos,
                onChangeHandler: (int index) {
                  setState(() {
                    hasTattos = appAfirmations[index]['name'];
                  });
                },
              ),
              SizedBox(height: 2.0.hp),
              CustomTextWidget(
                text: 'Have you been vaccinated in the last 3months?',
                size: 14,
              ),
              SizedBox(height: 0.5.hp),
              CustomAffirmationButton(
                title: 'Have you been vaccinated in the last 3months?',
                items: appAfirmations,
                currentItem: isRecentVaccineRecipient,
                onChangeHandler: (int index) {
                  setState(() {
                    isRecentVaccineRecipient = appAfirmations[index]['name'];
                  });
                },
              ),
              SizedBox(height: 2.0.hp),
              CustomTextWidget(
                text: 'Do you smoke?',
                size: 14,
              ),
              SizedBox(height: 0.5.hp),
              CustomAffirmationButton(
                title: 'Do you smoke?',
                items: appAfirmations,
                currentItem: tobaccoUsage,
                onChangeHandler: (int index) {
                  setState(() {
                    tobaccoUsage = appAfirmations[index]['name'];
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
