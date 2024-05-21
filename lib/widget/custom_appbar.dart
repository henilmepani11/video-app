import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';

class CustomAppBar extends AppBar {
  final Widget title;
  final bool centerTitle;
  final bool? leadingValue;
  final List<Widget>? actions;
  final Function leadingFunction;

  CustomAppBar(
      {Key? key,
      required this.title,
      this.actions,
      required this.centerTitle,
      this.leadingValue = false,
      required this.leadingFunction})
      : super(
          key: key,
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: centerTitle,
          title: title,
          leading: leadingValue == true
              ? IconButton(
                  splashColor: AppColor.transparent,
                  highlightColor: AppColor.transparent,
                  icon: SvgPicture.asset(AppAssets.backArrow),
                  onPressed: () {
                    Get.back();
                    leadingFunction();
                  },
                )
              : null,
          actions: actions,
        );
}
