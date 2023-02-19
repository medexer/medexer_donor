// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';

class CustomFormPasswordField extends StatefulWidget {
  final String hintText;
  bool showPassword;
  Color? background;
  ImageIcon? prefixIcon;
  final ImageIcon? suffixIcon;
  TextEditingController? controller;
  CustomFormPasswordField({
    super.key,
    this.prefixIcon,
    this.background,
    required this.suffixIcon,
    required this.showPassword,
    this.controller,
    required this.hintText,
  });

  @override
  State<CustomFormPasswordField> createState() =>
      _CustomFormPasswordFieldState();
}

class _CustomFormPasswordFieldState extends State<CustomFormPasswordField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 6.0.hp,
      decoration: BoxDecoration(
        color: widget.background ?? widget.background,
        border: Border.all(
          color: AppStyles.bgGray,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        obscureText: widget.showPassword ? widget.showPassword : false,
        controller: widget.controller ?? widget.controller,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                widget.showPassword = !widget.showPassword;
              });
            },
            child: widget.suffixIcon,
          ),
          hintStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        style: TextStyle(
          color: AppStyles.bgBlack,
        ),
      ),
    );
  }
}
