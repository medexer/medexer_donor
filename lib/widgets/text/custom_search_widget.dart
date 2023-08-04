// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  String? icon;
  bool? focusKeyboard;
  ImageIcon? prefixIcon;
  TextEditingController? controller;
  TextInputType? keyboardType;
  Function? onChangeHandler;
  CustomSearchField({
    super.key,
    this.icon,
    this.prefixIcon,
    this.controller,
    this.keyboardType,
    this.focusKeyboard,
    this.onChangeHandler,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      // width: double.maxFinite,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03),
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppStyles.bgGray,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2),
            child: ImageIcon(
              AssetImage("$icon"),
              size: MediaQuery.of(context).size.width * 0.06,
              color: AppStyles.bgBlack,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          SizedBox(
            // color: Colors.red,
            // margin: EdgeInsets.only(bottom: 0.5.hp),
            width: MediaQuery.of(context).size.width * 0.75,
            child: Center(
              child: TextFormField(
                autofocus: focusKeyboard ?? false,
                onChanged: (String value) {
                  onChangeHandler!(value);
                },
                controller: controller ?? controller,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: keyboardType ?? TextInputType.multiline,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  //contentPadding: EdgeInsets.all(15),
                  // prefixIcon: prefixIcon ?? prefixIcon,
                  hintStyle: TextStyle(
                    fontSize: 14.0,
                    color: AppStyles.bgGray,
                  ),
                ),
                style: TextStyle(
                  fontSize: 14.0,
                  color: AppStyles.bgBlack,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
