// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/screens/home/donation_center/donation_center_search_profile_screen.dart';
import 'package:medexer_donor/screens/home/donation_center/hospital_map_donation_center_profile_screen.dart';
import 'package:medexer_donor/services/donor_services.dart';
import 'package:medexer_donor/widgets/text/custom_search_widget.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

import '../../network_services/network_error_message.dart';
import '../../network_services/network_manager.dart';

class SearchDonationCentersScreen extends StatefulWidget {
  const SearchDonationCentersScreen({super.key});

  @override
  State<SearchDonationCentersScreen> createState() =>
      _SearchDonationCentersScreenState();
}

class _SearchDonationCentersScreenState
    extends State<SearchDonationCentersScreen> {
  bool focusKeyboard = false;
  final DonorServices donorServices = Get.find();
  final UserRepository userRepository = Get.find();
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  final NetworkManageController _networkManageController =
      Get.find<NetworkManageController>();

  @override
  void initState() {
    super.initState();

    userRepository.searchResults.clear();
    setState(() {
      focusKeyboard = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => (_networkManageController.connectionType.value == 0)
              ? const NetworkErrorMessage()
              : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
                    height: screenHeight,
                    child: Column(
                      children: [
                        SizedBox(height: 1.0.hp),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: ClipOval(
                                child: Container(
                                  width: 4.0.hp,
                                  height: 4.0.hp,
                                  decoration: BoxDecoration(
                                    color: AppStyles.bgGray.withOpacity(0.2),
                                  ),
                                  child: Center(
                                    child: CustomTextWidget(
                                      text: 'x',
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 4.0.wp),
                            CustomTextWidget(
                              text: 'Search',
                              size: 16,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                        SizedBox(height: 2.0.hp),
                        CustomSearchField(
                          focusKeyboard: focusKeyboard,
                          hintText:
                              'Insert donation center address, or province(state)',
                          onChangeHandler: (String text) async {
                            debugPrint('[CURRENT-VALUE] :: ${text}');

                            await Future.delayed(Duration(milliseconds: 2500));

                            donorServices.searchDonationCentersController(text);
                          },
                          icon: 'assets/icons/icon__search.png',
                          // background: Colors.white.withOpacity(0.4),
                        ),
                        SizedBox(height: 2.0.hp),
                        userRepository.searchResults.isEmpty
                            ? Container(
                                child: Lottie.asset(
                                    'assets/animations/animation__4.json'),
                              )
                            : Container(
                                height: 40.0.hp,
                                child: ListView.builder(
                                    itemCount:
                                        userRepository.searchResults.length,
                                    itemBuilder: (_, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            () =>
                                                DonationCenterSearchProfileScreen(
                                              donationCenter: userRepository
                                                  .searchResults[index],
                                            ),
                                          );
                                        },
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: AppStyles.bgBlue,
                                            child: SvgPicture.asset(
                                              'assets/icons/icon__medical.svg',
                                              color: AppStyles.bgWhite,
                                            ),
                                          ),
                                          title: CustomTextWidget(
                                            text:
                                                '${userRepository.searchResults[index].hospitalName}',
                                            size: 14,
                                          ),
                                          subtitle: CustomTextWidget(
                                            text:
                                                '${userRepository.searchResults[index].centerAddress}',
                                            size: 12,
                                          ),
                                          trailing: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomTextWidget(
                                                text: 'Balance',
                                                size: 14,
                                              ),
                                              CustomTextWidget(
                                                text:
                                                    '${userRepository.searchResults[index].inventoryBalance} pints',
                                                size: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
