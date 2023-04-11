// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

import '../../config/app_config.dart';
class CustomSnackbarContainer extends StatelessWidget {
  final String title;
  final String description;
  final String backgroundType;
  const CustomSnackbarContainer({
    Key? key,
    required this.title,
    required this.description,
    required this.backgroundType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 90,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundType == 'ERROR'
                  ? Color(0xFFC72C41)
                  : backgroundType == 'SUCCESS'
                      ? Color.fromARGB(255, 119, 199, 44)
                      : AppStyles.bgPrimary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                SizedBox(width: 48),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: title,
                        color: Colors.white,
                        size: 16.0.sp,
                        weight: FontWeight.w600,
                      ),
                      Spacer(),
                      CustomTextWidget(
                        text: description,
                        color: Colors.white,
                        size: 12.0.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
              child: SvgPicture.asset(
                'assets/icons/bubbles.svg',
                height: 48,
                width: 40,
                color: backgroundType == 'ERROR'
                    ? Color(0xFF801336)
                    : backgroundType == 'SUCCESS'
                        ? Color.fromARGB(255, 41, 128, 19)
                        : Color.fromARGB(255, 19, 33, 128),
              ),
            ),
          ),
          Positioned(
            top: -12,
            left: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/fail.svg',
                  height: 40,
                  color: backgroundType == 'ERROR'
                      ? Color(0xFF801336)
                      : backgroundType == 'SUCCESS'
                          ? Color.fromARGB(255, 41, 128, 19)
                          : Color.fromARGB(255, 19, 33, 128),
                ),
                Positioned(
                  top: 10,
                  child: SvgPicture.asset(
                    'assets/icons/close.svg',
                    height: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
