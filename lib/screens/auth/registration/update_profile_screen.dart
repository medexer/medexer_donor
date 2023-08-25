import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/data/index.dart';
import 'package:medexer_donor/services/auth_services.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/buttons/custom_select_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/widgets/text/cutom_formtext_field.dart';
import 'package:medexer_donor/widgets/buttons/custom_date_picker_button.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final AuthServices authServices = Get.find();
  TextEditingController nationalityController =
      TextEditingController(text: "Nigerian");
  TextEditingController genderController =
      TextEditingController(text: 'Gender');
  // TextEditingController religionController =
  //     TextEditingController(text: 'Religion');
  TextEditingController dateOfBirthController =
      TextEditingController(text: "${DateTime(1985)}");
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController(text: 'State');
  TextEditingController cityProvinceController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  DateTime initialDate = DateTime(1985);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppStyles.bgWhite,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.02),
          color: AppStyles.bgWhite,
          child: Center(
            child: CustomTextWidget(
              text: 'Update Profile',
              size: 20.0,
              color: AppStyles.bgBlack,
              weight: FontWeight.w600,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              authServices.authRequestStatus.value == 'PENDING'
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      text: 'Submit',
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: screenHeight * 0.06,
                      onTapHandler: () async {
                        if (!nationalityController.text.trim().isNotEmpty ||
                            !genderController.text.trim().isNotEmpty ||
                            //!religionController.text.trim().isNotEmpty ||
                            !stateController.text.trim().isNotEmpty ||
                            !cityProvinceController.text.trim().isNotEmpty ||
                            !addressController.text.trim().isNotEmpty ||
                            !contactNumberController.text.trim().isNotEmpty) {
                          Get.snackbar(
                              colorText: AppStyles.bgWhite,
                              backgroundColor: AppStyles.bgBlue,
                              'ERROR',
                              'All fields are required.');
                        } else {
                          Map data = {
                            "nationality": nationalityController.text.trim(),
                            "gender": genderController.text.trim(),
                            //"religion": religionController.text.trim(),
                            "address": addressController.text.trim(),
                            "state": stateController.text.trim(),
                            "dateOfBirth": dateOfBirthController.text
                                .trim()
                                .substring(0, 10),
                            "city_province": cityProvinceController.text.trim(),
                            "contact_number":
                                contactNumberController.text.trim(),
                          };

                          debugPrint('[UPDATE-PROFILE-DTO] :: $data');
                          await authServices.updateSignupProfileController(
                            data,
                          );
                        }
                      },
                      fontSize: 14.0,
                      borderRadius: 15,
                      fontColor: Colors.white,
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
            padding: EdgeInsets.symmetric(
              // vertical: 2.0.hp,
              horizontal: 6.0.wp,
            ),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: 'Nationality',
                  size: 14.0,
                ),
                CustomFormTextField(
                  maxLines: 1,
                  readOnly: true,
                  fontSize: 14,
                  height: screenHeight * 0.06,
                  hintText: nationalityController.text,
                  controller: nationalityController,
                  textColor: AppStyles.bgBlack,
                  background: Colors.white.withOpacity(0.4),
                  hintColor: Colors.black,
                ),
                SizedBox(height: 2.0.hp),
                CustomTextWidget(
                  text: 'Gender',
                  size: 14.0,
                ),
                CustomSelectButton(
                  title: 'Gender',
                  height: screenHeight * 0.3,
                  textColor: AppStyles.bgBlack,
                  items: appGenders,
                  currentItem: genderController.text.toString(),
                  onChangeHandler: (int index) {
                    setState(() {
                      genderController.text = appGenders[index]['name'];
                    });
                  },
                ),
                SizedBox(height: 2.0.hp),
                // CustomTextWidget(
                //   text: 'Religion',
                //   size: 14.0,
                // ),
                // CustomSelectButton(
                //   title: 'Religion',
                //   height: screenHeight * 0.3,
                //   textColor: AppStyles.bgBlack,
                //   items: appReligions,
                //   currentItem: religionController.text.toString(),
                //   onChangeHandler: (int index) {
                //     setState(() {
                //       religionController.text = appReligions[index]['name'];
                //     });
                //   },
                // ),
                // SizedBox(height: 2.0.hp),
                CustomTextWidget(
                  text: 'Address',
                  size: 14.0,
                ),
                CustomFormTextField(
                  maxLines: 1,
                  hintText: 'Address',
                  fontSize: 14,
                  height: screenHeight * 0.06,
                  controller: addressController,
                  textColor: AppStyles.bgBlack,
                  background: Colors.white.withOpacity(0.4),
                  hintColor: Colors.black,
                ),
                SizedBox(height: 2.0.hp),
                CustomTextWidget(
                  text: 'State',
                  size: 14.0,
                ),
                CustomSelectButton(
                  title: 'State',
                  height: screenHeight * 0.5,
                  items: appStates,
                  textColor: AppStyles.bgBlack,
                  currentItem: stateController.text.toString(),
                  onChangeHandler: (int index) {
                    setState(() {
                      stateController.text = appStates[index]['name'];
                    });
                  },
                ),
                SizedBox(height: 2.0.hp),
                CustomTextWidget(
                  text: 'City/Province',
                  size: 14.0,
                ),
                CustomFormTextField(
                  maxLines: 1,
                  hintText: 'City/Province',
                  fontSize: 14,
                  height: screenHeight * 0.06,
                  controller: cityProvinceController,
                  textColor: AppStyles.bgBlack,
                  background: Colors.white.withOpacity(0.4),
                  hintColor: Colors.black,
                ),
                SizedBox(height: 2.0.hp),
                CustomTextWidget(
                  text: 'Phone Number',
                  size: 14.0,
                ),
                CustomFormTextField(
                  maxLines: 1,
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  hintText: 'Phone number',
                  fontSize: 14,
                  height: screenHeight * 0.06,
                  textColor: AppStyles.bgBlack,
                  controller: contactNumberController,
                  background: Colors.white.withOpacity(0.4),
                  hintColor: Colors.black,
                ),
                SizedBox(height: 2.0.hp),
                CustomTextWidget(
                  text: 'Date of Birth',
                  size: 14.0,
                ),
                CustomDatePickerButton(
                  date: initialDate,
                  borderRadius: 25,
                  height: screenHeight * 0.06,
                  controller: dateOfBirthController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
