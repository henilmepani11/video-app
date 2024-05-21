import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'app_color.dart';

// AppFontFamily
class AppFontFamily {
  static String get inter => "Inter";
  static String get interBold => "InterBold";
  static String get roboto => "Roboto";
}

// TextStyle
class CustomTextStyle {
  static TextStyle get txt20boldTitleColor => TextStyle(
      fontSize: 18,
      color: AppColor.titleColor,
      fontWeight: FontWeight.w700,
      fontFamily: AppFontFamily.interBold);

  static TextStyle get txt13boldWhite => TextStyle(
      fontSize: 15,
      color: AppColor.white,
      fontFamily: AppFontFamily.roboto,
      fontWeight: FontWeight.w500);

  static TextStyle get txt13boldWhite1 => TextStyle(
      fontSize: 15,
      color: AppColor.white,
      fontFamily: AppFontFamily.inter,
      fontWeight: FontWeight.w600);

  static TextStyle get txt15boldWhite1 => TextStyle(
      fontSize: 15.sp,
      color: AppColor.white,
      fontFamily: AppFontFamily.interBold,
      fontWeight: FontWeight.w600);

  static TextStyle get txt11boldPrimary => TextStyle(
      fontSize: 11.sp,
      color: AppColor.primaryColor,
      fontWeight: FontWeight.bold,
      fontFamily: AppFontFamily.interBold);

  static TextStyle get txt9boldPrimary => TextStyle(
      fontSize: 14,
      color: AppColor.primaryColor,
      fontWeight: FontWeight.w500,
      fontFamily: AppFontFamily.roboto);

  static TextStyle get txt15w500Primary => TextStyle(
      fontSize: 15,
      color: AppColor.primaryColor,
      fontWeight: FontWeight.w500,
      fontFamily: AppFontFamily.inter);

  static TextStyle get txt14boldWhite => TextStyle(
      fontSize: 15,
      color: AppColor.primaryColor,
      fontWeight: FontWeight.bold,
      fontFamily: AppFontFamily.inter);

  static TextStyle get txt12boldWhite => TextStyle(
      fontSize: 12.sp,
      color: AppColor.white,
      fontWeight: FontWeight.bold,
      fontFamily: AppFontFamily.interBold);

  static TextStyle get txt10boldWhite => TextStyle(
      fontSize: 10.sp,
      color: AppColor.white,
      fontWeight: FontWeight.bold,
      fontFamily: AppFontFamily.interBold);

  static TextStyle get txt12White => TextStyle(
      fontSize: 12.sp,
      color: AppColor.white,
      fontWeight: FontWeight.bold,
      fontFamily: AppFontFamily.inter);

  static TextStyle get txt15W500White => TextStyle(
      fontSize: 15,
      color: AppColor.white1,
      fontWeight: FontWeight.w600,
      fontFamily: AppFontFamily.inter);

  static TextStyle get txt15W600White => TextStyle(
      fontSize: 15.sp,
      color: AppColor.white,
      fontWeight: FontWeight.w600,
      fontFamily: AppFontFamily.inter);

  static TextStyle get txt15W600Grey => TextStyle(
      fontSize: 15,
      color: AppColor.textFieldHintColor.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontFamily: AppFontFamily.inter);

  static TextStyle get txt12W600Grey => TextStyle(
      fontSize: 14,
      color: AppColor.textFieldHintColor1,
      fontWeight: FontWeight.w400,
      fontFamily: AppFontFamily.roboto);

  static TextStyle get txt16W600White => TextStyle(
      fontSize: 18,
      color: AppColor.signInAccountTitleColor,
      fontWeight: FontWeight.w600,
      fontFamily: AppFontFamily.inter);

  static TextStyle get txt16W600primary => TextStyle(
      color: AppColor.primaryColor, fontWeight: FontWeight.w600, fontSize: 16);

  static TextStyle get txt14W600primary => TextStyle(
      color: AppColor.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 11.sp);

  static TextStyle get txt14W600primary1 => TextStyle(
      color: AppColor.primaryColor,
      fontFamily: AppFontFamily.inter,
      fontWeight: FontWeight.w600,
      fontSize: 11.sp);

  static TextStyle get txt14W600HintColor => TextStyle(
      color: AppColor.textFieldHintColor,
      fontWeight: FontWeight.w500,
      fontFamily: AppFontFamily.roboto,
      fontSize: 15);

  static TextStyle get txt11W600HintColorRoboto => TextStyle(
      color: AppColor.textFieldHintColor1,
      fontWeight: FontWeight.w500,
      fontFamily: AppFontFamily.roboto,
      fontSize: 14);

  static TextStyle get txt14W600HintColorRoboto => TextStyle(
      color: AppColor.linkHereTextField,
      fontFamily: AppFontFamily.roboto,
      fontWeight: FontWeight.w400,
      fontSize: 12);

  static TextStyle get txt14W600HintColor1 => TextStyle(
      color: AppColor.textFieldHintColor1,
      fontWeight: FontWeight.w500,
      fontFamily: AppFontFamily.inter,
      fontSize: 14);

  static TextStyle get txt12W600HintColor1 => TextStyle(
      color: AppColor.textFieldHintColor1,
      fontWeight: FontWeight.w500,
      fontFamily: AppFontFamily.inter,
      fontSize: 12);

  static TextStyle get txt14W700HintColor11 => TextStyle(
      color: AppColor.textFieldHintColor1,
      fontWeight: FontWeight.w700,
      fontFamily: AppFontFamily.inter,
      fontSize: 18);

  static TextStyle get txt13HintColor => TextStyle(
      color: AppColor.textFieldHintColor1,
      fontSize: 15,
      fontFamily: AppFontFamily.roboto,
      fontWeight: FontWeight.w400);

  static TextStyle get txt11HintColor => TextStyle(
      color: AppColor.textFieldHintColor1,
      fontSize: 13,
      fontFamily: AppFontFamily.roboto,
      fontWeight: FontWeight.w400);

  static TextStyle get txt14W400HintColor => TextStyle(
      color: AppColor.textFieldHintColor1,
      fontWeight: FontWeight.w400,
      fontFamily: AppFontFamily.roboto,
      fontSize: 14);
}

// BoderStyle
class CustomBoderStyle {
  static UnderlineInputBorder get underlineInputBorder => UnderlineInputBorder(
      borderSide: BorderSide(color: AppColor.primaryColor, width: 0.40.w));

  static UnderlineInputBorder
      get errorUnderlineInputBorder => UnderlineInputBorder(
          borderSide:
              BorderSide(color: AppColor.red.withOpacity(0.5), width: 0.40.w));

  static OutlineInputBorder get errorOutlineInputBorder => OutlineInputBorder(
      borderSide:
          BorderSide(color: AppColor.red.withOpacity(0.5), width: 0.40.w));

  static OutlineInputBorder get outlineInputBorder => OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.primaryColor.withOpacity(0.8)));

  static OutlineInputBorder get outlineInputBorder1 => OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.primaryColor.withOpacity(0.4)));

  static OutlineInputBorder get outlineInputBorder2 => OutlineInputBorder(
      borderRadius: BorderRadius.circular(3),
      borderSide: BorderSide(color: AppColor.chipColor));
}
