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
  int? maxLength;
  double? paddingLeft;
  double? paddingRight;
  double? borderRadius;
  double? fontSize;
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
    this.maxLength,
    this.paddingLeft,
    this.paddingRight,
    this.readOnly,
    this.fontSize,
    this.hintText,
    this.controller,
    this.borderRadius,
    this.keyboardType,
    required this.maxLines,
    required this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.maxFinite,
      height: height ??
          (screenHeight < 600 ? (screenHeight * 0.08) : (screenHeight * 0.06)),
      // height: height ?? 6.0.hp,
      decoration: BoxDecoration(
        color: background ?? background,
        border: Border.all(
          color: AppStyles.bgGray,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 25),
      ),
      child: Center(
        child: TextFormField(
          readOnly: readOnly ?? false,
          maxLines: maxLines,
          maxLength: maxLength ?? 255,
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
            counterText: "",
            // prefixIcon: prefixIcon ?? prefixIcon,
            hintStyle: TextStyle(
              color: hintColor,
              fontSize: constructFontSize(context, fontSize ?? 14),
            ),
          ),
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: constructFontSize(context, fontSize ?? 16),
          ),
        ),
      ),
    );
  }
}
