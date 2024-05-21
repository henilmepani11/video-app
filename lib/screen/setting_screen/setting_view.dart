import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/route/route_constant.dart';
import 'package:video_app/widget/custom_appbar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          leadingFunction: () {},
          leadingValue: true,
          centerTitle: true,
          title: Text(AppString.settings,
              style: CustomTextStyle.txt20boldTitleColor)),
      body: Padding(
        padding: EdgeInsets.only(left: 5.w, top: 12, right: 5.w),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(AppRouteString.resetPasswordScreen);
          },
          child: Container(
            height: 65,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColor.backgroundColor21,
                borderRadius: BorderRadius.circular(6)),
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  SvgPicture.asset(AppAssets.lock),
                  const SizedBox(width: 10),
                  Text(
                    AppString.resetPassword,
                    style: CustomTextStyle.txt14W600HintColor.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColor.textFieldHintColor1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
