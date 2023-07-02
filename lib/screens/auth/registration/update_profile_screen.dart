import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/data/index.dart';
import 'package:medexer_donor/services/auth_services.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/buttons/custom_select_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:medexer_donor/widgets/text/cutom_formtext_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final AuthServices authServices = Get.find();
  TextEditingController nationalityController =
      TextEditingController(text: "Nationality");
  TextEditingController genderController =
      TextEditingController(text: 'Gender');
  TextEditingController religionController =
      TextEditingController(text: 'Religion');
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController(text: 'State');
  TextEditingController cityProvinceController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            authServices.authRequestStatus.value == 'PENDING'
                ? const CircularProgressIndicator()
                : CustomButton(
                    text: 'Submit',
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 6.0.hp,
                    onTapHandler: () async {
                      if (!nationalityController.text.trim().isNotEmpty ||
                          !genderController.text.trim().isNotEmpty ||
                          !religionController.text.trim().isNotEmpty ||
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
                          "religion": religionController.text.trim(),
                          "address": addressController.text.trim(),
                          "state": stateController.text.trim(),
                          "city_province": cityProvinceController.text.trim(),
                          "contact_number": contactNumberController.text.trim(),
                        };

                        debugPrint('[UPDATE-PROFILE-DTO] :: $data');
                        await authServices.updateSignupProfileController(
                          data,
                        );
                      }
                    },
                    fontSize: 12.0.sp,
                    borderRadius: 5,
                    fontColor: Colors.white,
                    fontWeight: FontWeight.bold,
                    backgroundColor: AppStyles.bgPrimary,
                  ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: AppLayout.getHeight(50),
              horizontal: AppLayout.getWidth(40),
            ),
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                Center(
                  child: CustomTextWidget(
                    text: 'Update Profile',
                    // size: 20.0.sp,
                    weight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.0.hp),
                CustomSelectButton(
                  title: 'Nationality',
                  height: 65.0.hp,
                  textColor: AppStyles.bgBlack,
                  items: appCountries,
                  currentItem: nationalityController.text.toString(),
                  onChangeHandler: (int index) {
                    setState(() {
                      nationalityController.text = appCountries[index]['name'];
                    });
                  },
                ),
                SizedBox(height: 1.0.hp),
                CustomSelectButton(
                  title: 'Gender',
                  height: 30.0.hp,
                  textColor: AppStyles.bgBlack,
                  items: appGenders,
                  currentItem: genderController.text.toString(),
                  onChangeHandler: (int index) {
                    setState(() {
                      genderController.text = appGenders[index]['name'];
                    });
                  },
                ),
                SizedBox(height: 1.0.hp),
                CustomSelectButton(
                  title: 'Religion',
                  height: 30.0.hp,
                  textColor: AppStyles.bgBlack,
                  items: appReligions,
                  currentItem: religionController.text.toString(),
                  onChangeHandler: (int index) {
                    setState(() {
                      religionController.text = appReligions[index]['name'];
                    });
                  },
                ),
                SizedBox(height: 1.0.hp),
                CustomFormTextField(
                  maxLines: 1,
                  hintText: 'Address',
                  controller: addressController,
                  textColor: AppStyles.bgBlack,
                  background: Colors.white.withOpacity(0.4),
                  hintColor: Colors.black,
                ),
                SizedBox(height: 1.0.hp),
                CustomSelectButton(
                  title: 'State',
                  height: 65.0.hp,
                  items: appStates,
                  textColor: AppStyles.bgBlack,
                  currentItem: stateController.text.toString(),
                  onChangeHandler: (int index) {
                    setState(() {
                      stateController.text = appStates[index]['name'];
                    });
                  },
                ),
                SizedBox(height: 1.0.hp),
                CustomFormTextField(
                  maxLines: 1,
                  hintText: 'City/Province',
                  controller: cityProvinceController,
                  textColor: AppStyles.bgBlack,
                  background: Colors.white.withOpacity(0.4),
                  hintColor: Colors.black,
                ),
                SizedBox(height: 1.0.hp),
                CustomFormTextField(
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  hintText: 'Phone number',
                  textColor: AppStyles.bgBlack,
                  controller: contactNumberController,
                  background: Colors.white.withOpacity(0.4),
                  hintColor: Colors.black,
                ),
                SizedBox(height: 2.0.hp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
