// ignore_for_file: must_be_immutable

import 'package:flutter/widgets.dart';
import 'package:medexer_donor/config/app_config.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  Color? color;
  double? size;
  int? maxLines;
  double? lineHeight;
  FontWeight? weight;
  TextAlign? alignment;

  CustomTextWidget({
    super.key,
    this.color,
    this.size,
    this.maxLines,
    this.weight,
    this.lineHeight,
    this.alignment,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 3,
      textAlign: alignment ?? TextAlign.left,
      style: TextStyle(
        color: color,
        height: lineHeight ?? 0,
        fontSize: size ?? 16.0.sp,
        fontWeight: weight ?? FontWeight.normal,
      ),
    );
  }
}
