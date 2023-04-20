// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';

class CustomFormTextField extends StatelessWidget {
  final String hintText;
  // ignore: prefer_typing_uninitialized_variables
  var maxLines;
  Color? background;
  Color? hintColor;
  ImageIcon? prefixIcon;
  TextEditingController? controller;
  TextInputType? keyboardType;
  CustomFormTextField({
    super.key,
    this.prefixIcon,
    this.background,
    this.controller,
    this.keyboardType,
    required this.maxLines,
    required this.hintText,
    required this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 6.0.hp,
      decoration: BoxDecoration(
        color: background ?? background,
        border: Border.all(
          color: AppStyles.bgGray,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        maxLines: maxLines,
        controller: controller ?? controller,
        keyboardType: keyboardType ?? TextInputType.multiline,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.only(left: 20),
          // prefixIcon: prefixIcon ?? prefixIcon,
          hintStyle: TextStyle(
            color: hintColor,
          ),
        ),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
