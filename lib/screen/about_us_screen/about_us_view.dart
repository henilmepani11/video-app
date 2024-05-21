import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/widget/custom_appbar.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor20,
      appBar: CustomAppBar(
          leadingFunction: () {},
          leadingValue: true,
          centerTitle: true,
          title: Text(AppString.aboutUs,
              style: CustomTextStyle.txt20boldTitleColor)),
      body: Padding(
        padding: EdgeInsets.only(left: 4.w, top: 15),
        child: Text(AppString.dummyText,
            style: CustomTextStyle.txt14W400HintColor),
      ),
    );
  }
}
