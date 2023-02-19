// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  String? icon;
  ImageIcon? prefixIcon;
  TextEditingController? controller;
  TextInputType? keyboardType;
  CustomSearchField({
    super.key,
    this.icon,
    this.prefixIcon,
    this.controller,
    this.keyboardType,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      // width: double.maxFinite,
      height: 6.0.hp,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppStyles.bgGray,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            child: ImageIcon(
              AssetImage("$icon"),
            ),
          ),
          SizedBox(
            width: 35.0.wp,
            child: TextFormField(
              controller: controller ?? controller,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: keyboardType ?? TextInputType.multiline,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                contentPadding: EdgeInsets.all(15),
                // prefixIcon: prefixIcon ?? prefixIcon,
                hintStyle: TextStyle(
                  color: AppStyles.bgGray,
                ),
              ),
              style: TextStyle(
                color: AppStyles.bgBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
