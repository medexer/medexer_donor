// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

//import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import '../../../network_services/network_error_message.dart';
import '../../../network_services/network_manager.dart';
import '../../../widgets/text/custom_text_widget.dart';

class RewardsWalletScreen extends StatefulWidget {
  const RewardsWalletScreen({super.key});

  @override
  State<RewardsWalletScreen> createState() => _RewardsWalletScreenState();
}

class _RewardsWalletScreenState extends State<RewardsWalletScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final NetworkManageController _networkManageController = Get.find<NetworkManageController>();

  final List<String> walletList = [
    "hospital1",
    "hospital1",
    "hospital1",
    "hospital1"
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        key: scaffoldKey,
        drawer: SideBar(),
        body: Obx(()=>(_networkManageController.connectionType.value == 0)?const NetworkErrorMessage():
           SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          color: AppStyles.bgBlue,
                          height: 40.0.hp,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 3.0.hp,
                                ),
                                PageHeader(scaffoldKey: scaffoldKey),
                                SizedBox(
                                  height: 15.0.hp,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 9.0.wp),
                                  child: CustomTextWidget(
                                    text: 'Your Balance:',
                                    size: 15.0.sp,
                                    color: Colors.white,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 32.0.hp, left: 9.0.wp),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 20,
                              shadowColor: Colors.black,
                              color: Colors.white,
                              child: SizedBox(
                                width: 80.0.wp,
                                height: 15.0.hp,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomTextWidget(
                                            text: 'TOTAL',
                                            size: 12.0.sp,
                                            weight: FontWeight.bold,
                                          ),
                                          CustomTextWidget(
                                            text: '5,000',
                                            size: 15.0.sp,
                                            weight: FontWeight.bold,
                                          ),
                                          CustomTextWidget(
                                            text: 'point',
                                            size: 8.0.sp,
                                            weight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 3.0, left: 20.0.wp),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomButton(
                                                text: 'Redeem points in cash',
                                                width: 40.0.wp,
                                                height: 5.0.hp,
                                                onTapHandler: () {},
                                                fontSize: 7.0.sp,
                                                fontColor: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                borderRadius: 30,
                                                backgroundColor:
                                                    Colors.lightGreen),
                                            CustomButton(
                                                text: 'Redeem points in souvenir',
                                                width: 40.0.wp,
                                                height: 5.0.hp,
                                                onTapHandler: () {},
                                                fontSize: 7.0.sp,
                                                fontColor: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                borderRadius: 30,
                                                backgroundColor:
                                                    Colors.lightGreen)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.0.wp, top: 5.0.hp),
                      child: Column(
                        children: [
                          CustomTextWidget(
                            text: 'Reward History',
                            weight: FontWeight.bold,
                            size: 15.0.sp,
                            color: AppStyles.bgBlack,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (_, index) => Column(children: [
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                leading: SvgPicture.asset(
                                  'assets/icons/icon__building.svg',
                                  color: AppStyles.bgPrimary,
                                ),
                                title: CustomTextWidget(
                                  text: 'Hospital ${index + 1}',
                                  size: 12.0.sp,
                                ),
                                subtitle: CustomTextWidget(
                                  text: 'No 1. Lorem Impsum Street...',
                                  size: 8.0.sp,
                                ),
                                trailing: CustomTextWidget(
                                  text: 'Book appointment',
                                  color: Colors.white,
                                  size: 6.0.sp,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CustomTextWidget(
                                    text: '1500',
                                    color: Colors.lightGreen,
                                  ),
                                  CustomTextWidget(
                                    text: 'claimed',
                                    size: 10.0.sp,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider()
                      ]),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
