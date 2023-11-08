import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resume_builder/res/theam/app_colors.dart';

abstract class AppTextStyle {
  static TextStyle largeTitleBlack = GoogleFonts.lato(
    textStyle: TextStyle(fontSize: 32, color: AppColors.blackColor),
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );
  static TextStyle titleBlack = const TextStyle(
      fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.blackColor);
  static TextStyle titleWhite = const TextStyle(
      fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.whiteColor);
  static TextStyle smallBlackText =
      const TextStyle(fontSize: 14, color: AppColors.blackColor);
  static TextStyle smallGreyText =
      const TextStyle(fontSize: 14, color: AppColors.greyColor);
  static TextStyle normalTitleText =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
}
