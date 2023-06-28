// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';

class CustomFormTextField extends StatelessWidget {
  String? hintText;
  // ignore: prefer_typing_uninitialized_variables
  var maxLines;
  bool? readOnly;
  Color? textColor;
  Color? background;
  Color? hintColor;
  double? height;
  double? paddingTop;
  double? paddingLeft;
  double? paddingRight;
  double? borderRadius;
  ImageIcon? prefixIcon;
  TextEditingController? controller;
  TextInputType? keyboardType;
  CustomFormTextField({
    super.key,
    this.prefixIcon,
    this.height,
    this.background,
    this.textColor,
    this.paddingTop,
    this.paddingLeft,
    this.paddingRight,
    this.readOnly,
    this.hintText,
    this.controller,
    this.borderRadius,
    this.keyboardType,
    required this.maxLines,
    required this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: height ?? 6.0.hp,
      decoration: BoxDecoration(
        color: background ?? background,
        border: Border.all(
          color: AppStyles.bgGray,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 25),
      ),
      child: TextFormField(
        readOnly: readOnly ?? false,
        maxLines: maxLines,
        controller: controller ?? controller,
        keyboardType: keyboardType ?? TextInputType.multiline,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? '',
          contentPadding: EdgeInsets.only(
            left: paddingLeft ?? 20,
            right: paddingRight ?? 0,
            top: paddingTop ?? 0,
          ),
          // prefixIcon: prefixIcon ?? prefixIcon,
          hintStyle: TextStyle(
            color: hintColor,
          ),
        ),
        style: TextStyle(
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
