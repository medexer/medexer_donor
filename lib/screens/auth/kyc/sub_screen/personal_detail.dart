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
  String genotype;
  String hasTattos;
  String tobaccoUsage;
  String isRecentVaccineRecipient;
  String bloodGroup;
  String previouslyDonatedBlood;
  String previouslyDonatedBloodTimeline;
  PersonalDetailScreen({
    super.key,
    required this.genotype,
    required this.hasTattos,
    required this.tobaccoUsage,
    required this.isRecentVaccineRecipient,
    required this.bloodGroup,
    required this.previouslyDonatedBlood,
    required this.previouslyDonatedBloodTimeline,
  });

  @override
  State<PersonalDetailScreen> createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<PersonalDetailScreen> {
  // String genotype = '';
  // String hasTattos = '';
  // String tobaccoUsage = '';
  // String isRecentVaccineRecipient = '';
  // String bloodGroup = '';
  // String previouslyDonatedBlood = '';
  // String previouslyDonatedBloodTimeline = '';

  final UserRepository userRepository = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppStyles.bgWhite,
      body: SingleChildScrollView(
        child: Container(
          color: AppStyles.bgWhite,
          height: screenHeight * 0.85,
          padding: EdgeInsets.only(top: 1.0.hp),
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
                currentItem:
                    "${userRepository.kycPersonalData.value.bloodGroup ?? ""}",
                onChangeHandler: (int index) {
                  setState(() {
                    userRepository.kycPersonalData.value.bloodGroup =
                        appBloodGroups[index]['name'];
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
                currentItem:
                    "${userRepository.kycPersonalData.value.genotype ?? ""}",
                onChangeHandler: (int index) {
                  setState(() {
                    userRepository.kycPersonalData.value.genotype =
                        appGenotypes[index]['name'];
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
                currentItem:
                    "${userRepository.kycPersonalData.value.previouslyDonatedBlood ?? ""}",
                onChangeHandler: (int index) {
                  setState(() {
                    userRepository.kycPersonalData.value
                        .previouslyDonatedBlood = appAfirmations[index]['name'];
                  });
                },
              ),
              SizedBox(height: 2.0.hp),
              CustomTextWidget(
                text: 'If yes, when was the last time? (Optional)',
                size: 14,
              ),
              SizedBox(height: 0.5.hp),
              CustomBloodDonationTimelineButton(
                items: appBloodDonationTimeline,
                currentItem:
                    "${userRepository.kycPersonalData.value.previouslyDonatedBloodTimeline ?? ""}",
                onChangeHandler: (int index) {
                  setState(() {
                    userRepository.kycPersonalData.value
                            .previouslyDonatedBloodTimeline =
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
                currentItem:
                    "${userRepository.kycPersonalData.value.hasTattos ?? ""}",
                onChangeHandler: (int index) {
                  setState(() {
                    userRepository.kycPersonalData.value.hasTattos =
                        appAfirmations[index]['name'];
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
                currentItem:
                    "${userRepository.kycPersonalData.value.isRecentVaccineRecipient ?? ""}",
                onChangeHandler: (int index) {
                  setState(() {
                    userRepository
                            .kycPersonalData.value.isRecentVaccineRecipient =
                        appAfirmations[index]['name'];
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
                currentItem:
                    "${userRepository.kycPersonalData.value.tobaccoUsage ?? ""}",
                onChangeHandler: (int index) {
                  setState(() {
                    userRepository.kycPersonalData.value.tobaccoUsage =
                        appAfirmations[index]['name'];
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
