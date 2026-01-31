import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../themes/themes.dart';

class CancelButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? couleur;

  const CancelButton(
    this.title, {
    super.key,
    required this.onPressed,
    this.height,
    this.width,
    this.fontSize,
    this.couleur,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 12.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: appColorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.w),
            side: BorderSide(color: appColor),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize ?? 18.sp,
            color: appColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
